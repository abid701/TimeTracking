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



/**
 * Service class for managing Employee entities.
 * This service provides methods to perform CRUD operations on Employee objects.
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

    /**
     * Retrieves all employees from the database.
     *
     * @return An iterable collection of all Employee objects.
     */
    public Iterable<Employee> getAllEmployee() {
        return employeeRepository.findAll();
    }

    /**
     * Retrieves an Employee by their unique ID.
     *
     * @param id The ID of the Employee.
     * @return The Employee object if found, otherwise null.
     */
    public Employee getEmployeeById(int id){
        return employeeRepository.findEmployeeById(id);
    }

    /**
     * Retrieves an Employee by their card number.
     *
     * @param cardNumber The card number associated with the Employee.
     * @return The Employee object if found, otherwise null.
     */
    public Employee getEmployeeByCardNumber(String cardNumber){
        return employeeRepository.findEmployeeByCardId(cardNumber);
    }

    /**
     * Saves an Employee object to the database.
     *
     * @param employee The Employee entity to be saved.
     */
    public void saveEmployee(Employee employee) {
        employeeRepository.save(employee);
    }

    /**
     * Deletes an Employee by their unique ID.
     * This operation is transactional to ensure consistency.
     *
     * @param id The ID of the Employee to be deleted.
     */
    @Transactional
    public void deleteEmployee(int id) {
        employeeRepository.deleteById(id);
    }

    /**
     * Searches for Employees whose first name contains the specified string, case insensitive.
     *
     * @param firstName The substring to search for in Employee first names.
     * @return An iterable collection of Employee objects that match the search criteria.
     */
    public Iterable<Employee> searchByFirstName(String firstName){
        return employeeRepository.findByFirstNameContainingIgnoreCase(firstName);
    }

    /**
     * Retrieves Employees based on their active status.
     *
     * @param isActive The status of the Employees to retrieve (true for active, false for inactive).
     * @return An iterable collection of Employee objects with the specified active status.
     */
    public Iterable<Employee> getEmployeesByIsActive(boolean isActive){
        return employeeRepository.findAllByIsActive(isActive);
    }
}
