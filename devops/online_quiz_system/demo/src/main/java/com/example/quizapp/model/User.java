package com.example.quizapp.model;

import jakarta.persistence.*;
import lombok.*;

/**
 * User entity representing registered users of the quiz system.
 * Supports role-based access control with ADMIN and USER roles.
 */
@Entity
@Table(name = "users")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, length = 20)
    private String role; // "ADMIN" or "USER"
}
