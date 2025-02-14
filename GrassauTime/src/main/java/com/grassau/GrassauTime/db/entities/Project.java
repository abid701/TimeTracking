package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "projects")
public class Project implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private String clientName;

    private LocalDate startDate;

    private LocalDate endDate;

    private String projectStatus;

    private String description;


    @OneToMany(mappedBy = "project")
    private Set<WorkingLog> workingLogs = new HashSet<>();

    public Set<WorkingLog> getWorkingLogs() {
        return workingLogs;
    }

    public void setWorkingLogs(Set<WorkingLog> workingLogs) {
        this.workingLogs = workingLogs;
    }

    public Project(){}

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getClientName(){
        return clientName;
    }

    public void setClientName(String clientName){
        this.clientName = clientName;
    }

    public String getProjectStatus(){
        return projectStatus;
    }

    public void setProjectStatus(String projectStatus){
        this.projectStatus = projectStatus;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

}
