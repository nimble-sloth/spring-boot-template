package com.example.template.manager.notification;

import com.example.template.domain.notification.NotificationSender;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@ConditionalOnProperty(prefix = "notification.email", name = "enabled", havingValue = "true")
public class EmailNotificationSender implements NotificationSender {
  private final JavaMailSender mailSender;
  public EmailNotificationSender(JavaMailSender mailSender){ this.mailSender = mailSender; }

  @Override public void send(String subject, String body){
    // TODO build MimeMessage and send via mailSender
  }
}
