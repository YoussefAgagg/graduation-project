/*
 *
 */
 
#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <WebSocketsClient.h>

#define DEBUG_SERIAL Serial
 
WebSocketsClient webSocket;
 
const char *ssid     = "Jo";
const char *password = "xxxxxxxx";
 
unsigned long messageInterval = 5000;
bool connected = false;


// GPIO2 input pins 
//living room
uint8_t livingRoomLampButton1 = D0;
uint8_t livingRoomLampButton2 = D1;
uint8_t livingRoomLampButton3 = D2;
uint8_t livingRoomLampButton4 = D4;
// bed room
//uint8_t bedRoomLampButton1 = D0;
//uint8_t bedRoomLampButton2 = D1;
//uint8_t bedRoomLampButton3 = D2;
// garage
// uint8_t garageDoorButton = D0;



// GPIO2 output pins 
//room leds output
uint8_t livingRoomLamp1 = D5;
uint8_t livingRoomLamp2 = D6;
uint8_t livingRoomLamp3 = D7;
uint8_t livingRoomLamp4 = D8;
//bed room leds output
//uint8_t bedRoomLamp1 = D5;
//uint8_t bedRoomLamp2 = D6;
//uint8_t bedRoomLamp3 = D7;
// garag door
//uint8_t garageDoorOpen = D5;


 
void webSocketEvent(WStype_t type, uint8_t * payload, size_t length) {
    switch(type) {
        case WStype_DISCONNECTED:
            DEBUG_SERIAL.printf("[WSc] Disconnected!\n");
            break;
        case WStype_CONNECTED: {
            DEBUG_SERIAL.printf("[WSc] Connected to url: %s\n", payload);
        }
            break;
        case WStype_TEXT:{
            String str = (char*)payload;
             Serial.println(str );
            int index=str.indexOf(":");
            String room=str.substring(0,index);
          
            
                if( room.equals("livingRoom")){
                  String device=str.substring(index+1,str.length());
                  livingRoom(device);
                     
                    }
                else if( room.equals("bedRoom")){
                  String device=str.substring(index+1,str.length());
                  bedRoom(device);
                     
                    }
                else if( room.equals("garage")){
                  String device=str.substring(index+1,str.length());
                  garage(device);
                     
                    }
              
                 
                    
            DEBUG_SERIAL.printf("[WSc] RESPONSE: %s\n", str);
        }
            break;
    }
 
}
void livingRoom(String str){
            int index=str.indexOf(":");
            String led=str.substring(0,index);
            int outputStatus=str.substring(index+1,str.length()).toInt();
            
                    if( led.equals("lamp1")){
                      DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
                       if(outputStatus==0)
                          digitalWrite(livingRoomLamp1, LOW);
                        else
                          digitalWrite(livingRoomLamp1, HIGH);
                    }
                    else if(led.equals("lamp2")){
                      DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
                       if(outputStatus==0)
                          digitalWrite(livingRoomLamp2, LOW);
                        else
                          digitalWrite(livingRoomLamp2, HIGH);
                    }
                     else if(led.equals("lamp3")){
                      DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
                       if(outputStatus==0)
                          digitalWrite(livingRoomLamp3, LOW);
                        else
                          digitalWrite(livingRoomLamp3, HIGH);
                    }
                    else if(led.equals("lamp4")){
                      DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
                       if(outputStatus==0)
                          digitalWrite(livingRoomLamp4, LOW);
                        else
                          digitalWrite(livingRoomLamp4, HIGH);
                    }
  
  }
void bedRoom(String str){
            int index=str.indexOf(":");
            String led=str.substring(0,index);
            int outputStatus=str.substring(index+1,str.length()).toInt();
            
                    if( led.equals("lamp1")){
                      DEBUG_SERIAL.printf("[lamp1] RESPONSE: %s\n", led);
//                       if(outputStatus==0)
//                          digitalWrite(livingRoomLamp1, LOW);
//                        else
//                          digitalWrite(livingRoomLamp1, HIGH);
                    }
                    else if(led.equals("lamp2")){
                      DEBUG_SERIAL.printf("[lamp2] RESPONSE: %s\n", led);
//                       if(outputStatus==0)
//                          digitalWrite(livingRoomLamp2, LOW);
//                        else
//                          digitalWrite(livingRoomLamp2, HIGH);
                    }
                     else if(led.equals("lamp3")){
                      DEBUG_SERIAL.printf("[lamp3] RESPONSE: %s\n", led);
//                       if(outputStatus==0)
//                          digitalWrite(livingRoomLamp3, LOW);
//                        else
//                          digitalWrite(livingRoomLamp3, HIGH);
                    }
         
  
  }
