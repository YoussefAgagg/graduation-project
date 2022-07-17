// GPIO2 input pins

int bedRoomLampButton1 =27; //D27;
int bedRoomLampButton2 =14; //D14;
int bedRoomLampButton3 =12; //D12;


// GPIO2 output pins

int relayPin5 = 18; //D18
int relayPin6 = 5; //D5
int relayPin7 = 4; //D4

int previuseStateBedRoomButton1 = 0;
int previuseStateBedRoomButton2 = 0;
int previuseStateBedRoomButton3 = 0;

void setupBedRoomInputOutpt()
{
  DEBUG_SERIAL.printf("setup bedroom input ,outpit pins");
  
  // Set output pins
  pinMode(relayPin5, OUTPUT);
  pinMode(relayPin6, OUTPUT);
  pinMode(relayPin7, OUTPUT);
  // Set input pins
  pinMode(bedRoomLampButton1, INPUT);
  pinMode(bedRoomLampButton2, INPUT);
  pinMode(bedRoomLampButton3, INPUT);
  
}
void bedRoom()
{
  bedRoomButton1();
  bedRoomButton2();
  bedRoomButton3();
  
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
/*
 * manage bedroom button 3
 */
void bedRoomButton3()
{
  int currentState = digitalRead(bedRoomLampButton3);
  if (currentState == 0)
  {

    if (previuseStateBedRoomButton3 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp3:0");
      digitalWrite(relayPin7, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton3 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp3:1");
      digitalWrite(relayPin7, HIGH);
    }
  }
  previuseStateBedRoomButton3 = currentState;
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
  else if (led.equals("lamp3"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin7, LOW);
    else
      digitalWrite(relayPin7, HIGH);
  }

}
