package com.example.quizapp.model;

import jakarta.persistence.*;
import lombok.*;

/**
 * Option entity representing one answer choice for a Question.
 * Tracks whether this option is the correct answer.
 */
@Entity
@Table(name = "options")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Option {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;

    @Column(name = "option_text", nullable = false, length = 500)
    private String optionText;

    @Column(name = "is_correct", nullable = false)
    private Boolean isCorrect;
}
