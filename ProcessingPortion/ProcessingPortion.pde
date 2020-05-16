//The purpose of this program is to draw a diagram for how moist the water pot is
//Based on serial transmission

import processing.serial.*;

Serial myPort;

String inString;
String prevString;

float finalNum = 0;

int oneTime = 0;

void setup() {
  size(500, 500);

  myPort = new Serial(this, Serial.list()[2], 115200);
  myPort.clear();
  myPort.bufferUntil(10);
  
  background(#46F7E1);
}

void draw() {
  
  if (inString != prevString ) {
    if(oneTime == 0){
      oneTime++;
      }
    else{
      String stepOne = inString.replace("\n", "");
      finalNum = Float.valueOf(stepOne);
      print("\n Moisture Value: "); print(finalNum); print(" % Moist");
    }
    
  }
  drawPot();
  drawPlant();
  drawCircle();
  
  prevString = inString;
}

void drawPlant(){
  int x1 = 240;
  int y1 = 150;
  
  noStroke();
  
  fill(0,255,0);
  rectMode(CORNERS);
  rect(x1, y1, x1+20, y1-50);
  
  fill(255,0,0);
  ellipseMode(CENTER);
  ellipse(x1 - 10, y1 - 60, 20,20);
  ellipse(x1 + 10, y1 - 70, 20, 20);
  ellipse(x1 + 30, y1 - 60, 20, 20);
  
  fill(0);
  ellipse(x1 - 10, y1 - 60, 10, 10);
  ellipse(x1 + 10, y1 - 70, 10, 10);
  ellipse(x1 + 30, y1 - 60, 10, 10);
}

void drawPot(){
  int x1 = 150;
  int y1 = 150;
  
  int x2 = x1 + 200;
  int y2 = y1;
  
  int x3 = x2 - 50;
  int y3 = y1 + 200;
  
  int x4 = x1 + 50;
  int y4 = y3;
  
  fill(#CE8C49);
  noStroke();
  beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    vertex(x4, y4);
  endShape();
}

void drawCircle() {
  float angle = map(finalNum,0, 100, 0, 360);
  float fillLine = map(40,0,100,0,360);
  stroke(0,0,255);
  noFill();
  arc(width/2, height/2, width /4, height/4, 0,360);
  
  noStroke();
  fill(0,0,255);
  arc(width/2, height/2, width /4, height /4, 0, radians(angle));
  stroke(0,255,0);
  strokeWeight(5);
  line(width/2, height/2, (width/2) +((width /4)/2)*cos(radians(fillLine)),(height/2) + ((height/4)/2)*sin(radians(fillLine)));
  strokeWeight(1);
}

void serialEvent(Serial p) {
  inString = p.readString();
}
