package com.grassau.GrassauTime.web.controllers;

import com.grassau.GrassauTime.db.entities.Project;
import com.grassau.GrassauTime.services.ProjectService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.Optional;

@Controller
public class ProjectController {

    private final ProjectService projectService;

    public ProjectController(ProjectService projectService){
        this.projectService = projectService;
    }

    @GetMapping("/project")
    public String showProjects(@RequestParam(required = false) String status,
                               Model model){

        if (status != null && status.equals("all")){

            Iterable<Project> allProjects = projectService.getAllProjects();
            model.addAttribute("allProjects", allProjects);

            return "view/project.html";
        }

        else if (status != null){
            System.out.println(status);
            Iterable<Project> allProjects = projectService.getAllProjectsByStatus(status);
            for (Project project : allProjects){
                System.out.println(project.getProjectStatus());
            }
            model.addAttribute("allProjects", allProjects);

            return "view/project.html";
        }

        Iterable<Project> allProjects = projectService.getAllProjects();

        model.addAttribute("allProjects", allProjects);

        return "view/project.html";
    }


    // Search by client name
    @GetMapping("/project/search")
    public String searchByClient(@RequestParam(required = false) String client,
                                 Model model){
        Iterable<Project> allProjects = projectService.searchByClientName(client);
        model.addAttribute("allProjects", allProjects);

        return "view/project.html";
    }

    @PostMapping("/project/add")
    public String addProject(@RequestParam String projectName,
                           @RequestParam String clientName,
                           @RequestParam LocalDate startDate,
                           @RequestParam(required = false) LocalDate endDate,
                           @RequestParam String status,
                           @RequestParam(required = false) String description){

        Project newProject = new Project();
        newProject.setName(projectName);
        newProject.setClientName(clientName);
        newProject.setStartDate(startDate);
        if (endDate != null){
            newProject.setEndDate(endDate);
        }
        newProject.setProjectStatus(status);
        if (description != null){
            newProject.setDescription(description);
        }

        projectService.saveProject(newProject);

        return "redirect:/project";

    }

    @GetMapping("/project/delete/{id}")
    public String removeProject(@PathVariable int id){
        Project currentProject = projectService.getProjectById(id);
        projectService.removeProject(currentProject);

        return "redirect:/project";
    }


}
