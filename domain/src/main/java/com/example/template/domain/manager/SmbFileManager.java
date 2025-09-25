package com.example.template.domain.manager;
public interface SmbFileManager {
  void writeToFile(byte[] bytes, String fullPath) throws Exception;
  void writeToFile(String text, String fullPath) throws Exception;
}
