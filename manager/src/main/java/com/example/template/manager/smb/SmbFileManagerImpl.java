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