/*
 *
 */

#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <WebSocketsClient.h>

#define DEBUG_SERIAL Serial

WebSocketsClient webSocket;

const char *ssid = "Jo";
const char *password = "xxxxxxxx";

unsigned long messageInterval = 5000;
bool connected = false;

void setup()
{
  setupBedRoomInputOutpt();
  setupGarageInputOutpt();
  DEBUG_SERIAL.begin(9600);
  DEBUG_SERIAL.printf("try to connect to the wifi");

  WiFi.begin(ssid, password);

  if (WiFi.status() == WL_CONNECTED)
  {
    DEBUG_SERIAL.print("Local IP: ");
    DEBUG_SERIAL.println(WiFi.localIP());
  }else{
    DEBUG_SERIAL.println("not connected to wifi");
    }
  
  // server address, port and URL
  webSocket.begin("192.168.1.5", 8080, "/connect");
  webSocket.setAuthorization("esp2", "password");
  // event handler
  webSocket.onEvent(webSocketEvent);
}

void loop()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    webSocket.loop();
  }
  
  bedRoom();
  garage();
}
