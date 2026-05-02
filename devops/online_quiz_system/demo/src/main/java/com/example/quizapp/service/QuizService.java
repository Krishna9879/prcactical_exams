package com.example.quizapp.service;

import com.example.quizapp.model.Option;
import com.example.quizapp.model.Question;
import com.example.quizapp.model.Quiz;

import java.util.List;

/**
 * Service interface for quiz management operations.
 */
public interface QuizService {

    // Quiz CRUD
    List<Quiz> getAllQuizzes();

    Quiz getQuizById(Long id);

    Quiz createQuiz(Quiz quiz);

    Quiz updateQuiz(Long id, String title, String description);

    void deleteQuiz(Long id);

    // Question management
    Question addQuestion(Long quizId, String questionText, List<String> optionTexts, int correctIndex);

    Question getQuestionById(Long id);

    void deleteQuestion(Long questionId);

    List<Question> getQuestionsByQuizId(Long quizId);

    // Option management
    Option getOptionById(Long id);
}
