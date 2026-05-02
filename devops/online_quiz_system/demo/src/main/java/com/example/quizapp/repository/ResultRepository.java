package com.example.quizapp.repository;

import com.example.quizapp.model.Result;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for Result entity operations.
 */
@Repository
public interface ResultRepository extends JpaRepository<Result, Long> {

    List<Result> findByUserId(Long userId);

    List<Result> findByQuizId(Long quizId);

    boolean existsByUserIdAndQuizId(Long userId, Long quizId);

    /**
     * Delete all results for a given quiz (called before deleting the quiz itself
     * to avoid FK constraint violations).
     */
    void deleteByQuizId(Long quizId);
}
