package com.grassau.GrassauTime.services;


import com.grassau.GrassauTime.db.entities.User;
import com.grassau.GrassauTime.db.repositories.UserRepository;
import com.grassau.GrassauTime.enums.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service class for managing user-related operations.
 */
@Service
public class UserService {


    @Autowired
    final private UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public Iterable<User> getAllUsers(){
        return userRepository.findAll();
    }

    public void saveUser(User user){
        userRepository.save(user);
    }

    public boolean doesAdminExists() {
        return userRepository.countByRole(Role.ADMIN) > 0;
    }

    public User getUserByUsername(String username){
        return userRepository.findByusername(username);
    }
}
