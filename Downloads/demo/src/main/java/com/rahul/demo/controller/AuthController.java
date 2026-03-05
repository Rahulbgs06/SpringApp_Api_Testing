package com.rahul.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;
import java.util.*;



@RestController
@RequestMapping("/api/auth") //static url
public class AuthController {
    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {

        if ("rahul".equals(request.getUsername()) &&
            "1234".equals(request.getPassword())) {

            LoginResponse response =
                    new LoginResponse("Login Successful", "SUCCESS");

            return new ResponseEntity<>(response, HttpStatus.OK);
        }

        LoginResponse response =
                new LoginResponse("Invalid Credentials", "FAIL");

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }
    
    @GetMapping("/users")
    public List<String> getUsers() {

    	 List<String> users = new ArrayList<>();
        users.add("Rahul");
        users.add("Amit");
        users.add("Priya");

        return users;
    }

}
