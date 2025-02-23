package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.WorkingLog;
import com.grassau.GrassauTime.services.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;


import com.grassau.GrassauTime.services.WorkingLogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class WelcomeController {

    private final WorkingLogService workingLogService;

    private final EmployeeService employeeService;

    public WelcomeController(WorkingLogService workingLogService, EmployeeService employeeService) {
        this.workingLogService = workingLogService;
        this.employeeService = employeeService;
    }

    @PostMapping("/scan")
    public String scanCard(@RequestParam String cardNumber, RedirectAttributes redirectAttributes) {
        workingLogService.scanCard(cardNumber);

        Employee employee = employeeService.getEmployeeByCardNumber(cardNumber);


        if (employee == null){
            redirectAttributes.addFlashAttribute("errorMessage", "Employee Not Found");
            System.out.println("Not Found");
            return "redirect:/";
        }

        // Check the employee's work log for today
        LocalDate today = LocalDate.now();
        WorkingLog lastLog = workingLogService.getWorkingLogByEmployeeAndWorkDate(employee, today);

        System.out.println("last log is this" + lastLog.getWorkDate());

        String message;

        if (lastLog.getBreakStarted() == null){
            message = "Good Morning, " + employee.getFirstName() + "! Your shift has started.";
        } else if (lastLog.getBreakEnded() == null){
            message = "Break started, " + employee.getFirstName() + "! Enjoy your rest.";
        } else if (lastLog.getBreakStarted() != null && lastLog.getEndTime() == null){
            message = "Welcome back, " + employee.getFirstName() + "! Your break has ended.";
        } else {
            message = "Goodbye, " + employee.getFirstName() + "! See you next time.";
        }


        redirectAttributes.addFlashAttribute(   "statusMessage", message);

        return "redirect:/";
    }

    @GetMapping({"/", "/welcome"})
    public String showWelcomePage(Model model){

        Iterable<WorkingLog> allWorkLogs = workingLogService.getAllWorkingLog();

        LocalDate today = LocalDate.now();
        Iterable<WorkingLog> todayWorkingLogs = workingLogService.getAllWorkingLogsByWorkDate(today);
        System.out.println(todayWorkingLogs.toString());


        List<WorkingLog> employeesOnSite = new ArrayList<>();
        for(WorkingLog workLog : todayWorkingLogs){
            if (workLog.getEndTime() == null){
                employeesOnSite.add(workLog);
            }
            System.out.println(workLog.getEmployee());
        }



      //  Iterable<WorkingLog> todayWorkLogs = workingLogService.

        model.addAttribute("employeesOnSite", employeesOnSite);

        return "view/welcome.html";
    }



}

