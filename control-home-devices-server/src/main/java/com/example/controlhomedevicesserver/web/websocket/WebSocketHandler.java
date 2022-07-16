package com.example.controlhomedevicesserver.web.websocket;

import com.example.controlhomedevicesserver.service.LoginService;
import com.example.controlhomedevicesserver.service.RoomService;
import java.io.IOException;
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
  private final RoomService roomService;
  private static final CloseStatus LOGEDIN_FROM_OTHER_DEVICE = new CloseStatus(4001);

  @Override
  public void afterConnectionEstablished(WebSocketSession session) throws IOException {
    loginService.addNewUserWebSocketSession(session);
    log.debug("connected :" + session);
  }

  @Override
  protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    String username = loginService.getUsernameFromSessionHeader(session);
    log.debug("Send from: {}", username);
    roomService.updateRoomDevicesStatus(message.getPayload());
    log.debug("rooms {}", roomService.getAllRooms());
    for (WebSocketSession webSocketSession : loginService.getAllWebSocketSessionsExcept(session)) {
      webSocketSession.sendMessage(message);
    }
  }

  @Override
  public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    log.debug("remove : {}", session);
    loginService.removeUserWebSocketSession(session);
  }
}