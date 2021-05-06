// Will eventually be replaced by EJML
Matrix a, b, c;
final float e = 2.7182818284590452353602874713527;
void setup(){
  Matrix m = new Matrix(2, 3);
  a = new Matrix(2, 3);
  b = new Matrix(2, 3);
  c = new Matrix(3, 2);
  
  a.setVals( new float[][]{
     {3, 5, -6},
     {2, -8, 5}
    }
  );
  
  b.setVals( new float[][]{
     {4, 2, 3},
     {9, 6, 2}
    }
  );
  
  c.setVals( new float[][]{
     {5, -8},
     {3, -9},
     {-5, 2}
    }
  );
  
  m.staticSum(a, b).print(); //CORRECT
  m.staticDiff(a, b).print(); //CORRECT
  a.clone().print(); //CORRECT
  m.clone(a).print(); //CORRECT
  println(a.parseString()); //CORRECT
  println(a.getVal(1, 2)); //CORRECT
  m.statRandomize(3, 3).print(); //CORRECT
  m.staticMultiply(b, c).print(); //CORRECT
  a.transpose().print(); //CORRECT
  b.hadamard(a).print(); //CORRECT
  a.sigmoid(); //CORRECT
  a.print();
  m.fromArray(new float[]{3, 8, 9 ,7}).print();
}
