package com.example.quizapp.controller;

import com.example.quizapp.model.Question;
import com.example.quizapp.model.Quiz;
import com.example.quizapp.model.User;
import com.example.quizapp.service.AuthService;
import com.example.quizapp.service.QuizService;
import com.example.quizapp.service.ResultService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.*;

/**
 * Controller managing quiz operations for both ADMIN and USER roles.
 * Admin: Create, edit, delete quizzes and add questions with options.
 * User: Browse, attempt quizzes, and submit answers.
 */
@Controller
public class QuizController {

    @Autowired
    private QuizService quizService;

    @Autowired
    private AuthService authService;

    @Autowired
    private ResultService resultService;

    // ======================== ADMIN ENDPOINTS ========================

    /**
     * Admin dashboard showing overview statistics.
     */
    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        List<Quiz> quizzes = quizService.getAllQuizzes();
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("totalQuizzes", quizzes.size());
        model.addAttribute("totalResults", resultService.getAllResults().size());
        return "admin/dashboard";
    }

    /**
     * Admin quiz list page.
     */
    @GetMapping("/admin/quizzes")
    public String adminQuizList(Model model) {
        model.addAttribute("quizzes", quizService.getAllQuizzes());
        return "admin/quiz-list";
    }

    /**
     * Show form to create a new quiz.
     */
    @GetMapping("/admin/quizzes/new")
    public String showCreateQuizForm(Model model) {
        model.addAttribute("quiz", new Quiz());
        return "admin/quiz-form";
    }

    /**
     * Process new quiz creation.
     */
    @PostMapping("/admin/quizzes/new")
    public String createQuiz(@RequestParam String title,
                             @RequestParam String description,
                             RedirectAttributes redirectAttributes) {
        Quiz quiz = Quiz.builder().title(title).description(description).build();
        quiz = quizService.createQuiz(quiz);
        redirectAttributes.addFlashAttribute("success", "Quiz created successfully! Now add questions.");
        return "redirect:/admin/quizzes/" + quiz.getId() + "/questions/new";
    }

    /**
     * Show form to edit an existing quiz.
     */
    @GetMapping("/admin/quizzes/{id}/edit")
    public String showEditQuizForm(@PathVariable Long id, Model model) {
        Quiz quiz = quizService.getQuizById(id);
        model.addAttribute("quiz", quiz);
        return "admin/quiz-form";
    }

    /**
     * Process quiz update.
     */
    @PostMapping("/admin/quizzes/{id}/edit")
    public String updateQuiz(@PathVariable Long id,
                             @RequestParam String title,
                             @RequestParam String description,
                             RedirectAttributes redirectAttributes) {
        quizService.updateQuiz(id, title, description);
        redirectAttributes.addFlashAttribute("success", "Quiz updated successfully!");
        return "redirect:/admin/quizzes";
    }

    /**
     * Delete a quiz and all its questions/options.
     */
    @GetMapping("/admin/quizzes/{id}/delete")
    public String deleteQuiz(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        quizService.deleteQuiz(id);
        redirectAttributes.addFlashAttribute("success", "Quiz deleted successfully!");
        return "redirect:/admin/quizzes";
    }

    /**
     * Show form to add a new question to a quiz.
     */
    @GetMapping("/admin/quizzes/{quizId}/questions/new")
    public String showAddQuestionForm(@PathVariable Long quizId, Model model) {
        Quiz quiz = quizService.getQuizById(quizId);
        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", quiz.getQuestions());
        return "admin/question-form";
    }

    /**
     * Process adding a new question with 4 options.
     */
    @PostMapping("/admin/quizzes/{quizId}/questions/new")
    public String addQuestion(@PathVariable Long quizId,
                              @RequestParam String questionText,
                              @RequestParam("option") List<String> options,
                              @RequestParam int correctOption,
                              RedirectAttributes redirectAttributes) {
        quizService.addQuestion(quizId, questionText, options, correctOption);
        redirectAttributes.addFlashAttribute("success", "Question added successfully!");
        return "redirect:/admin/quizzes/" + quizId + "/questions/new";
    }

    /**
     * Delete a specific question from a quiz.
     */
    @GetMapping("/admin/quizzes/{quizId}/questions/{questionId}/delete")
    public String deleteQuestion(@PathVariable Long quizId,
                                 @PathVariable Long questionId,
                                 RedirectAttributes redirectAttributes) {
        quizService.deleteQuestion(questionId);
        redirectAttributes.addFlashAttribute("success", "Question deleted successfully!");
        return "redirect:/admin/quizzes/" + quizId + "/questions/new";
    }

    /**
     * Admin view of all results.
     */
    @GetMapping("/admin/results")
    public String adminResults(Model model) {
        model.addAttribute("results", resultService.getAllResults());
        return "admin/results";
    }

    // ======================== USER ENDPOINTS ========================

    /**
     * User dashboard showing available quizzes and recent results.
     */
    @GetMapping("/user/dashboard")
    public String userDashboard(Model model, Principal principal) {
        User user = authService.findByUsername(principal.getName());
        List<Quiz> quizzes = quizService.getAllQuizzes();

        // Mark quizzes that the user has already attempted
        Map<Long, Boolean> attemptedMap = new HashMap<>();
        for (Quiz quiz : quizzes) {
            attemptedMap.put(quiz.getId(), resultService.hasUserAttemptedQuiz(user.getId(), quiz.getId()));
        }

        model.addAttribute("quizzes", quizzes);
        model.addAttribute("attemptedMap", attemptedMap);
        model.addAttribute("username", user.getUsername());
        return "user/dashboard";
    }

    /**
     * User quiz list showing all available quizzes.
     */
    @GetMapping("/user/quizzes")
    public String userQuizList(Model model, Principal principal) {
        User user = authService.findByUsername(principal.getName());
        List<Quiz> quizzes = quizService.getAllQuizzes();

        Map<Long, Boolean> attemptedMap = new HashMap<>();
        for (Quiz quiz : quizzes) {
            attemptedMap.put(quiz.getId(), resultService.hasUserAttemptedQuiz(user.getId(), quiz.getId()));
        }

        model.addAttribute("quizzes", quizzes);
        model.addAttribute("attemptedMap", attemptedMap);
        return "user/quiz-list";
    }

    /**
     * Start taking a quiz - loads all questions with options.
     * Prevents multiple attempts for the same quiz.
     */
    @GetMapping("/user/quizzes/{id}/take")
    public String takeQuiz(@PathVariable Long id, Model model, Principal principal,
                           RedirectAttributes redirectAttributes) {
        User user = authService.findByUsername(principal.getName());

        // Check if user has already attempted this quiz
        if (resultService.hasUserAttemptedQuiz(user.getId(), id)) {
            redirectAttributes.addFlashAttribute("error", "You have already attempted this quiz!");
            return "redirect:/user/quizzes";
        }

        Quiz quiz = quizService.getQuizById(id);

        if (quiz.getQuestions().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "This quiz has no questions yet!");
            return "redirect:/user/quizzes";
        }

        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", quiz.getQuestions());
        return "user/take-quiz";
    }

    /**
     * Submit quiz answers, calculate score, and show results.
     */
    @PostMapping("/user/quizzes/{id}/submit")
    public String submitQuiz(@PathVariable Long id,
                             HttpServletRequest request,
                             Principal principal,
                             RedirectAttributes redirectAttributes) {
        User user = authService.findByUsername(principal.getName());

        // Prevent duplicate submission
        if (resultService.hasUserAttemptedQuiz(user.getId(), id)) {
            redirectAttributes.addFlashAttribute("error", "You have already attempted this quiz!");
            return "redirect:/user/quizzes";
        }

        Quiz quiz = quizService.getQuizById(id);

        // Collect answers from request parameters: answer_<questionId> = optionId
        Map<Long, Long> answers = new HashMap<>();
        for (Question question : quiz.getQuestions()) {
            String paramValue = request.getParameter("answer_" + question.getId());
            if (paramValue != null && !paramValue.isEmpty()) {
                answers.put(question.getId(), Long.parseLong(paramValue));
            }
        }

        // Submit and calculate score
        var result = resultService.submitQuiz(user.getId(), id, answers);

        redirectAttributes.addFlashAttribute("success",
                "Quiz submitted! Your score: " + result.getScore() + " / " + quiz.getQuestions().size());
        return "redirect:/user/results";
    }
}
