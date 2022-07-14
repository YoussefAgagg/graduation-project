package com.example.controlhomedevicesserver.model;

import java.util.HashMap;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Room {
    private String name;
    private Map<String,Device> devices=new HashMap<>();
}
