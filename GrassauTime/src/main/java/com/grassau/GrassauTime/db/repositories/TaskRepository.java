package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskRepository extends JpaRepository<Task, Integer> {
    Iterable<Task> findAllByTaskStatus(String status);
}
