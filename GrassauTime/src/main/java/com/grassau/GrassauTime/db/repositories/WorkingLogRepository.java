package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Employee;
import com.grassau.GrassauTime.db.entities.WorkingLog;
import org.springframework.stereotype.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

@Repository
public interface WorkingLogRepository extends JpaRepository<WorkingLog, Integer> {
    Optional<WorkingLog> findByCardNumberAndWorkDate(String cardNumber, LocalDate date);
    Iterable<WorkingLog> findAllByWorkDate(LocalDate date);
    WorkingLog findByEmployeeAndWorkDate(Employee employee,LocalDate date);
    Iterable<WorkingLog> findAllByWorkDateBetween(LocalDate startDate, LocalDate endDate);

    // Search by employee's first name (case-insensitive)
    Iterable<WorkingLog> findByEmployee_FirstNameContainingIgnoreCase(String firstName);

}

