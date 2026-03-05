package com.rahul.demo.repository;

import com.rahul.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // JpaRepository already gives us basic CRUD methods
    // save(), findAll(), findById(), deleteById(), etc.
}