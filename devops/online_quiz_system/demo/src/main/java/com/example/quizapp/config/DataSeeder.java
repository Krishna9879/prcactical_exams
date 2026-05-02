package com.example.quizapp.config;

import com.example.quizapp.model.*;
import com.example.quizapp.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * Seeds the database with sample data on application startup.
 * Creates an admin user, a regular user, and 2 sample quizzes with questions.
 * Only seeds if the database is empty (no users exist).
 */
@Component
public class DataSeeder implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        // Only seed if no users exist
        if (userRepository.count() > 0) {
            return;
        }

        System.out.println("=== Seeding database with sample data ===");

        // Create admin user (username: admin, password: admin123)
        User admin = User.builder()
                .username("admin")
                .password(passwordEncoder.encode("admin123"))
                .role("ADMIN")
                .build();
        userRepository.save(admin);

        // Create regular user (username: user, password: user123)
        User user = User.builder()
                .username("user")
                .password(passwordEncoder.encode("user123"))
                .role("USER")
                .build();
        userRepository.save(user);

        // ==================== Quiz 1: Java Programming ====================
        Quiz quiz1 = Quiz.builder()
                .title("Java Programming Fundamentals")
                .description("Test your knowledge of core Java concepts including OOP, data types, and control flow.")
                .build();
        quiz1 = quizRepository.save(quiz1);

        createQuestion(quiz1, "What is the default value of an int variable in Java?",
                Arrays.asList("0", "null", "1", "undefined"), 0);

        createQuestion(quiz1, "Which keyword is used to inherit a class in Java?",
                Arrays.asList("implements", "extends", "inherits", "super"), 1);

        createQuestion(quiz1, "What is the size of a float variable in Java?",
                Arrays.asList("8 bits", "16 bits", "32 bits", "64 bits"), 2);

        createQuestion(quiz1, "Which method is the entry point of a Java program?",
                Arrays.asList("start()", "init()", "main()", "run()"), 2);

        createQuestion(quiz1, "Which of these is NOT a Java access modifier?",
                Arrays.asList("public", "private", "friend", "protected"), 2);

        // ==================== Quiz 2: Web Development ====================
        Quiz quiz2 = Quiz.builder()
                .title("Web Development Basics")
                .description("Test your understanding of HTML, CSS, JavaScript, and web fundamentals.")
                .build();
        quiz2 = quizRepository.save(quiz2);

        createQuestion(quiz2, "What does HTML stand for?",
                Arrays.asList("Hyper Text Markup Language", "High Tech Modern Language",
                        "Hyper Transfer Markup Language", "Home Tool Markup Language"), 0);

        createQuestion(quiz2, "Which CSS property is used to change the text color?",
                Arrays.asList("font-color", "text-color", "color", "foreground-color"), 2);

        createQuestion(quiz2, "Which HTML tag is used to create a hyperlink?",
                Arrays.asList("<link>", "<href>", "<a>", "<url>"), 2);

        createQuestion(quiz2, "What does CSS stand for?",
                Arrays.asList("Computer Style Sheets", "Cascading Style Sheets",
                        "Creative Style Sheets", "Colorful Style Sheets"), 1);

        createQuestion(quiz2, "Which JavaScript method is used to write to the console?",
                Arrays.asList("console.write()", "console.log()", "console.print()", "console.output()"), 1);

        System.out.println("=== Database seeding complete ===");
        System.out.println("Admin login  -> username: admin, password: admin123");
        System.out.println("User  login  -> username: user,  password: user123");
    }

    /**
     * Helper method to create a question with its options.
     */
    private void createQuestion(Quiz quiz, String questionText, List<String> optionTexts, int correctIndex) {
        Question question = Question.builder()
                .quiz(quiz)
                .questionText(questionText)
                .build();
        question = questionRepository.save(question);

        for (int i = 0; i < optionTexts.size(); i++) {
            Option option = Option.builder()
                    .question(question)
                    .optionText(optionTexts.get(i))
                    .isCorrect(i == correctIndex)
                    .build();
            optionRepository.save(option);
        }
    }
}
