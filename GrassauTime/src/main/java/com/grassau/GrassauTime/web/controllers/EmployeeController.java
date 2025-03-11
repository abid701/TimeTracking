package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.services.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;


//@Controller
//public class EmployeeController {
//
//    private EmployeeService employeeService;
//
//    public EmployeeController(EmployeeService employeeService){
//        this.employeeService = employeeService;
//    }
//
//
//
//    @GetMapping("/employee")
//    public String showEmployees(Model model){
//
//        Iterable<Employee> allEmployees = employeeService.getAllEmployee();
//        model.addAttribute("allEmployees", allEmployees);
//        return "view/employee2.html";
//    }
//}



// My last Version of code is below
@Controller
public class EmployeeController {

    private final EmployeeService employeeService;

    public EmployeeController(EmployeeService employeeService){
        this.employeeService = employeeService;
    }

//    @GetMapping("/employee")
//    public String showEmployees(Model model) {
//
//        Iterable<Employee> allEmployees = employeeService.getAllEmployee();
//
//        model.addAttribute("allEmployees", allEmployees);
//        return "view/employee.html";
//    }

    @GetMapping("/employee")
    public String showEmployees(@RequestParam(required = false) String isActive,
                                Model model){

        /* TODO: write clean code
        /*

        this method checks if an employee is active or inactive and will return the result

        */



        if (isActive == null || isActive.equalsIgnoreCase("all")) {
            // Show all employees if isActive is null or "all"
            Iterable<Employee> allEmployees = employeeService.getAllEmployee();
        }
        else if (isActive.equals("true") || isActive.equals("false")){
            // Convert the parameter to Boolean (true/false)
            boolean status = Boolean.parseBoolean(isActive);
            Iterable<Employee> allEmployees = employeeService.getEmployeesByIsActive(status);

            model.addAttribute("allEmployees", allEmployees);
            return "view/employee.html";
        }



        Iterable<Employee> allEmployees = employeeService.getAllEmployee();
        model.addAttribute("allEmployees", allEmployees);
        System.out.println(allEmployees.toString());
        return "view/employee.html";
    }

    // Search by employee first name
    @GetMapping("/employee/search")
    public String searchByEmployeeFirstName(@RequestParam(required = false) String firstName, Model model){
        Iterable<Employee> allEmployees = employeeService.searchByFirstName(firstName);
        model.addAttribute("allEmployees", allEmployees);
        return "view/employee.html";
    }

    @PostMapping("/employee/add")
    public String addEmployee(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String email,
            @RequestParam String employeePosition,
            @RequestParam(required = false, defaultValue = "0") float hourlyRate,
            @RequestParam String dateHired,
            @RequestParam(required = false) String cardId,
            @RequestParam boolean isActive) {

        Employee newEmployee = new Employee();
        newEmployee.setFirstName(firstName);
        newEmployee.setLastName(lastName);
        newEmployee.setEmail(email);
        newEmployee.setEmployeePosition(employeePosition);
        newEmployee.setHourlyRate(hourlyRate);
        newEmployee.setDateHired(LocalDate.parse(dateHired));
        newEmployee.setCardId(cardId);
        newEmployee.setActive(isActive);

        employeeService.saveEmployee(newEmployee);

        return "redirect:/employee"; // Redirects back to the employee list page
    }

    @GetMapping("/employee/delete/{id}")
    public String deleteEmployee(@PathVariable int id) {
        employeeService.deleteEmployee(id);
        return "redirect:/employee";
    }
}
