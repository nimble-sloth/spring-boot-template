package com.example.template.api.rs;

import com.example.template.domain.orchestrator.JobOrchestrator;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.*;
import io.swagger.v3.oas.annotations.info.*;
import org.springframework.beans.factory.ObjectProvider;
import javax.sql.DataSource;
import java.util.Map;

@OpenAPIDefinition(info=@Info(title="Template API", version="v1"))
@RestController
@RequestMapping(ApiConstants.API + ApiConstants.V)
public class TemplateEndpoint {
  private final JobOrchestrator orchestrator;
  private final ObjectProvider<DataSource> dataSource;

  public TemplateEndpoint(JobOrchestrator orchestrator, ObjectProvider<DataSource> dataSource){
    this.orchestrator = orchestrator;
    this.dataSource = dataSource;
  }

  @GetMapping(value="/test", produces=MediaType.APPLICATION_JSON_VALUE)
  @Operation(summary="Health test")
  public ResponseEntity<Map<String,String>> test(){
    return ResponseEntity.ok(Map.of("ok","true"));
  }

  @GetMapping(value="/db-check", produces=MediaType.APPLICATION_JSON_VALUE)
  @Operation(summary="DB connectivity check (SELECT 1)")
  public ResponseEntity<Map<String,String>> dbCheck(){
    DataSource ds = dataSource.getIfAvailable();
    if (ds == null) return ResponseEntity.status(501).body(Map.of("result","no DataSource in this profile"));
    Integer one = new JdbcTemplate(ds).queryForObject("SELECT 1", Integer.class);
    return ResponseEntity.ok(Map.of("result", String.valueOf(one)));
  }
}