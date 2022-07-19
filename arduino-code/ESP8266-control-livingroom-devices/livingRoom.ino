// GPIO2 input pins
uint8_t livingRoomLampButton1 = D0;
uint8_t livingRoomLampButton2 = D1; 
uint8_t livingRoomLampButton3 = D2; 


// GPIO2 output pins
uint8_t relayPin1 = D5; 
uint8_t relayPin2 = D6; 
uint8_t relayPin3 = D7; 


int previuseStateLivingRoomButton1 = 0;
int previuseStateLivingRoomButton2 = 0;
int previuseStateLivingRoomButton3 = 0;

void setupLivingRoomInputOutpt()
{
  DEBUG_SERIAL.printf("setup livingroom input ,outpit pins\n");
  // Set output pins
  pinMode(relayPin1, OUTPUT);
  pinMode(relayPin2, OUTPUT);
  pinMode(relayPin3, OUTPUT);
  // Set input pins
  pinMode(livingRoomLampButton1, INPUT);
  pinMode(livingRoomLampButton2, INPUT);
  pinMode(livingRoomLampButton3, INPUT);
}
void livingRoom()
{
  livingRoomButton1();
  livingRoomButton2();
  livingRoomButton3();
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
      Serial.println("button 1 not clicked");
      webSocket.sendTXT("livingRoom:lamp1:0");
      digitalWrite(relayPin1, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton1 != currentState)
    {
      Serial.println("button 1 clicked");
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
      Serial.println("button 2 not clicked");
      webSocket.sendTXT("livingRoom:lamp2:0");
      digitalWrite(relayPin2, LOW);
    }
  }
  else
  {

    if (previuseStateLivingRoomButton2 != currentState)
    {
      Serial.println("button 2 clicked");
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
      Serial.println("button 3 not clicked");
      webSocket.sendTXT("livingRoom:lamp3:0");
      digitalWrite(relayPin3, LOW);
    }
  }
  else
  {
    

    if (previuseStateLivingRoomButton3 != currentState)
    {
      Serial.println("button 3 clicked");
      webSocket.sendTXT("livingRoom:lamp3:1");
      digitalWrite(relayPin3, HIGH);
    }
  }
  previuseStateLivingRoomButton3 = currentState;
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
}
