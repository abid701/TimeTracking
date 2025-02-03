package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Employees;
import com.grassau.GrassauTime.services.EmployeesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeesController {

    private EmployeesService employeesService;

    public EmployeesController(EmployeesService employeesService){
        this.employeesService = employeesService;
    }



    @GetMapping("/employees")
    public String showEmployees(Model model){

        Iterable<Employees> allEmployees = employeesService.getAllEmployees();
        model.addAttribute("allEmployees", allEmployees);
        return "view/employees.html";
    }
}
