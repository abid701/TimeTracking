package com.grassau.GrassauTime;

import com.grassau.GrassauTime.services.WorkingLogService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.time.LocalDate;

@SpringBootApplication
public class GrassauTimeApplication {

	public static void main(String[] args) {
		SpringApplication.run(GrassauTimeApplication.class, args);

//		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//		System.out.println(encoder.encode("Test2020#"));

		System.out.println(LocalDate.now());


		}



}
