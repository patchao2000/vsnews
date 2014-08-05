package com.videostar.vsnews.entity;

import com.videostar.vsnews.entity.IdEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Entity: Role - 角色
 *
 * Created by patchao2000 on 14-8-5.
 */
@Entity
@Table(name = "ROLE")
public class Role extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String name;

    private List<String> groups;

    @Column
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "ROLE_GROUPS", joinColumns = @JoinColumn(name = "ROLE_ID"))
    public List<String> getGroups() {
        return groups;
    }

    public void setGroups(List<String> groups) {
        this.groups = groups;
    }
}
