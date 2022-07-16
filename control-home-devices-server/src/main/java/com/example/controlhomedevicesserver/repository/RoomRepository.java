package com.example.controlhomedevicesserver.repository;

import com.example.controlhomedevicesserver.aop.logging.Loggable;
import com.example.controlhomedevicesserver.model.Device;
import com.example.controlhomedevicesserver.model.Room;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
@Repository
public class RoomRepository {
    private static Map<String, Room> rooms=new HashMap<>();

    public void addRoom(Room room){
        rooms.put(room.getName(), room);
    }
    public Room getRoomByName(String roomName){
        return rooms.get(roomName);
    }
    public void addDeviceToRoom(String roomName, Device device){
        if (rooms.containsKey(roomName))
            rooms.get(roomName).getDevices().put(device.getName(),device);
    }

    @Loggable
    public void updateRoomDevicesStatus(String message){
        String[] split=message.split(":",3);
        Room room= rooms.get(split[0]);
        room.getDevices().get(split[1]).setStatus(Integer.parseInt(split[2]));
    }

    public Collection<Room> getAllRooms() {
        return rooms.values();
    }
}
