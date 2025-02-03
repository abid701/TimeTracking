package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.WorkingLogs;
import com.grassau.GrassauTime.services.WorkingLogsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WorkingLogsController {

    private final WorkingLogsService workingLogsService;

    public WorkingLogsController(WorkingLogsService workingLogsService) {
        this.workingLogsService = workingLogsService;
    }

    @GetMapping("/home")
    public String showHome(Model model){

        Iterable<WorkingLogs> allWorkingLogs = workingLogsService.getAllWorkingLogs();

    //    Iterable<Employees> allEmployees = workingLogsService.getAllEmployeesFirstName();

        model.addAttribute("allWorkingLogs", allWorkingLogs);

    //    model.addAttribute("allEmployees", allEmployees);

        return "view/home.html";
    }
}
