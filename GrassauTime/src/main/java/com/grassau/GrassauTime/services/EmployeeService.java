package com.grassau.GrassauTime.services;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




 /**
 * Service class for managing Employee entities.
 * This service provides methods to perform CRUD operations and more on Employee objects.
 */

@Service
public class EmployeeService {
    private final EmployeeRepository employeeRepository;

    /**
     * Constructs an EmployeeService with the specified EmployeeRepository.
     *
     * @param employeeRepository The repository used to perform database operations.
     */
    @Autowired
    public EmployeeService(EmployeeRepository employeeRepository){
        this.employeeRepository = employeeRepository;
    }

    public Iterable<Employee> getAllEmployee() {
        return employeeRepository.findAll();
    }

    public Employee getEmployeeById(int id){
        return employeeRepository.findEmployeeById(id);
    }

    public Employee getEmployeeByCardNumber(String cardNumber){
        return employeeRepository.findEmployeeByCardId(cardNumber);
    }

    // Save an employee
    public void saveEmployee(Employee employee) {
        employeeRepository.save(employee);
    }

    // Delete by ID
    @Transactional
    public void deleteEmployee(int id) {
        employeeRepository.deleteById(id);
    }

    // Search Employee by first name
    public Iterable<Employee> searchByFirstName(String firstName){
        return employeeRepository.findByFirstNameContainingIgnoreCase(firstName);
    }

    // get employees by status
    public Iterable<Employee> getEmployeesByIsActive(boolean isActive){
        return employeeRepository.findAllByIsActive(isActive);
    }
}
