package com.example.controlhomedevicesserver.web.rest;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.model.Room;
import com.example.controlhomedevicesserver.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequiredArgsConstructor
public class RoomResource {
    private final RoomService roomService;


    @Loggable
    @GetMapping("/rooms")
    public Collection<Room> getAllRooms(){
        return roomService.getAllRooms();
    }


    @Loggable
    @GetMapping("/rooms/{roomName}")
    public Room getRoomByName(@PathVariable String roomName){
        return roomService.getRoomByName(roomName);
    }

    @Loggable
    @PostMapping("rooms")
    public void addNewRoom(@RequestBody Room room){
        roomService.addNewRoom(room);
    }

    @Loggable
    @PutMapping ("rooms")
    public void updateRoom(@RequestBody Room room){
        roomService.updateRoom(room);
    }




}
