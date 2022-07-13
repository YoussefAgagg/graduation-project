package com.example.controlhomedevicesserver.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Room {
    private String name;
    private Map<String,Device> devices=new HashMap<>();
}
