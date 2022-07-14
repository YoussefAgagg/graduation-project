package com.example.controlhomedevicesserver.web.websocket;

import com.example.controlhomedevicesserver.service.LoginService;
import com.example.controlhomedevicesserver.service.RoomService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequiredArgsConstructor
@Slf4j
@Component
public class WebSocketHandler extends TextWebSocketHandler {

    private final LoginService loginService;
    private  final RoomService roomService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session)  {
       String username=loginService.getUsernameFromSessionHeader(session);
        if (loginService.isUsernameSessionExist(username)){
            throw new RuntimeException("user already login");
        }
        loginService.addNewUserWebSocketSession(session);
        log.debug("connected :"+ username);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String username=loginService.getUsernameFromSessionHeader(session);
        log.debug("Send from: {}", username);
        roomService.updateRoomDevicesStatus(message.getPayload());
        log.debug("rooms {}",roomService.getAllRooms());
        for(WebSocketSession webSocketSession : loginService.getAllWebSocketSessionsExcept(session)){
            webSocketSession.sendMessage(message);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String username=loginService.getUsernameFromSessionHeader(session);
        log.debug("remove : {}", username);
        loginService.removeUserWebSocketSession(session);
    }
}