int gridScale;
Grid griddle;
void setup () {
  size(1000, 700);
  gridScale = 50;
  griddle = new Grid(0, 0, width/gridScale, height/gridScale);
}

void draw () {
  background(150);
  griddle.update();
  griddle.display();
}
