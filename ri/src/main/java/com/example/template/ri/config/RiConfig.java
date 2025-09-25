package com.example.template.ri.config;

import com.example.template.ri.rest.*;
import org.springframework.context.annotation.*;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RiConfig {
  @Bean
  RestTemplate restTemplate() { return new RestTemplate(); }

  @Bean
  ExternalApiClient externalApiClient(RestTemplate rt) { return new ExternalApiClientImpl(rt); }
}