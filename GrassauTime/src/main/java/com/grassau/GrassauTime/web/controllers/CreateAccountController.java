package com.grassau.GrassauTime.web.controllers;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.enums.Role;
import com.grassau.GrassauTime.services.EmployeeService;
import com.grassau.GrassauTime.services.UserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
public class CreateAccountController {

    final private UserService userService;
    final private EmployeeService employeeService;

    CreateAccountController(UserService userService, EmployeeService employeeService){
        this.userService = userService;
        this.employeeService = employeeService;
    }

    @GetMapping("/createAccount")
    public String createAccount(){
        return "view/createAccount.html";
    }

    @PostMapping("/createAccount/add")
    public String addUser(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String role,
            @RequestParam(required = false) String employeeId,
            Principal principal){ // get logged user

        User newUser = new User();

        // Encrypt the password before saving
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encodedPassword = encoder.encode(password);

        newUser.setUsername(username);
        newUser.setPassword(encodedPassword);

        // Check if an admin exists in the system
        boolean doesAdminExists = userService.doesAdminExists();

        try {

            if ("admin".equals(role)) {
                // If no admin exists, allow creation
                if (!doesAdminExists) {
                    newUser.setRole(Role.ADMIN);
                }
                // If an admin exists, only another admin can create a new admin
                else if (principal != null) {
                    User currentUser = userService.getUserByUsername(principal.getName());
                    if (currentUser.getRole() == Role.ADMIN) {
                        newUser.setRole(Role.ADMIN);
                    } else {
                        return "redirect:/error/403"; // Access denied if not an admin
                    }
                } else {
                    return "redirect:/error/403"; // If no principal, block admin creation
                }
            } else {
                newUser.setRole(Role.USER);
            }

            // Associate user with an employee if provided
            if (employeeId != null && !employeeId.trim().isEmpty()){
                /* We need to convert employeeId to an integer before using setEmployee method cause it only takes
                   integer as argument */
                int convertedEmployeeId = Integer.parseInt(employeeId);
                Employee employee = employeeService.getEmployeeById(convertedEmployeeId);
                newUser.setEmployee(employee);
            }


            // Save the user to the database
            userService.saveUser(newUser);
            System.out.println("it works");
        } catch (Exception e) {
            System.out.println("it works");

            return "error/userAlreadyExists.html";
        }

        return "view/login.html";
    }

}
