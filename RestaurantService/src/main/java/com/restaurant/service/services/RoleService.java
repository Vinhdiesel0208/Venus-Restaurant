package com.restaurant.service.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.restaurant.service.entities.Role;
import com.restaurant.service.repositories.RoleRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class RoleService {

    @Autowired
    private RoleRepository roleRepo;

    public List<Role> getAllRoles() {
        return (List<Role>) roleRepo.findAll();
    }

    public Role getRoleById(Long id) {
        return roleRepo.findById(id).orElse(null);
    }

    public Role createRole(Role role) {
        return roleRepo.save(role);
    }

    public Role updateRole(Long id, Role updatedRole) {
        Role existingRole = roleRepo.findById(id).orElse(null);

        if (existingRole != null) {
            existingRole.setName(updatedRole.getName());
            existingRole.setDescription(updatedRole.getDescription());
           
            return roleRepo.save(existingRole);
        }

        return null;
    }

    public void deleteRole(Long id) {
        roleRepo.deleteById(id);
    }
}
