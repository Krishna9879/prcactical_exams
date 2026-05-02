package com.example.quizapp.controller;

import com.example.quizapp.model.User;
import com.example.quizapp.service.AuthService;
import com.example.quizapp.service.ResultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

/**
 * Controller for viewing quiz results.
 * Users see their own results; admins see all results.
 */
@Controller
public class ResultController {

    @Autowired
    private ResultService resultService;

    @Autowired
    private AuthService authService;

    /**
     * User views their own quiz results.
     */
    @GetMapping("/user/results")
    public String userResults(Model model, Principal principal) {
        User user = authService.findByUsername(principal.getName());
        model.addAttribute("results", resultService.getResultsByUserId(user.getId()));
        return "user/my-results";
    }
}
