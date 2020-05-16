#include <ESP8266WiFi.h>
#include "ESPAsyncWebServer.h"

const char* ssid = "ESP8266-Access-Point";
const char* password = "123456789";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

int soilPin = A0;
int pumpPin = D5;

void setup() {
  Serial.begin(74880);

  WiFi.softAP(ssid, password);

  IPAddress IP = WiFi.softAPIP();
  Serial.println(IP);

  server.on("/moisture", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", takeReading().c_str());
  });

  server.begin();
  
  pinMode(soilPin, INPUT);
  pinMode(pumpPin, OUTPUT);
  Serial.print("\n");
}

void loop() {
  /*int dataVals = takeReading().toInt();
  bool test =  dataVals < 40;
  
  if(dataVals < 40){ 
    startPump(true);
    }
  else{
    startPump(false);
    }
    
  Serial.print(String(dataVals));Serial.print("\n"); 

  */
}

String takeReading(){
  int reading = analogRead(A0);
  reading = map(reading, 0, 1023, 100, 0);

  if(reading < 40){
    startPump(true);
    }
  else{
    startPump(false);
    }
  
  delay(1000);
  return String(reading);
  }

void startPump(bool state){
  if(state){
    digitalWrite(pumpPin, HIGH);
  }
  else{
    digitalWrite(pumpPin,LOW);
    }
  }
