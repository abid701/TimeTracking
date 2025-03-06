package com.grassau.GrassauTime.web.controllers;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import com.grassau.GrassauTime.db.repositories.UserRepository;
import com.grassau.GrassauTime.enums.Role;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserRepository userRepository;
    private final EmployeeRepository employeeRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthController(UserRepository userRepository, EmployeeRepository employeeRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.employeeRepository = employeeRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/registerEmployee")
    public String registerEmployee(@RequestParam String firstName, @RequestParam String employeePosition) {
        Employee employee = new Employee(firstName, employeePosition);
        employeeRepository.save(employee);
        return "Employee added successfully!";
    }

    @PostMapping("/registerUser")
    public String registerUser(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam Role role,
            @RequestParam(required = false) Integer employeeId) {

        Optional<Employee> employee = employeeId != null ? employeeRepository.findById(employeeId) : Optional.empty();
        User user = new User(username, passwordEncoder.encode(password), role, employee.orElse(null));
        userRepository.save(user);
        return "User account created!";
    }
}
