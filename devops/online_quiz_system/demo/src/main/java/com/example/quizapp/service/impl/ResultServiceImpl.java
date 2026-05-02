package com.example.quizapp.service.impl;

import com.example.quizapp.dto.ResultDTO;
import com.example.quizapp.model.*;
import com.example.quizapp.repository.ResultRepository;
import com.example.quizapp.service.QuizService;
import com.example.quizapp.service.ResultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Implementation of ResultService handling quiz submission, scoring, and result retrieval.
 * Automatically evaluates answers against correct options and calculates scores.
 */
@Service
@Transactional
public class ResultServiceImpl implements ResultService {

    @Autowired
    private ResultRepository resultRepository;

    @Autowired
    private QuizService quizService;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public Result submitQuiz(Long userId, Long quizId, Map<Long, Long> answers) {
        Quiz quiz = quizService.getQuizById(quizId);
        List<Question> questions = quiz.getQuestions();

        int score = 0;

        // Calculate score by comparing selected options with correct ones
        for (Question question : questions) {
            Long selectedOptionId = answers.get(question.getId());
            if (selectedOptionId != null) {
                Option selectedOption = quizService.getOptionById(selectedOptionId);
                if (selectedOption != null && selectedOption.getIsCorrect()) {
                    score++;
                }
            }
        }

        // Build and save the result
        Result result = Result.builder()
                .user(User.builder().id(userId).build())
                .quiz(quiz)
                .score(score)
                .build();

        return resultRepository.save(result);
    }

    @Override
    public boolean hasUserAttemptedQuiz(Long userId, Long quizId) {
        return resultRepository.existsByUserIdAndQuizId(userId, quizId);
    }

    @Override
    public List<ResultDTO> getResultsByUserId(Long userId) {
        return resultRepository.findByUserId(userId).stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<ResultDTO> getAllResults() {
        return resultRepository.findAll().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<ResultDTO> getResultsByQuizId(Long quizId) {
        return resultRepository.findByQuizId(quizId).stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Converts a Result entity to a ResultDTO with calculated percentage.
     */
    private ResultDTO toDTO(Result result) {
        int totalQuestions = result.getQuiz().getQuestions().size();
        double percentage = totalQuestions > 0 ? (result.getScore() * 100.0 / totalQuestions) : 0;

        return ResultDTO.builder()
                .id(result.getId())
                .username(result.getUser().getUsername())
                .quizTitle(result.getQuiz().getTitle())
                .score(result.getScore())
                .totalQuestions(totalQuestions)
                .percentage(Math.round(percentage * 100.0) / 100.0)
                .attemptedAt(result.getAttemptedAt() != null ? result.getAttemptedAt().format(FORMATTER) : "N/A")
                .build();
    }
}
