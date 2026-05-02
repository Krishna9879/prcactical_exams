package com.example.quizapp.controller;

import com.example.quizapp.dto.RegisterDTO;
import com.example.quizapp.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller handling authentication - login and registration pages.
 */
@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    /**
     * Root URL redirects to login page.
     */
    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    /**
     * Shows the login page.
     */
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    /**
     * Shows the registration page with an empty form.
     */
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "register";
    }

    /**
     * Processes user registration with validation.
     */
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
                               BindingResult result,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        // Validate passwords match
        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            model.addAttribute("error", "Passwords do not match!");
            return "register";
        }

        // Check if username already exists
        if (authService.existsByUsername(registerDTO.getUsername())) {
            model.addAttribute("error", "Username already exists!");
            return "register";
        }

        // Check for validation errors
        if (result.hasErrors()) {
            return "register";
        }

        // Register the user
        authService.registerUser(registerDTO);
        redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/login";
    }
}
