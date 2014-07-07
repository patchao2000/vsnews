package com.videostar.vsnews.web.identify;

import javax.persistence.Column;
import javax.persistence.Entity;

/**
 * UserDetail
 *
 * Created by patchao2000 on 14-7-7.
 */
@Entity
public class UserDetail implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private String userId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String role;

    public UserDetail(String userId,
                      String firstName,
                      String lastName,
                      String email,
                      String password) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
    }

    @Column
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Column
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Column
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}
