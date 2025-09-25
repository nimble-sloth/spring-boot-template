package com.example.template.manager.notification;
import com.example.template.domain.notification.NotificationSender;
import org.springframework.mail.javamail.JavaMailSender;
public class EmailNotificationSender implements NotificationSender {
  private final JavaMailSender mailSender;
  public EmailNotificationSender(JavaMailSender mailSender){ this.mailSender = mailSender; }
  @Override public void send(String subject, String body){ /* TODO: build and send MimeMessage */ }
}
