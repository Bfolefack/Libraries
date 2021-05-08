float truMouseX;
float truMouseY;
Zoom zoomer;

void setup(){
  size(600, 600);
  zoomer = new Zoom(1);
}

void draw(){
  background(0);
  ellipse(width/2, height/2, 30, 30);
  zoomer.edgePan(5);
  zoomer.keyScale();
  zoomer.pushZoom();
    ellipse(width/2, height/2, 30, 30);
  zoomer.popZoom();
}

void mouseWheel(MouseEvent event){
  zoomer.mouseScale(event, .1);
}
