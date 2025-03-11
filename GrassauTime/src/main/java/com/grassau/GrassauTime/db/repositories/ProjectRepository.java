package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Project;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepository extends JpaRepository<Project, Integer> {
    Iterable<Project> findAllByProjectStatus(String status);

    // Search by project client
    Iterable<Project> findByClientNameContainingIgnoreCase(String client);

    Project findById(int id);
}
