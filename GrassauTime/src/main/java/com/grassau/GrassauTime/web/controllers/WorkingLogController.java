package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.WorkingLog;
import com.grassau.GrassauTime.services.WorkingLogService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WorkingLogController {

    private final WorkingLogService workingLogService;

    public WorkingLogController(WorkingLogService workingLogService) {
        this.workingLogService = workingLogService;
    }

    @GetMapping("/home")
    public String showHome(Model model){

        Iterable<WorkingLog> allWorkingLogs = workingLogService.getAllWorkingLog();

    //    Iterable<Employees> allEmployees = workingLogsService.getAllEmployeesFirstName();

        model.addAttribute("allWorkingLogs", allWorkingLogs);

    //    model.addAttribute("allEmployees", allEmployees);

        return "view/home.html";
    }
}