void garage(String str){
            int index=str.indexOf(":");
            String led=str.substring(0,index);
            int outputStatus=str.substring(index+1,str.length()).toInt();
            
                    if( led.equals("door")){
                      DEBUG_SERIAL.printf("[door] RESPONSE: %s\n", led);
//                       if(outputStatus==0)
//                          digitalWrite(livingRoomLamp1, LOW);
//                        else
//                          digitalWrite(livingRoomLamp1, HIGH);
                    }
                   
  
  }
 
void setup() {
   // Set output pins
    pinMode(livingRoomLamp1, OUTPUT);
    pinMode(livingRoomLamp2, OUTPUT);
    pinMode(livingRoomLamp3, OUTPUT);
    pinMode(livingRoomLamp4, OUTPUT);
    // Set input pins
    pinMode(livingRoomLampButton1, INPUT);
    pinMode(livingRoomLampButton2, INPUT);
    pinMode(livingRoomLampButton3, INPUT);
    pinMode(livingRoomLampButton4, INPUT);

    DEBUG_SERIAL.begin(115200);
    DEBUG_SERIAL.printf("try to connect to the wifi");
 
    WiFi.begin(ssid, password);
 
    while ( WiFi.status() != WL_CONNECTED ) {
      delay ( 500 );
      Serial.print ( "." );
    }
    DEBUG_SERIAL.print("Local IP: "); DEBUG_SERIAL.println(WiFi.localIP());
    // server address, port and URL
  //  webSocket.begin("testwebsocketconection.herokuapp.com",80, "/trigger");
   webSocket.begin("192.168.1.6",8080, "/connect");
   webSocket.setAuthorization("esp","password"); 
    // event handler
    webSocket.onEvent(webSocketEvent);
}
 
int previuseStateLivingRoomButton1=0;
int previuseStateLivingRoomButton2=0; 
int previuseStateLivingRoomButton3=0;
int previuseStateLivingRoomButton4=0;  

void loop() {
  webSocket.loop();

  livingRoomButton1();
  livingRoomButton2();
  livingRoomButton3();
  livingRoomButton4();

}

/*
* manage livingroom button 1
*/
void livingRoomButton1(){
  int livingRoomButtonState1= digitalRead(livingRoomLampButton1) ;
  if(livingRoomButtonState1==0){
    
    if(previuseStateLivingRoomButton1!=livingRoomButtonState1){
              webSocket.sendTXT("livingRoomLamp1:0");
              digitalWrite(livingRoomLamp1, LOW);
    }
     
 }else{
    
    if(previuseStateLivingRoomButton1!=livingRoomButtonState1){
    webSocket.sendTXT("livingRoomLamp1:1");
    digitalWrite(livingRoomLamp1, HIGH);
    }
  }
 previuseStateLivingRoomButton1=livingRoomButtonState1;
}
/*
* manage livingroom button 2
*/
void livingRoomButton2(){
 int livingRoomButtonState2= digitalRead(livingRoomLampButton2) ;
 if(livingRoomButtonState2==0){
   
    if(previuseStateLivingRoomButton2!=livingRoomButtonState2){
    webSocket.sendTXT("livingRoomLamp2:0");
     digitalWrite(livingRoomLamp2, LOW);
    }
 }else{
    
    if(previuseStateLivingRoomButton2!=livingRoomButtonState2){
    webSocket.sendTXT("livingRoomLamp2:1");
    digitalWrite(livingRoomLamp2, HIGH);
    }
  }  
 previuseStateLivingRoomButton2=livingRoomButtonState2;
}
/*
* manage livingroom button 3
*/
void livingRoomButton3(){
 int livingRoomButtonState3= digitalRead(livingRoomLampButton3) ;
 if(livingRoomButtonState3==0){
   
    if(previuseStateLivingRoomButton3!=livingRoomButtonState3){
    webSocket.sendTXT("livingRoomLamp3:0");
     digitalWrite(livingRoomLamp3, LOW);
    }
 }else{
    
    if(previuseStateLivingRoomButton3!=livingRoomButtonState3){
    webSocket.sendTXT("livingRoomLamp3:1");
    digitalWrite(livingRoomLamp3, HIGH);
    }
  }
 previuseStateLivingRoomButton3=livingRoomButtonState3;
}
/*
* manage livingroom button 4
*/
void livingRoomButton4(){
  
 int livingRoomButtonState4= digitalRead(livingRoomLampButton4) ;
 if(livingRoomButtonState4==0){
   
    if(previuseStateLivingRoomButton4!=livingRoomButtonState4){
      Serial.print ( "button 4 not clicked" );
    webSocket.sendTXT("livingRoomLamp4:0");
     digitalWrite(livingRoomLamp4, LOW);
    }
 }else{
    
    if(previuseStateLivingRoomButton4!=livingRoomButtonState4){
      Serial.print ( "button 4 clicked" );
    webSocket.sendTXT("livingRoomLamp4:1");
    digitalWrite(livingRoomLamp4, HIGH);
    }
  }
 previuseStateLivingRoomButton4=livingRoomButtonState4;
}
