package com.example.template.manager;

import com.example.template.domain.manager.ExternalApiManager;
import com.example.template.ri.rest.ExternalApiClient;
import org.springframework.stereotype.Service;
import org.springframework.http.ResponseEntity;
import java.util.Date;

@Service
public class ExternalApiManagerImpl implements ExternalApiManager {
  private final ExternalApiClient client;
  public ExternalApiManagerImpl(ExternalApiClient client){ this.client = client; }

  @Override
  public String getSomething(Date date, String query) throws Exception {
    ResponseEntity<String> res = client.getRecords(date, query);
    return res.getBody();
  }
}
