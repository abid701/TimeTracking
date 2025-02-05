package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.WorkingLog;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkingLogRepository extends CrudRepository<WorkingLog, Integer> {
   // List<Employees> findAllEmployessFirstName();
}
