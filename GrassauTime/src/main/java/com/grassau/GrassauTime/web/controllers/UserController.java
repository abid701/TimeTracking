package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    final private UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/user")
    public String showUsers(Model model){
        Iterable<User> allUsers = userService.getAllUsers();
        model.addAttribute("allUsers", allUsers);

        return "view/user.html";
    }
}
