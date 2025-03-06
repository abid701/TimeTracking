package com.grassau.GrassauTime.web.controllers;


import com.grassau.GrassauTime.db.entities.Task;
import com.grassau.GrassauTime.services.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TaskController {

    private final TaskService taskService;

    public TaskController(TaskService taskService){
        this.taskService = taskService;
    }

    @GetMapping("/tasks")
    public String showTask(Model model){

        Iterable<Task> allTasks = taskService.getAllTasks();

        model.addAttribute("allTasks", allTasks);

        return "view/task.html";
    }
}
