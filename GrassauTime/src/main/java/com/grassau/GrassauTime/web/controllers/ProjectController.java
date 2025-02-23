package com.grassau.GrassauTime.web.controllers;

import com.grassau.GrassauTime.db.entities.Project;
import com.grassau.GrassauTime.services.ProjectService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectController {

    private final ProjectService projectService;

    public ProjectController(ProjectService projectService){
        this.projectService = projectService;
    }

    @GetMapping("/project")
    public String showProjects(Model model){

        Iterable<Project> allProjects = projectService.getAllProjects();

        model.addAttribute("allProjects", allProjects);

        return "view/project.html";
    }


}
