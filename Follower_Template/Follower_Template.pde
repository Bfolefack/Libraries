Agent p;
PVector mouse;
void setup(){
  size(800, 600);
  p = new Agent(width/2, height/2, 4, 0.9);
}

void draw() {
  background(175);
  p.update();
  p.display();
}
