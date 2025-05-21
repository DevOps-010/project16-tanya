package com.example.demo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class DemoApplicationTests {

    @Test
    void helloTest() {
        DemoApplication app = new DemoApplication();
        String result = app.hello();
        assertEquals("Hello from Jenkins CI/CD pipeline!", result);
    }
}

