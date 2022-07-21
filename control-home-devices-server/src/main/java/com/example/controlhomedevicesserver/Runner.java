package com.example.controlhomedevicesserver;

import com.example.controlhomedevicesserver.model.Device;
import com.example.controlhomedevicesserver.model.Room;
import com.example.controlhomedevicesserver.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
@Slf4j
@RequiredArgsConstructor
public class Runner  implements CommandLineRunner {
    private final RoomRepository roomRepository;
    @Override
    public void run(String... args)  {
        roomRepository.addRoom(createLivingRoom());
        roomRepository.addRoom(createBedRoom());
        roomRepository.addRoom(createGarage());
    }
    private Room createLivingRoom() {
        Room room=new Room();
        room.setName("livingRoom");
        Device lamp1=new Device("lamp1",0);
        Device lamp2=new Device("lamp2",0);
        Device lamp3=new Device("lamp3",0);
        room.setDevices(Map.of(lamp1.getName(),lamp1,lamp2.getName(),lamp2,lamp3.getName(),lamp3));
        return room;
    }
    private Room createBedRoom() {
        Room room=new Room();
        room.setName("bedRoom");
        Device lamp1=new Device("lamp1",0);
        Device lamp2=new Device("lamp2",0);
        room.setDevices(Map.of(lamp1.getName(),lamp1,lamp2.getName(),lamp2));
        return room;
    }
    private Room createGarage() {
        Room room=new Room();
        room.setName("garage");
        Device door=new Device("door",0);

        room.setDevices(Map.of(door.getName(),door));
        return room;
    }
}
