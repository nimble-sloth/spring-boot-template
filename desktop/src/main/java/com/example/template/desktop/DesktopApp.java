package com.example.template.desktop;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class DesktopApp extends Application {
  @Override public void start(Stage stage) {
    stage.setTitle("Template Desktop");
    stage.setScene(new Scene(new StackPane(new Label("Hello from Desktop!")), 420, 240));
    stage.show();
  }
  public static void main(String[] args) { launch(args); }
}