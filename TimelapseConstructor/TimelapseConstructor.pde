import java.io.*;
import java.util.*;
boolean showFrame;
boolean paused;
float truMouseX;
float truMouseY;
int numOfPhotos;
Zoom zoomer;

String folder = "TimeLapse2/";
void setup() {
  size(1000, 1000);
  int count = 1;
  while (true) {
    File f = dataFile(folder + count + ".jpg");
    String filePath = f.getPath();
    boolean exist = f.isFile();
    //println(filePath, exist);
    if(!exist){
      break;
    }
    frameRate(120);
    count++;
  }
  count--;
  numOfPhotos = count;
  zoomer = new Zoom(1);
  println(count);
}


void draw(){
  background(0);
  zoomer.pushZoom();
  zoomer.mousePan();
  image(loadImage(folder + ""  + (abs(frameCount % numOfPhotos) + 1) + ".jpg"), 0, 0);
  if(paused){
    frameCount--;
  }
  zoomer.popZoom();
  textSize(100);
  if(showFrame){
    fill(125);
    text("Frame:" + (frameCount % numOfPhotos), 10, 100);
  }
}


void keyPressed(){
  if(key == 'f'){
    showFrame = !showFrame;
  }
  if(key == 'd'){
    frameCount += 100;
  }
  if(key == 'a'){
    frameCount -= 100;
  }
  if(key == 'p'){
     paused = !paused;
  }
}

void mouseWheel(MouseEvent event) {
  zoomer.mouseScale(event, 0.1);
}
