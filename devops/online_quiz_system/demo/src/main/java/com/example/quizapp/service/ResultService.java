package com.example.quizapp.service;

import com.example.quizapp.dto.ResultDTO;
import com.example.quizapp.model.Result;

import java.util.List;
import java.util.Map;

/**
 * Service interface for quiz result operations.
 */
public interface ResultService {

    Result submitQuiz(Long userId, Long quizId, Map<Long, Long> answers);

    boolean hasUserAttemptedQuiz(Long userId, Long quizId);

    List<ResultDTO> getResultsByUserId(Long userId);

    List<ResultDTO> getAllResults();

    List<ResultDTO> getResultsByQuizId(Long quizId);
}
