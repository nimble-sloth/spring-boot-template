package com.example.template.ri.rest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import java.net.URI;
import java.util.Date;

public class ExternalApiClientImpl implements ExternalApiClient {
  private final RestTemplate rt;
  public ExternalApiClientImpl(RestTemplate rt){ this.rt = rt; }

  @Override public ResponseEntity<String> getRecords(Date date, String q){
    return rt.getForEntity(URI.create("https://example.com/api/records"), String.class);
  }
  @Override public ResponseEntity<String> getDetails(String id){
    return rt.getForEntity(URI.create("https://example.com/api/details/"+id), String.class);
  }
  @Override public ResponseEntity<byte[]> getDocument(String id){
    return rt.getForEntity(URI.create("https://example.com/api/docs/"+id), byte[].class);
  }
}