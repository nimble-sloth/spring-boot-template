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