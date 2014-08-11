package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.Role;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * RoleDao
 *
 * Created by patchao2000 on 14-8-5.
 */
public interface RoleDao extends PagingAndSortingRepository<Role, Long> {
}
