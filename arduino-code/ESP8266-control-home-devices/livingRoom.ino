// GPIO2 input pins
// living room
uint8_t livingRoomLampButton1 = D0;
uint8_t livingRoomLampButton2 = D1;
uint8_t livingRoomLampButton3 = D2;
uint8_t livingRoomLampButton4 = D4;

// GPIO2 output pins
// room leds output
uint8_t relayPin1 = D5;
uint8_t relayPin2 = D6;
uint8_t relayPin3 = D7;
uint8_t relayPin4 = D8;

int previuseStateLivingRoomButton1 = 0;
int previuseStateLivingRoomButton2 = 0;
int previuseStateLivingRoomButton3 = 0;
int previuseStateLivingRoomButton4 = 0;

void setupLivingRoomInputOutpt()
{
  DEBUG_SERIAL.printf("setup livingroom input ,outpit pins");
  // Set output pins
  pinMode(relayPin1, OUTPUT);
  pinMode(relayPin2, OUTPUT);
  pinMode(relayPin3, OUTPUT);
  pinMode(relayPin4, OUTPUT);
  // Set input pins
  pinMode(livingRoomLampButton1, INPUT);
  pinMode(livingRoomLampButton2, INPUT);
  pinMode(livingRoomLampButton3, INPUT);
  pinMode(livingRoomLampButton4, INPUT);
}
void livingRoom()
{
  livingRoomButton1();
  livingRoomButton2();
  livingRoomButton3();
  livingRoomButton4();
}

/*
 * manage livingroom button 1
 */
void livingRoomButton1()
{
  int currentState = digitalRead(livingRoomLampButton1);
  if (currentState == 0)
  {
    if (previuseStateLivingRoomButton1 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp1:0");
      digitalWrite(relayPin1, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton1 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp1:1");
      digitalWrite(relayPin1, HIGH);
    }
  }
  previuseStateLivingRoomButton1 = currentState;
}
/*
 * manage livingroom button 2
 */
void livingRoomButton2()
{
  int currentState = digitalRead(livingRoomLampButton2);
  if (currentState == 0)
  {

    if (previuseStateLivingRoomButton2 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp2:0");
      digitalWrite(relayPin2, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton2 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp2:1");
      digitalWrite(relayPin2, HIGH);
    }
  }
  previuseStateLivingRoomButton2 = currentState;
}
/*
 * manage livingroom button 3
 */
void livingRoomButton3()
{
  int currentState = digitalRead(livingRoomLampButton3);
  if (currentState == 0)
  {

    if (previuseStateLivingRoomButton3 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp3:0");
      digitalWrite(relayPin3, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton3 != currentState)
    {
      webSocket.sendTXT("livingRoom:lamp3:1");
      digitalWrite(relayPin3, HIGH);
    }
  }
  previuseStateLivingRoomButton3 = currentState;
}
/*
 * manage livingroom button 4
 */
void livingRoomButton4()
{

  int currentState = digitalRead(livingRoomLampButton4);
  if (currentState == 0)
  {

    if (previuseStateLivingRoomButton4 != currentState)
    {
      Serial.print("button 4 not clicked");
      webSocket.sendTXT("livingRoom:lamp4:0");
      digitalWrite(relayPin4, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton4 != currentState)
    {
      Serial.print("button 4 clicked");
      webSocket.sendTXT("livingRoom:lamp4:1");
      digitalWrite(relayPin4, HIGH);
    }
  }
  previuseStateLivingRoomButton4 = currentState;
}

void livingRoom(String str)
{
  int index = str.indexOf(":");
  String led = str.substring(0, index);
  int outputStatus = str.substring(index + 1, str.length()).toInt();

  if (led.equals("lamp1"))
  {
    DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin1, LOW);
    else
      digitalWrite(relayPin1, HIGH);
  }
  else if (led.equals("lamp2"))
  {
    DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin2, LOW);
    else
      digitalWrite(relayPin2, HIGH);
  }
  else if (led.equals("lamp3"))
  {
    DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin3, LOW);
    else
      digitalWrite(relayPin3, HIGH);
  }
  else if (led.equals("lamp4"))
  {
    DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
    if (outputStatus == 0)
      digitalWrite(relayPin4, LOW);
    else
      digitalWrite(relayPin4, HIGH);
  }
}
