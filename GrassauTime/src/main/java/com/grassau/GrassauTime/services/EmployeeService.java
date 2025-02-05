package com.grassau.GrassauTime.services;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    @Autowired
    public EmployeeService(EmployeeRepository employeeRepository){
        this.employeeRepository = employeeRepository;
    }

    public Iterable<Employee> getAllEmployee(){
        return employeeRepository.findAll();
    }
}
