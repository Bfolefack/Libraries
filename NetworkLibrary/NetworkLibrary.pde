Network n;
Matrix statM = new Matrix(1, 1);

static float e = 2.7182817;
float[] a;
float[] outputs;
float[] targets;
XORData[] data;

void setup(){
  surface.setVisible(false);
  n = new Network(2, 2, 1, 2, 0.1);
  XORData[] data = new XORData[]{
    new XORData(1, 1, 0),
    new XORData(1, 0, 1),
    new XORData(0, 1, 1),
    new XORData(0, 0, 0)
  };
  for(int i = 0; i < 100000; i++){
    int a = (int) Math.floor(Math.random() * 4);
    XORData d = data[a];
    n.train(d.inputs, d.ans);
    //n.train(new float[]{1}, new float[]{0});
  }
  
  n.print();
  
  println(n.guess(new float[]{1, 1}));
  println(n.guess(new float[]{1, 0}));
  println(n.guess(new float[]{0, 1}));
  println(n.guess(new float[]{0, 0}));
}
