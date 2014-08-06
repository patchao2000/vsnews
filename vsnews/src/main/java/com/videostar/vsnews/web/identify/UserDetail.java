package com.videostar.vsnews.web.identify;

/**
 * UserDetail
 *
 * Created by patchao2000 on 14-7-7.
 */
public class UserDetail implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    private String userId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String roles;
    private String columns;

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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    public String getColumns() {
        return columns;
    }

    public void setColumns(String columns) {
        this.columns = columns;
    }
}
