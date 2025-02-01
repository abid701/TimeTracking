package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.WorkingLogs;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkingLogsRepository extends CrudRepository<WorkingLogs, Integer> {
}
