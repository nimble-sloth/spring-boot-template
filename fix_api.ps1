# fix_api.ps1 — rewrite API Java files as UTF-8 (no BOM)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# ApiConstants.java
$apiConst = @'
package com.example.template.api.rs;

public final class ApiConstants {
  private ApiConstants() {}
  public static final String API = "/api";
  public static final String V   = "/v1";
}
'@
[IO.File]::WriteAllText('api\src\main\java\com\example\template\api\rs\ApiConstants.java', $apiConst, $utf8NoBom)

# TemplateEndpoint.java
$templateEndpoint = @'
package com.example.template.api.rs;

import com.example.template.domain.orchestrator.JobOrchestrator;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.*;
import io.swagger.v3.oas.annotations.info.*;

import javax.sql.DataSource;
import java.util.Map;

@OpenAPIDefinition(info=@Info(title="Template API", version="v1"))
@RestController
@RequestMapping(ApiConstants.API + ApiConstants.V)
public class TemplateEndpoint {
  private final JobOrchestrator orchestrator;
  private final DataSource dataSource;

  public TemplateEndpoint(JobOrchestrator orchestrator, DataSource dataSource){
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
    Integer one = new JdbcTemplate(this.dataSource).queryForObject("SELECT 1", Integer.class);
    return ResponseEntity.ok(Map.of("result", String.valueOf(one)));
  }
}
'@
[IO.File]::WriteAllText('api\src\main\java\com\example\template\api\rs\TemplateEndpoint.java', $templateEndpoint, $utf8NoBom)

# Optional: print first 3 bytes (should NOT be 239 187 191)
Get-ChildItem api\src\main\java\com\example\template\api\rs -Filter *.java |
  % { "[{0}] -> {1}" -f $_.Name, ([byte[]](Get-Content $_.FullName -Encoding Byte -TotalCount 3) -join ' ') }