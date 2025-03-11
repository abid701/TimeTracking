package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    Employee findEmployeeByCardId(String cardId);
    Employee findEmployeeById(int id);

    // Search by first name
    Iterable<Employee> findByFirstNameContainingIgnoreCase(String firstName);

    // find By isActive property of Employee, it can be active or inactive (true is active and false is inactive)
    Iterable<Employee> findAllByIsActive(boolean isActive);
}

