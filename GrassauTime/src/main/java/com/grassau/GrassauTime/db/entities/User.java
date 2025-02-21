package com.grassau.GrassauTime.db.entities;


import com.grassau.GrassauTime.enums.Role;
import jakarta.persistence.*;


@Entity
@Table(name = "users")
public class User {

    @Id
    private int id;

    private String username;

    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToOne
    @JoinColumn(name = "employee_id", unique = true, nullable = true)
    private Employee employee;

    public User(){}

    public User (String username, String password, Role role){
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public User(String username, String password, Role role, Employee employee){
        this.username = username;
        this.password = password;
        this.role = role;
        this.employee = employee;
    }

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getUsername(){
        return username;
    }

    public void setUsername(String username){
        this.username = username;
    }

    public String getPassword(){
        return password;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public Role getRole(){
        return role;
    }

    public void setRole(Role role){
        this.role = role;
    }


}
