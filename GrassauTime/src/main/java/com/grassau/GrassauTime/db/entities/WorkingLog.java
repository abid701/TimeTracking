package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "working_logs")
public class WorkingLog implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    @ManyToOne
    @JoinColumn(name = "project_id", nullable = false)
    private Project project;

    private LocalDate workDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private float totalHours;

    private String description;


    public WorkingLog(){}



    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getEmployee() {
        return employee.getFirstName();
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public String getProject() {
        return project.getName();
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public LocalDate getWorkDate() {
        return workDate;
    }

    public void setWorkDate(LocalDate workDate) {
        this.workDate = workDate;
    }

    public LocalTime getStartTime(){
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public float getTotalHours(){
        return totalHours;
    }

    public void setTotalHours(float totalHours){
        this.totalHours = totalHours;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }



}
