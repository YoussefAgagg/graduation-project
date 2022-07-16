// GPIO2 input pins
/*
uint8_t bedRoomLampButton1 = D0;
uint8_t bedRoomLampButton2 = D1;
uint8_t bedRoomLampButton3 = D2;


// GPIO2 output pins

uint8_t relayPin5 = D5;
uint8_t relayPin6 = D6;
uint8_t relayPin7 = D7;
*/
int previuseStateBedRoomButton1 = 0;
int previuseStateBedRoomButton2 = 0;
int previuseStateBedRoomButton3 = 0;

void setupBedRoomInputOutpt()
{
  DEBUG_SERIAL.printf("setup bedroom input ,outpit pins");
  /*
  // Set output pins
  pinMode(relayPin1, OUTPUT);
  pinMode(relayPin2, OUTPUT);
  pinMode(relayPin3, OUTPUT);
  pinMode(relayPin4, OUTPUT);
  // Set input pins
  pinMode(bedRoomLampButton1, INPUT);
  pinMode(bedRoomLampButton2, INPUT);
  pinMode(bedRoomLampButton3, INPUT);
  pinMode(bedRoomLampButton4, INPUT);
  */
}
void bedRoom()
{/*
  bedRoomButton1();
  bedRoomButton2();
  bedRoomButton3();
  */
}

/*
 * manage bedroom button 1
 */
/*void bedRoomButton1()
{
  int currentState = digitalRead(bedRoomLampButton1);
  if (currentState == 0)
  {
    if (previuseStateBedRoomButton1 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp1:0");
      digitalWrite(relayPin1, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton1 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp1:1");
      digitalWrite(relayPin1, HIGH);
    }
  }
  previuseStateBedRoomButton1 = currentState;
}*/
/*
 * manage bedroomroom button 2
 */
/*void bedRoomButton2()
{
  int currentState = digitalRead(bedRoomLampButton2);
  if (currentState == 0)
  {

    if (previuseStateBedRoomButton2 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp2:0");
      digitalWrite(relayPin2, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton2 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp2:1");
      digitalWrite(relayPin2, HIGH);
    }
  }
  previuseStateBedRoomButton2 = currentState;
}*/
/*
 * manage bedroom button 3
 */
/*void bedRoomButton3()
{
  int currentState = digitalRead(bedRoomLampButton3);
  if (currentState == 0)
  {

    if (previuseStateBedRoomButton3 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp3:0");
      digitalWrite(relayPin3, LOW);
    }
  }
  else
  {

    if (previuseStateBedRoomButton3 != currentState)
    {
      webSocket.sendTXT("bedRoom:lamp3:1");
      digitalWrite(relayPin3, HIGH);
    }
  }
  previuseStateBedRoomButton3 = currentState;
}*/

void bedRoom(String str)
{
  DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", str);
  /*
  int index = str.indexOf(":");
  String led = str.substring(0, index);
  int outputStatus = str.substring(index + 1, str.length()).toInt();

  if (led.equals("lamp1"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin1, LOW);
    else
      digitalWrite(relayPin1, HIGH);
  }
  else if (led.equals("lamp2"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin2, LOW);
    else
      digitalWrite(relayPin2, HIGH);
  }
  else if (led.equals("lamp3"))
  {
    DEBUG_SERIAL.printf("[bedroom] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin3, LOW);
    else
      digitalWrite(relayPin3, HIGH);
  }*/

}
