package com.example.quizapp.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * Data Transfer Object for creating/editing quizzes.
 */
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class QuizDTO {

    private Long id;

    @NotBlank(message = "Quiz title is required")
    private String title;

    private String description;
}
