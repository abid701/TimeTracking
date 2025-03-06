package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.Project;
import com.grassau.GrassauTime.db.entities.WorkingLog;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import com.grassau.GrassauTime.services.EmployeeService;
import com.grassau.GrassauTime.services.ProjectService;
import com.grassau.GrassauTime.services.WorkingLogService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.Month;
import java.time.YearMonth;

@Controller
public class WorkingLogController {

    private final WorkingLogService workingLogService;

    private final EmployeeService employeeService;

    private final ProjectService projectService;

    public WorkingLogController(WorkingLogService workingLogService, EmployeeService employeeService,
                                ProjectService projectService) {
        this.workingLogService = workingLogService;
        this.employeeService = employeeService;
        this.projectService = projectService;
    }

    @GetMapping("/home")
    public String showHome(@RequestParam(required = false) String date,
                           Model model){

        YearMonth currentMonth = YearMonth.now();
        LocalDate startOfMonth = currentMonth.atDay(1);
        LocalDate endOfMonth = currentMonth.atEndOfMonth();


        if (date != null && date.equals("thisMonth")){
            Iterable<WorkingLog> thisMonthWorkingLogs = workingLogService.getAllWorkingLogsByWorkDateBetween(startOfMonth,
                    endOfMonth);
            System.out.println("It Works the new method works");
            model.addAttribute("allWorkingLogs", thisMonthWorkingLogs);
            return "view/home.html";
        }

        Iterable<WorkingLog> allWorkingLogs = workingLogService.getAllWorkingLog();

    //    Iterable<Employees> allEmployees = workingLogsService.getAllEmployeesFirstName();

        Iterable<Employee> allEmployees = employeeService.getAllEmployee();

        int numberOfEmployees = 0;

        for (Employee employee : allEmployees){
            numberOfEmployees += 1;
        }

        Iterable<Project> allProjects = projectService.getAllProjects();

        int numberOfOngoingProjects = 0;

        for (Project project : allProjects){
            String status = project.getProjectStatus();
            if (status.equals("ongoing")){
                System.out.println("Success");
                numberOfOngoingProjects += 1;
            }
            System.out.println(project);

        }



        model.addAttribute("allWorkingLogs", allWorkingLogs);

        model.addAttribute("numberOfEmployees", numberOfEmployees);

        model.addAttribute("numberOfOngoingProjects", numberOfOngoingProjects);

    //    model.addAttribute("allEmployees", allEmployees);

        return "view/home.html";
    }
}
