// GPIO2 input pins

uint8_t bedRoomLampButton1 =D0; 
uint8_t bedRoomLampButton2 =D1; 



// GPIO2 output pins

uint8_t relayPin5 = D5; 
uint8_t relayPin6 = D6;


int previuseStateBedRoomButton1 = 0;
int previuseStateBedRoomButton2 = 0;


void setupBedRoomInputOutpt()
{
  DEBUG_SERIAL.printf("setup bedroom input ,outpit pins\n");
  
  // Set output pins
  pinMode(relayPin5, OUTPUT);
  pinMode(relayPin6, OUTPUT);

  // Set input pins
  pinMode(bedRoomLampButton1, INPUT);
  pinMode(bedRoomLampButton2, INPUT);
  
}
void bedRoom()
{
  bedRoomButton1();
  bedRoomButton2();

  
}

/*
 * manage bedroom button 1
 */
void bedRoomButton1()
{
  int currentState = digitalRead(bedRoomLampButton1);
  if (currentState == 0)
  {
    if (previuseStateBedRoomButton1 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp1:0");
      digitalWrite(relayPin5, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton1 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp1:1");
      digitalWrite(relayPin5, HIGH);
    }
  }
  previuseStateBedRoomButton1 = currentState;
}
/*
 * manage bedroomroom button 2
 */
void bedRoomButton2()
{
  int currentState = digitalRead(bedRoomLampButton2);
  if (currentState == 0)
  {

    if (previuseStateBedRoomButton2 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp2:0");
      digitalWrite(relayPin6, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton2 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp2:1");
      digitalWrite(relayPin6, HIGH);
    }
  }
  previuseStateBedRoomButton2 = currentState;
}


void bedRoom(String str)
{
  DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", str);

  int index = str.indexOf(":");
  String led = str.substring(0, index);
  int outputStatus = str.substring(index + 1, str.length()).toInt();

  if (led.equals("lamp1"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin5, LOW);
    else
      digitalWrite(relayPin5, HIGH);
  }
  else if (led.equals("lamp2"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin6, LOW);
    else
      digitalWrite(relayPin6, HIGH);
  }
 

}
