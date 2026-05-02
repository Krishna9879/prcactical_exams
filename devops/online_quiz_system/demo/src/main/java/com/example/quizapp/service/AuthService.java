package com.example.quizapp.service;

import com.example.quizapp.dto.RegisterDTO;
import com.example.quizapp.model.User;

/**
 * Service interface for authentication operations.
 */
public interface AuthService {

    User registerUser(RegisterDTO registerDTO);

    User findByUsername(String username);

    boolean existsByUsername(String username);
}
