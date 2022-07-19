#include<Servo.h>

Servo motor;
// GPIO2 input pins
uint8_t garageDoorButton = D2; 

// GPIO2 output pins
uint8_t door = D7; 

void setupGarageInputOutpt()
{
  DEBUG_SERIAL.printf("setup garage input ,outpit pins\n");
  
  motor.attach(door);

    // Set input pins
  pinMode(garageDoorButton, INPUT);
}

bool isOpened = false;
void garage()
{
  int currentState = digitalRead(garageDoorButton);
  if (currentState == 1 && isOpened)
  {
    isOpened = false;
     webSocket.sendTXT("garage:door:0");
     closeDoor();
  }
  else if (currentState == 1 && !isOpened)
  {
     isOpened = true;
     webSocket.sendTXT("garage:door:1");
     openDoor();
  
  }
 
}

void garage(String str)
{
  int index = str.indexOf(":");
  String led = str.substring(0, index);
  int outputStatus = str.substring(index + 1, str.length()).toInt();

  if (led.equals("door"))
  {
    DEBUG_SERIAL.printf("[garage] RESPONSE: %s\n", led);
    if (outputStatus == 0 && isOpened){
      isOpened = false;
      closeDoor();
    }
    else if (outputStatus == 1 && !isOpened){
      isOpened = true;
      openDoor();
    }
  }
}
void openDoor(){
  motor.write(10);
  delay(50);
  motor.write(50);
  delay(50);
  motor.write(90);
  delay(50);
  motor.write(130);
  delay(50);
  motor.write(160);
  delay(50);


  }
void closeDoor(){
  motor.write(160);
  delay(50);
  motor.write(130);
  delay(50);
  motor.write(90);
  delay(50);
  motor.write(50);
  delay(50);
  motor.write(10);
  delay(50);

  

  }
