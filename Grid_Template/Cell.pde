class Cell {
  boolean filled;
  PVector gridPos;
  int borders;

  Cell(int x_, int y_, boolean f_) {
    gridPos = new PVector(x_, y_);
    filled = f_;
  }

  void display() {
    if (filled) {
      fill(0);
      rect(gridPos.x * gridScale, gridPos.y * gridScale, gridScale, gridScale);
      stroke(0, 255, 0);
    }
    fill(0, 255, 0);
    textSize(10);
    text(borders, gridPos.x * gridScale + gridScale/2, gridPos.y * gridScale + gridScale/2);
  }

  PVector getMouseGridspace() {
    int x, y;
    x = int(mouseX/gridScale);
    y = int(mouseY/gridScale);
    return new PVector(x, y);
  }

  void fillUp() {
    filled = true;
  }

  boolean exists(int x, int y, Cell[][] cells) {
    boolean ifx = true, ify = true;
    if (gridPos.x + x < 0 || gridPos.x + x > cells[0].length - 1) {
      ifx = false;
    }
    if (gridPos.y + y < 0 || gridPos.y + y > cells.length - 1) {
      ify = false;
    }
    return ifx && ify;
  }

  void update(Cell[][] cells) {
    PVector maus = getMouseGridspace();
    if (int(maus.x) == gridPos.x && int(maus.y) == gridPos.y && mousePressed) {
      //println(maus +""+ gridPos + filled);
      fillUp();
    }
    borders = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (!( i ==0 && j == 0)) {

          if (exists(i, j, cells)) {
            if (cells[int(gridPos.y + j)][int(gridPos.x + i)].filled) {
              borders++;
            }
          }
          
        }
      }
    }
  }
}
