package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.Duration;
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
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

    private LocalDate workDate;

    private LocalTime startTime;

    private LocalTime endTime;

    private float totalHours;

    private String description;

    private LocalTime breakStarted;

    private LocalTime breakEnded;

    private String breakTotal;

    @Column(name = "card_id")
    private String cardNumber;
    

    public WorkingLog(){}

    public WorkingLog(Integer id, LocalDate workDate, LocalTime startTime,
                      LocalTime endTime, float totalHours, String description,
                      LocalTime breakStarted, LocalTime breakEnded, String breakTotal,
                      String cardNumber){
        this.id = id;
        this.workDate = workDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalHours = totalHours;
        this.description = description;
        this.breakStarted = breakStarted;
        this.breakEnded = breakEnded;
        this.breakTotal = breakTotal;
        this.cardNumber = cardNumber;

    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

    public LocalDate getWorkDate() { return workDate; }
    public void setWorkDate(LocalDate workDate) { this.workDate = workDate; }

    public LocalTime getStartTime() {
        return startTime.withNano(0).withSecond(0); }

    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }

    public LocalTime getBreakStarted() {
        if (breakStarted != null) {
            return breakStarted.withNano(0).withSecond(0);
        }return breakStarted;
        }
    public void setBreakStarted(LocalTime breakStarted) { this.breakStarted = breakStarted; }

    public LocalTime getBreakEnded() {
        if (breakEnded != null){
            return breakEnded.withNano(0).withSecond(0);
        }
        return breakEnded; }

    public void setBreakEnded(LocalTime breakEnded) { this.breakEnded = breakEnded; }

    public LocalTime getEndTime() {
        if (endTime != null){
            return endTime.withNano(0).withSecond(0);
        }
        return endTime; }

    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }

    public String getEmployee() {
        if (employee != null){
            return employee.getFirstName();
        }
        else return null;
         }
    public void setEmployee(Employee employee) { this.employee = employee; }

    public String getProject() {
        if (project != null){
            return project.getName();
        }
        return null;
         }
    public void setProject(Project project) { this.project = project; }

    public String getBreakTotal() {
        return breakTotal;
    }

    public void setBreakTotal(String breakTotal) {
        this.breakTotal = breakTotal;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getTotalHours() {
        if ((startTime != null && endTime != null)){
            return totalHours = Duration.between(startTime, endTime).toHours();
        }
        else {
            return this.totalHours = totalHours;
        }
    }

    public void setTotalHours(float totalHours) {
        this.totalHours = totalHours;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void updateNextStep(LocalTime currentTime) {
        if (this.startTime == null) {
            this.startTime = currentTime;
        } else if (this.breakStarted == null) {
            this.breakStarted = currentTime;
        } else if (this.breakEnded == null) {
            this.breakEnded = currentTime;
        } else if (this.endTime == null) {
            this.endTime = currentTime;
        }
    }


}
