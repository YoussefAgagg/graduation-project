package com.example.controlhomedevicesserver.service;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.repository.LoginRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class LoginService {

    private final LoginRepository loginRepository;
    @Loggable
    public void addNewUserWebSocketSession(WebSocketSession session){
        loginRepository.addNewUserWebSocketSession(getUsernameFromHeader(session), session);
    }
    @Loggable
    public List<WebSocketSession> getAllWebSocketSessionsExcept(WebSocketSession session){
       return loginRepository.getAllWebSocketSessionsExceptUsername(getUsernameFromHeader(session));
    }
    @Loggable
    public boolean isUsernameSessionExist(String username){
       return loginRepository.isUsernameExist(username);
    }
    @Loggable
    public void removeUserWebSocketSession(WebSocketSession session){

        loginRepository.removeUserWebSocketSession(getUsernameFromHeader(session));
    }

    /**
     * Get the login of the current user.
     *
     * @return the login of the current user.
     */
    @Loggable
    public  String getUsernameFromHeader(WebSocketSession session) {
        //Fetch Credential from authorization header
        String authorization = session.getHandshakeHeaders().get(HttpHeaders.AUTHORIZATION).toString();
        authorization=authorization.replaceAll("[\\[\\]=]","");
        String base64Credentials = authorization.substring("Basic".length()).trim();
        byte[] credDecoded = Base64.getDecoder().decode(base64Credentials);
        String credentials = new String(credDecoded, StandardCharsets.UTF_8);
        return credentials.split(":", 2)[0];
    }

    private  String extractPrincipal(Authentication authentication) {
        if (authentication == null) {
            return null;
        } else if (authentication.getPrincipal() instanceof UserDetails) {
            UserDetails springSecurityUser = (UserDetails) authentication.getPrincipal();
            return springSecurityUser.getUsername();
        } else if (authentication.getPrincipal() instanceof String) {
            return (String) authentication.getPrincipal();
        }
        return null;
    }

}
