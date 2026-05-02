package com.example.demo.controller;

import com.example.demo.entity.Student;
import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;

    @PostMapping("/register")
    public String registerStudent(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("course") String course,
            @RequestParam(value = "phone", required = false) String phone) {

        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setCourse(course);
        student.setPhone(phone);

        studentRepository.save(student);

        return "User Registered: " + name + " | Email: " + email;
    }
}
