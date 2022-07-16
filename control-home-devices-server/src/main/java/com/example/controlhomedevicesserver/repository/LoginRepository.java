package com.example.controlhomedevicesserver.repository;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.model.UserSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class LoginRepository {
    private static final Map<UserSession, WebSocketSession> usersWebSocketSessions = new HashMap<>();

    @Loggable
    public void addNewUserWebSocketSession(UserSession userSession, WebSocketSession session){
        usersWebSocketSessions.put(userSession, session);
    }

    @Loggable
    public boolean isUsernameExist(String username){
        return usersWebSocketSessions.keySet().stream()
            .anyMatch(userSession -> userSession.getUsername().equals(username));
    }

    @Loggable
    public void removeUserWebSocketSession(UserSession userSession){
        usersWebSocketSessions.remove(userSession);

    }

    @Loggable
    public List<WebSocketSession> getAllWebSocketSessionsExceptUsername(UserSession userSession) {
        List<WebSocketSession> webSocketSessions=new ArrayList<>();
        usersWebSocketSessions.forEach((k,v)->{
            if(!userSession.equals(k)) webSocketSessions.add(v);

        });
        return webSocketSessions;
    }
}
