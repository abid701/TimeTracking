package com.grassau.GrassauTime.services;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//@Service
//public class EmployeeService {
//
//    private final EmployeeRepository employeeRepository;
//
//    @Autowired
//    public EmployeeService(EmployeeRepository employeeRepository){
//        this.employeeRepository = employeeRepository;
//    }
//
//    public Iterable<Employee> getAllEmployee(){
//        return employeeRepository.findAll();
//    }
//
//    public Employee getEmployeeByCardNumber(String cardNumber){
//        return employeeRepository.findEmployeeByCardId(cardNumber);
//    }
//}



// This is the last version of code
@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    @Autowired
    public EmployeeService(EmployeeRepository employeeRepository){
        this.employeeRepository = employeeRepository;
    }

    public Iterable<Employee> getAllEmployee() {
        return employeeRepository.findAll();
    }

    public Employee getEmployeeByCardNumber(String cardNumber){
        return employeeRepository.findEmployeeByCardId(cardNumber);
    }

    public void saveEmployee(Employee employee) {
        employeeRepository.save(employee);
    }

    @Transactional
    public void deleteEmployee(int id) {
        employeeRepository.deleteById(id);
    }
}
