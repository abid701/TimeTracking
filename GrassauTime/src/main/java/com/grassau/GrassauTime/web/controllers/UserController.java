package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.enums.Role;
import com.grassau.GrassauTime.services.EmployeeService;
import com.grassau.GrassauTime.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;



/**
 * Controller class to handle user-related operations.
 * Provides endpoints for listing users and adding new users.
 */
@Controller
public class UserController {

    final private UserService userService;
    final private EmployeeService employeeService;

    /**
     * Constructor-based dependency injection for UserService and EmployeeService.
     * This constructor allow us to get access to the methods in the respective service classes
     *
     * @param userService      Service for user-related operations.
     * @param employeeService  Service for employee-related operations.
     */
    public UserController(UserService userService, EmployeeService employeeService){
        this.userService = userService;
        this.employeeService = employeeService;
    }

    /**
     * Handles GET requests to "/user" and retrieves a list of all users.
     *
     * @param model Model object to pass user data to the view.
     * @return The user list page (view/user.html).
     */
    @GetMapping("/user")
    public String showUsers(Model model){
        Iterable<User> allUsers = userService.getAllUsers();
        model.addAttribute("allUsers", allUsers);

        return "view/user.html";
    }

    /**
     * Handles POST requests to "/user/add" to create a new user.
     *
     * @param username   The username of the new user.
     * @param password   The password of the new user (will be encoded before saving).
     * @param role       The role of the user (e.g., "user" or "admin").
     * @param employeeId (Optional) The employee ID associated with the user. I decided to use String, for simplicity
     *                   when no employee ID is provided, but if there is an employee ID provided, I have later
     *                   converted it to an integer, so it can be saved in the database
     * @return Redirects to the user list page after saving the new user.
     */
    @PostMapping("/user/add")
    public String addUser(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String role,
            @RequestParam(required = false) String employeeId){

        User newUser = new User();

        // Encrypt the password before saving
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword = encoder.encode(password);

        newUser.setUsername(username);
        newUser.setPassword(encodedPassword);

        // Assign role based on input
        if (role.equals("user")){
            newUser.setRole(Role.USER);
        }
        else if (role.equals("admin")){
            newUser.setRole(Role.ROLE_ADMIN);
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

        return "redirect:/user";
    }

}
