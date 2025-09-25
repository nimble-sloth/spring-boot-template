# fix_ri.ps1 — rewrite RI Java files as UTF-8 (no BOM) safely

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# RiConfig.java
$riConfig = @'
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
'@
[IO.File]::WriteAllText('ri\src\main\java\com\example\template\ri\config\RiConfig.java', $riConfig, $utf8NoBom)

# ExternalApiClient.java
$extApiIface = @'
package com.example.template.ri.rest;

import org.springframework.http.ResponseEntity;
import java.util.Date;

public interface ExternalApiClient {
  ResponseEntity<String> getRecords(Date date, String query);
  ResponseEntity<String> getDetails(String id);
  ResponseEntity<byte[]> getDocument(String id);
}
'@
[IO.File]::WriteAllText('ri\src\main\java\com\example\template\ri\rest\ExternalApiClient.java', $extApiIface, $utf8NoBom)

# ExternalApiClientImpl.java
$extApiImpl = @'
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
'@
[IO.File]::WriteAllText('ri\src\main\java\com\example\template\ri\rest\ExternalApiClientImpl.java', $extApiImpl, $utf8NoBom)

# Optional: print first 3 bytes of each file (should NOT be 239 187 191)
Get-ChildItem ri\src\main\java\com\example\template\ri -Recurse -Filter *.java |
  % { "[{0}] -> {1}" -f $_.Name, ([byte[]](Get-Content $_.FullName -Encoding Byte -TotalCount 3) -join ' ') }