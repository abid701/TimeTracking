package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;


/**
 * Represents an employee entity in the database.
 */
@Entity
@Table(name = "employees")
public class Employee implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String firstName;

    private String lastName;

    private String email;

    private String employeePosition;

    private float hourlyRate;

    private LocalDate dateHired;

    private boolean isActive;

    private String cardId;


    public Employee(){}

    public Employee(String firstName, String employeePosition){
        this.firstName = firstName;
        this.employeePosition = employeePosition;
    }

    public Employee(String firstName, String lastName, String employeePosition){
        this.firstName = firstName;
        this.lastName = lastName;
        this.employeePosition = employeePosition;
    }


    @OneToMany(mappedBy = "employee")
    private Set<WorkingLog> workingLogs = new HashSet<>();

    @OneToMany(mappedBy = "assignedTo")
    private Set<Task> tasks = new HashSet<>();


    /**
     * Gets the working logs associated with the employee.
     * @return Set of WorkingLog objects.
     */
    public Set<WorkingLog> getWorkingLogs() {
        return workingLogs;
    }

    /**
     * Sets the working logs for the employee.
     * @param workingLogs Set of WorkingLog objects.
     */
    public void setWorkingLogs(Set<WorkingLog> workingLogs){
        this.workingLogs = workingLogs;
    }

    /**
     * Gets the tasks assigned to the employee.
     * @return Set of Task objects.
     */
    public Set<Task> getTasks() {
        return tasks;
    }

    /**
     * Sets the tasks for the employee.
     * @param tasks Set of Task objects.
     */
    public void setTasks(Set<Task> tasks) {
        this.tasks = tasks;
    }

    // Below are all the normal getters and setters for the properties of the employee class
    
    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getFirstName(){
        return firstName;
    }

    public void setFirstName(String firstName){
        this.firstName = firstName;
    }

    public String getLastName(){
        return  lastName;
    }

    public void setLastName(String lastName){
        this.lastName = lastName;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public String getEmployeePosition(){
        return employeePosition;
    }

    public void setEmployeePosition(String employeePosition){
        this.employeePosition = employeePosition;
    }

    public float getHourlyRate(){
        return hourlyRate;
    }

    public void setHourlyRate(float hourlyRate){
        this.hourlyRate = hourlyRate;
    }

    public LocalDate getDateHired(){
        return dateHired;
    }

    public void setDateHired(LocalDate dateHired){
        this.dateHired = dateHired;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getCardId(){
        return cardId;
    }

    public void setCardId(String cardId){
        this.cardId = cardId;
    }

    
}
