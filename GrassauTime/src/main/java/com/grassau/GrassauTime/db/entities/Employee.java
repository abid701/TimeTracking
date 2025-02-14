package com.grassau.GrassauTime.db.entities;


import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

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

    private String role;

    private float hourlyRate;

    private LocalDate dateHired;

    private boolean isActive;

    public Employee(){}


    @OneToMany(mappedBy = "employee")
    private Set<WorkingLog> workingLogs = new HashSet<>();

    public Set<WorkingLog> getWorkingLogs() {
        return workingLogs;
    }

    public void setWorkingLogs(Set<WorkingLog> workingLogs){
        this.workingLogs = workingLogs;
    }



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

    public String getRole(){
        return role;
    }

    public void setRole(String role){
        this.role = role;
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



}
