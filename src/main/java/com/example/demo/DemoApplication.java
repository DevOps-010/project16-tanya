package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@SpringBootApplication
@RestController
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(DemoApplication.class);
        Map<String, Object> props = new HashMap<>();
        props.put("server.port", 8081);
        app.setDefaultProperties(props);
        app.run(args);
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hello from Jenkins CI/CD pipeline!";
    }
}
