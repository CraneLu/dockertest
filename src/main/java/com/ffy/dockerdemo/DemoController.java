package com.ffy.dockerdemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/")
@RestController
public class DemoController {

    @GetMapping(value = "docker")
    public String docker(){
        return "hello docker";
    }
}
