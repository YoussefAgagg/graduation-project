package com.example.controlhomedevicesserver.service;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.model.Room;
import com.example.controlhomedevicesserver.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
@Slf4j
@RequiredArgsConstructor
public class RoomService {

    private final RoomRepository roomRepository;

    @Loggable
    public void updateRoomDevicesStatus(String message){
        roomRepository.updateRoomDevicesStatus(message);
    }
    public Collection<Room> getAllRooms(){
        return roomRepository.getAllRooms();
    }

    @Loggable
    public Room getRoomByName(String roomName) {
        return roomRepository.getRoomByName(roomName);
    }
    @Loggable
    public void addNewRoom(Room room) {
        roomRepository.addRoom(room);
    }
    @Loggable
    public void updateRoom(Room room) {
        if (roomRepository.getRoomByName(room.getName())!=null){
            addNewRoom(room);
        }
    }
}
