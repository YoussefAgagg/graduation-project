package com.example.controlhomedevicesserver.repository;

import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class LoginRepository {
    private static final Map<String, WebSocketSession> usersWebSocketSessions = new HashMap<>();

    public void addNewUserWebSocketSession(String username, WebSocketSession session){
        usersWebSocketSessions.put(username, session);
    }
    public WebSocketSession getWebSocketSessionByUsername(String username){
        return usersWebSocketSessions.get(username);
    }
    public boolean isUsernameExist(String username){
        return usersWebSocketSessions.containsKey(username);
    }
    public void removeUserWebSocketSession(String username){
        usersWebSocketSessions.remove(username);

    }


    public List<WebSocketSession> getAllWebSocketSessionsExceptUsername(String username) {
        List<WebSocketSession> webSocketSessions=new ArrayList<>();
        usersWebSocketSessions.forEach((k,v)->{
            if(!username.equals(k)) webSocketSessions.add(v);

        });
        return webSocketSessions;
    }
}
