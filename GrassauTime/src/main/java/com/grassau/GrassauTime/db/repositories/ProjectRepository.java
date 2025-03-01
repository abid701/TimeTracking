package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Project;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface ProjectRepository extends JpaRepository<Project, Integer> {
}
