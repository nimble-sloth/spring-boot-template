package com.example.template.desktop;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import java.net.URI;
import java.net.http.*;

public class DesktopApp extends Application {
  @Override public void start(Stage stage){
    Button btn = new Button("Call /api/v1/test");
    btn.setOnAction(e -> HttpClient.newHttpClient()
      .sendAsync(HttpRequest.newBuilder(URI.create("http://localhost:8080/api/v1/test")).GET().build(),
                 HttpResponse.BodyHandlers.ofString())
      .thenAccept(r -> Platform.runLater(() -> new Alert(Alert.AlertType.INFORMATION, r.body()).show())));
    stage.setScene(new Scene(new StackPane(btn), 360, 240));
    stage.setTitle("Template Control");
    stage.show();
  }
  public static void main(String[] args){ launch(); }
}
