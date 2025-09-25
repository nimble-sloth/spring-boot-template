package com.example.template.manager.notification;

import com.example.template.domain.notification.NotificationSender;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

@Service
@Primary
public class NoOpNotificationSender implements NotificationSender {
  @Override public void send(String subject, String body) { /* no-op for dev */ }
}
