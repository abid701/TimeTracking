package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.Project;
import com.grassau.GrassauTime.db.repositories.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ProjectService {

    private final ProjectRepository projectRepository;

    @Autowired
    public ProjectService(ProjectRepository projectRepository){
        this.projectRepository =  projectRepository;
    }

    public Iterable<Project> getAllProjects(){
        return  projectRepository.findAll();
    }

    // returns all the projects with the given status an argument
    public Iterable<Project> getAllProjectsByStatus(String status){
        return projectRepository.findAllByProjectStatus(status);
    }

    // Search's for projects by client's name
    public Iterable<Project> searchByClientName(String client){
        return projectRepository.findByClientNameContainingIgnoreCase(client);
    }

    public void saveProject(Project project){
        projectRepository.save(project);
    }

    public void removeProject(Project project){
        projectRepository.delete(project);
    }

    public Project getProjectById(int id){
        return projectRepository.findById(id);
    }

}
