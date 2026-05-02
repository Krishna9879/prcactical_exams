package com.example.quizapp.dto;

import lombok.*;

/**
 * Data Transfer Object for displaying quiz results.
 */
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class ResultDTO {

    private Long id;
    private String username;
    private String quizTitle;
    private Integer score;
    private Integer totalQuestions;
    private String attemptedAt;
    private Double percentage;
}
