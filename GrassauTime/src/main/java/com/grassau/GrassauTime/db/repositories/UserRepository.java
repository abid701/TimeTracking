package com.grassau.GrassauTime.db.repositories;

import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String username);

    // count's users by role
    int countByRole(Role role);

    // find by username
    User findByusername(String username);
}
