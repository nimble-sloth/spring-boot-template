package com.example.template.ri.rest;
import org.springframework.http.*;
import java.util.Date;
public interface ExternalApiClient {
  ResponseEntity<String> getRecords(Date date, String query);
  ResponseEntity<String> getDetails(String id);
  ResponseEntity<byte[]> getDocument(String id);
}
