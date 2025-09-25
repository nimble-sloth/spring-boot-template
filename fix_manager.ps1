# fix_manager.ps1 — rewrite manager Java files as UTF-8 (no BOM)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# ExternalApiManagerImpl.java
$extApiMgr = @'
package com.example.template.manager;

import com.example.template.domain.manager.ExternalApiManager;
import com.example.template.ri.rest.ExternalApiClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

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
'@
[IO.File]::WriteAllText('manager\src\main\java\com\example\template\manager\ExternalApiManagerImpl.java', $extApiMgr, $utf8NoBom)

# EmailNotificationSender.java (simple stub)
$emailSender = @'
package com.example.template.manager.notification;

import com.example.template.domain.notification.NotificationSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailNotificationSender implements NotificationSender {
  private final JavaMailSender mailSender;
  public EmailNotificationSender(JavaMailSender mailSender){ this.mailSender = mailSender; }

  @Override public void send(String subject, String body){
    // TODO: implement (build MimeMessage and send)
  }
}
'@
[IO.File]::WriteAllText('manager\src\main\java\com\example\template\manager\notification\EmailNotificationSender.java', $emailSender, $utf8NoBom)

# NoOpNotificationSender.java (default)
$noopSender = @'
package com.example.template.manager.notification;

import com.example.template.domain.notification.NotificationSender;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

@Service
@Primary
public class NoOpNotificationSender implements NotificationSender {
  @Override public void send(String subject, String body) {
    // no-op for dev
  }
}
'@
[IO.File]::WriteAllText('manager\src\main\java\com\example\template\manager\notification\NoOpNotificationSender.java', $noopSender, $utf8NoBom)

# JobOrchestratorImpl.java
$jobOrch = @'
package com.example.template.manager.orchestrator;

import com.example.template.domain.orchestrator.JobOrchestrator;
import com.example.template.domain.manager.ExternalApiManager;
import com.example.template.domain.manager.SmbFileManager;
import com.example.template.domain.notification.NotificationSender;
import org.springframework.stereotype.Service;

@Service
public class JobOrchestratorImpl implements JobOrchestrator {
  private final ExternalApiManager api;
  private final SmbFileManager smb;
  private final NotificationSender notify;

  public JobOrchestratorImpl(ExternalApiManager api, SmbFileManager smb, NotificationSender notify){
    this.api = api; this.smb = smb; this.notify = notify;
  }

  @Override public String runJob(String date) throws Exception {
    api.getSomething(null, "ping");
    // smb.writeToFile(...), notify.send(...);
    return "OK";
  }
}
'@
[IO.File]::WriteAllText('manager\src\main\java\com\example\template\manager\orchestrator\JobOrchestratorImpl.java', $jobOrch, $utf8NoBom)

# SmbFileManagerImpl.java
$smbImpl = @'
package com.example.template.manager.smb;

import com.example.template.domain.manager.SmbFileManager;
import org.springframework.stereotype.Service;

@Service
public class SmbFileManagerImpl implements SmbFileManager {
  @Override public void writeToFile(byte[] bytes, String fullPath) throws Exception {
    // TODO: jcifs-ng write bytes to SMB path
  }
  @Override public void writeToFile(String text, String fullPath) throws Exception {
    // TODO: jcifs-ng write text to SMB path
  }
}
'@
[IO.File]::WriteAllText('manager\src\main\java\com\example\template\manager\smb\SmbFileManagerImpl.java', $smbImpl, $utf8NoBom)

# Optional: print first 3 bytes (should be plain ASCII, not 239 187 191)
Get-ChildItem manager\src\main\java -Recurse -Filter *.java |
  % { "[{0}] -> {1}" -f $_.Name, ([byte[]](Get-Content $_.FullName -Encoding Byte -TotalCount 3) -join ' ') }