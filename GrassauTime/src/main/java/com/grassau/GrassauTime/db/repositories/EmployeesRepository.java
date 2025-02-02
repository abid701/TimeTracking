package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Employees;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeesRepository extends CrudRepository<Employees, Integer> {
}
