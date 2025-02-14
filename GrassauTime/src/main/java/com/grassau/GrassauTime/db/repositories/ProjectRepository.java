package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.Project;
import org.springframework.data.repository.CrudRepository;

public interface ProjectRepository extends CrudRepository<Project, Integer> {
}
