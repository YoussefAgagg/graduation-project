package com.example.controlhomedevicesserver.web.rest;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.service.LoginService;
import com.example.controlhomedevicesserver.web.rest.payload.LoginRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class LoginResource {
    private final LoginService loginService;

    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    @Loggable
    @GetMapping("/isEspUp")
    public boolean isMicrocontrollerUp(@RequestParam String esp){
        return loginService.isUsernameSessionExist(esp);
    }
    @Loggable
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest login){
        var auth=new UsernamePasswordAuthenticationToken(login.getUsername(),login.getPassword());
        authenticationManagerBuilder.getObject().authenticate(auth);
        return ResponseEntity.ok("loged in");
    }

}
