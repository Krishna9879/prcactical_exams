package com.example.quizapp.service.impl;

import com.example.quizapp.model.Option;
import com.example.quizapp.model.Question;
import com.example.quizapp.model.Quiz;
import com.example.quizapp.repository.OptionRepository;
import com.example.quizapp.repository.QuestionRepository;
import com.example.quizapp.repository.QuizRepository;
import com.example.quizapp.repository.ResultRepository;
import com.example.quizapp.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of QuizService managing quiz, question, and option CRUD operations.
 */
@Service
@Transactional
public class QuizServiceImpl implements QuizService {

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private ResultRepository resultRepository;

    @Override
    public List<Quiz> getAllQuizzes() {
        return quizRepository.findAll();
    }

    @Override
    public Quiz getQuizById(Long id) {
        return quizRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Quiz not found with id: " + id));
    }

    @Override
    public Quiz createQuiz(Quiz quiz) {
        return quizRepository.save(quiz);
    }

    @Override
    public Quiz updateQuiz(Long id, String title, String description) {
        Quiz quiz = getQuizById(id);
        quiz.setTitle(title);
        quiz.setDescription(description);
        return quizRepository.save(quiz);
    }

    @Override
    public void deleteQuiz(Long id) {
        // Delete results first to avoid FK constraint violation
        resultRepository.deleteByQuizId(id);
        // deleteById triggers CascadeType.ALL → deletes questions → options
        quizRepository.deleteById(id);
    }

    @Override
    public Question addQuestion(Long quizId, String questionText, List<String> optionTexts, int correctIndex) {
        Quiz quiz = getQuizById(quizId);

        Question question = Question.builder()
                .quiz(quiz)
                .questionText(questionText)
                .options(new ArrayList<>())
                .build();
        question = questionRepository.save(question);

        // Create 4 options for the question
        for (int i = 0; i < optionTexts.size(); i++) {
            Option option = Option.builder()
                    .question(question)
                    .optionText(optionTexts.get(i))
                    .isCorrect(i == correctIndex)
                    .build();
            optionRepository.save(option);
            question.getOptions().add(option);
        }

        return question;
    }

    @Override
    public Question getQuestionById(Long id) {
        return questionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Question not found with id: " + id));
    }

    @Override
    public void deleteQuestion(Long questionId) {
        questionRepository.deleteById(questionId);
    }

    @Override
    public List<Question> getQuestionsByQuizId(Long quizId) {
        return questionRepository.findByQuizId(quizId);
    }

    @Override
    public Option getOptionById(Long id) {
        return optionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Option not found with id: " + id));
    }
}
