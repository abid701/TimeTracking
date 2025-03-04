package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "tasks")
public class Task implements Serializable {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

    private String name;

    private String description;

    @ManyToOne
    @JoinColumn(name = "assigned_to")
    private Employee assignedTo;

    private String taskStatus;

    private LocalDate deadline;

    public Task(){}

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public Project getProject(){
        return project;
    }

    public void setProject(Project project){
        this.project = project;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public Employee getAssignedTo(){
        return assignedTo;
    }

    public void setAssignedTo(Employee assignedTo){
        this.assignedTo = assignedTo;
    }

    public String getTaskStatus(){
        return taskStatus;
    }

    public void setTaskStatus(String taskStatus){
        this.taskStatus = taskStatus;
    }

    public LocalDate getDeadline(){
        return deadline;
    }

    public void setDeadline(LocalDate deadline){
        this.deadline = deadline;
    }



}
