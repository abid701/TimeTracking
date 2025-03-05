package com.grassau.GrassauTime.db.entities;


import com.grassau.GrassauTime.enums.Role;
import jakarta.persistence.*;


/**
 * Represents a User entity in the system.
 * This entity is mapped to the "users" table in the database.
 */
@Entity
@Table(name = "users")
public class User {

    /**
     * Unique identifier for the user.
     * Auto-generated using identity strategy. This is like auto_increment in MySQL or SERIAL in PostgreSQL.
     */
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    /**
     * Gets the first name of the employee.
     * If there is no employee, returns "N/A".
     *
     * @return The first name of the employee or "N/A" if not existed.
     */
    public String getEmployee(){
        if (employee != null){
            return employee.getFirstName();
        } else {
            return "N/A";
        }

    }

    public void setEmployee(Employee employee){
        this.employee = employee;
    }
}
