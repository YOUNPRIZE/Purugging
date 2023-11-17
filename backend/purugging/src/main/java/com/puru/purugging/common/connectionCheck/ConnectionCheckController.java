package com.puru.purugging.common.connectionCheck;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/test")
public class ConnectionCheckController {

    @GetMapping("")
    public ResponseEntity<String> healthCheck() {

        return new ResponseEntity<>("OK", HttpStatus.OK);
    }
}
