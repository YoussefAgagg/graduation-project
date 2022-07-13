package com.example.controlhomedevicesserver.web.rest.payload;

import lombok.Data;

@Data
public class LoginRequest {
  private String username;
  private String password;

}
