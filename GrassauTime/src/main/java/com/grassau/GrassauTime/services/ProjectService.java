package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.Project;
import com.grassau.GrassauTime.db.repositories.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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

}
