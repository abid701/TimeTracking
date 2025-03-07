package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.Task;
import com.grassau.GrassauTime.db.repositories.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TaskService {

    private final TaskRepository taskRepository;

    @Autowired
    public TaskService(TaskRepository taskRepository){
        this.taskRepository = taskRepository;
    }

    public Iterable<Task> getAllTasks(){
        return taskRepository.findAll();
    }

    public Iterable<Task> getAllTasksByStatus(String status){
        return taskRepository.findAllByTaskStatus(status);
    }
}
