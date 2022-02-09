package com.ssing.car;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"com.*", "com.ssing.car"})
@MapperScan("com.data.*")
public class SsingSsingCarApplication {
	public static void main(String[] args) {
		SpringApplication.run(SsingSsingCarApplication.class, args);
	}
}
