package com.example.quizapp.repository;

import com.example.quizapp.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository for Quiz entity operations.
 */
@Repository
public interface QuizRepository extends JpaRepository<Quiz, Long> {
}
