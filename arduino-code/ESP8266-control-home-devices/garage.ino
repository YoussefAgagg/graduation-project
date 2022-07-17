// GPIO2 input pins
int garageDoorButton = 13; //D13;

// GPIO2 output pins
int relayPin8 = 2; //D2;

void setupGarageInputOutpt()
{
  DEBUG_SERIAL.printf("setup garage input ,outpit pins");
  
   // Set output pins
  pinMode(relayPin8, OUTPUT);

    // Set input pins
  pinMode(garageDoorButton, INPUT);
}

bool isOpened = false;
void garage()
{
  int currentState = digitalRead(garageDoorButton);
  if (currentState == 0 && isOpened)
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
void openDoor(){}
void closeDoor(){}
