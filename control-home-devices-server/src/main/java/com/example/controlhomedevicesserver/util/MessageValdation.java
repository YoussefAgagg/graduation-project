package com.example.controlhomedevicesserver.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MessageValdation {

  private static Pattern pattern= Pattern.compile("^\\w+:\\w+:[01]$");
  private MessageValdation(){}

  public static boolean isMessageValide(String message){
    Matcher matcher = pattern.matcher(message);

    return matcher.matches();
  }

}
