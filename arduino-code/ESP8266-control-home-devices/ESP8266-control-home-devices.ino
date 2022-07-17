/*
 *
 */

#include <Arduino.h>
//#include <ESP8266WiFi.h>
#include <WebSocketsClient.h>

#define DEBUG_SERIAL Serial

WebSocketsClient webSocket;

const char *ssid = "Jo";
const char *password = "xxxxxxxx";

unsigned long messageInterval = 5000;
bool connected = false;

void setup()
{
  setupLivingRoomInputOutpt();
  setupBedRoomInputOutpt();
  setupGarageInputOutpt();
  DEBUG_SERIAL.begin(115200);
  DEBUG_SERIAL.printf("try to connect to the wifi");

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  DEBUG_SERIAL.print("Local IP: ");
  DEBUG_SERIAL.println(WiFi.localIP());
  // server address, port and URL
  webSocket.begin("192.168.1.5", 8080, "/connect");
  webSocket.setAuthorization("esp", "password");
  // event handler
  webSocket.onEvent(webSocketEvent);
}

void loop()
{
  webSocket.loop();

  livingRoom();
  bedRoom();
  garage();
}
