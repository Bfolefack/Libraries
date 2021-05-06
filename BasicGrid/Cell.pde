class Cell {
  boolean filled;
  PVector gridPos;
  int borders;
  
  Cell(int x_, int y_, boolean f_){
    gridPos = new PVector(x_, y_);
    filled = f_;
  }
  
  void display(){
    
    if (filled){
      fill(0);
      rect(gridPos.x * gridScale - .01, gridPos.y * gridScale - .01, gridScale + .03, gridScale + .03);
    }
    text(gridPos.x + ", "+ gridPos.y, gridPos.x * gridScale, gridPos.y * gridScale + gridScale/2);
  }
  
  PVector getMouseGridspace() {
    int x, y;
    x = int(truMouseX/gridScale);
    y = int(truMouseY/gridScale);
    return new PVector(x, y);
  }
  
  boolean exists(int x, int y, Cell[][] cells) {
    boolean ifx, ify;
    ifx = true;
    ify = true;
    
    if(x < 0){
      if(x + gridPos.x < 0){
        ifx = false;
      }
    }
    if(x > 0){
      println(x + gridPos.x);
      println(cells[0].length);
      println(x + gridPos.x > cells[0].length);
      if(x + gridPos.x > cells[0].length - 1){
        ifx = false;
      }
    }
    
    if(y < 0){
      if(y + gridPos.y < 0){
        ify = false;
      }
    }
    if(y > 0){
      if(y + gridPos.y > cells.length - 1){
        ify = false;
      }
    }
    if(filled){
      println(ifx + ":" + ify);
    }
    return ifx && ify;
  }
   
  void update(){
     PVector maus = getMouseGridspace();
     if (int(maus.x) == gridPos.x && int(maus.y) == gridPos.y && mousePressed && mouseButton == LEFT){
       filled = true;
     }
   }
}
