package com.grassau.GrassauTime.web.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalTime;

//@Controller
//public class WelcomeController {
//
//    @PostMapping("/scan")
//    public String scanCard(@RequestParam(required = false) String cardNumber,
//                           @RequestParam(required = false) LocalTime startTime,
//                           @RequestParam(required = false) LocalTime endTime,
//                           @RequestParam(required = false) LocalTime breakStarted,
//                           @RequestParam(required = false) LocalTime breakEnded){
//
//
//    }


//}

import com.grassau.GrassauTime.services.WorkingLogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WelcomeController {

    private final WorkingLogService workingLogService;

    public WelcomeController(WorkingLogService workingLogService) {
        this.workingLogService = workingLogService;
    }

    @PostMapping("/scan")
    public String scanCard(@RequestParam String cardNumber) {
        workingLogService.scanCard(cardNumber);
        return "redirect:/home";
    }
}

