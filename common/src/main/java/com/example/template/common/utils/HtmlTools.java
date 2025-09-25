package com.example.template.common.utils;

public final class HtmlTools {
  private HtmlTools(){}
  public static String wrap(String body){
    return "<html><body>" + body + "</body></html>";
  }
}