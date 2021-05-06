public class Network {



  int inputNum, hiddenSize, hiddenLayers, outputNum;
  float learningRate;
  Matrix[] weights;
  Matrix[] bias;



  Network(int _i, int _hs, int _o, int _hl, float _lr) {

    inputNum = _i;
    outputNum = _o;
    hiddenSize = _hs;
    hiddenLayers = _hl;
    learningRate = _lr;


    weights = new Matrix[hiddenLayers + 1];
    weights[0] = new Matrix(hiddenSize, inputNum);
    weights[0].randomize();
    for (int i = 1; i < weights.length - 1; i++) {
      weights[i] = new Matrix(hiddenSize, hiddenSize);
      weights[i].randomize();
    }
    weights[weights.length - 1] = new Matrix(outputNum, hiddenSize);
    weights[weights.length - 1].randomize();


    bias = new Matrix[weights.length];
    for (int i = 0; i < bias.length - 1; i++) {
      bias[i] = new Matrix(hiddenSize, 1);
      bias[i].randomize();
    }
    bias[bias.length - 1] = new Matrix(outputNum, 1);
    bias[bias.length - 1].randomize();
  }



  float[] guess(float[] inputArr) {
    Matrix inputs = statM.fromArray(inputArr);
    Matrix hidden = statM.staticMultiply(weights[0], inputs);
    hidden.sum(bias[0]);
    hidden.activation();
    for (int i = 1; i < weights.length; i ++) {
      hidden = statM.staticMultiply(weights[i], hidden);
      hidden.sum(bias[i]);
      hidden.activation();
    }
    return hidden.toArray();
  }



  void train(float[] inputArr, float[] targetsArray) {
    if (inputArr.length != inputNum || targetsArray.length != outputNum) {
      println("NETWORK TRAINING INCOMPATIBLE");
      return;
    }

    Matrix[] hiddens = new Matrix[weights.length];

    Matrix inputs = statM.fromArray(inputArr);
    hiddens[0] = inputs;
    Matrix outputs = statM.staticMultiply(weights[0], inputs);
    outputs.sum(bias[0]);
    outputs.activation();

    for (int i = 1; i < weights.length; i ++) {
      hiddens[i] = outputs;
      outputs = statM.staticMultiply(weights[i], outputs);
      outputs.sum(bias[i]);
      outputs.activation();
    }
    Matrix targets = statM.fromArray(targetsArray);
    //Matrix outputError = statM.squaredError(targets, outputs);
    Matrix outputError = statM.staticDiff(targets, outputs);

    Matrix[] errors = new Matrix[bias.length];
    errors[errors.length - 1] = outputError;

    Matrix[] gradients = new Matrix[bias.length];
    gradients[gradients.length - 1] = statM.dActivation(outputs);
    gradients[gradients.length - 1].hadamard(outputError);
    gradients[gradients.length - 1].multiply(learningRate);

    Matrix tran = statM.transpose(hiddens[hiddens.length - 1]);
    Matrix d = statM.staticMultiply(gradients[gradients.length - 1], tran);

    weights[weights.length - 1].sum(d);
    bias[bias.length - 1].sum(gradients[gradients.length - 1]);

    //for (int i = errors.length - 2; i >= 0; i--) {
    //  Matrix traan = statM.transpose(weights[i + 1]);
    //  errors[i] = statM.staticMultiply(traan, errors[i + 1]);
    //}


    //println("errors:");
    //for (Matrix m : errors) {
    //  m.print();
    //}
    for (int i = gradients.length - 2; i >= 0; i--) {
      errors[i] = statM.staticMultiply(statM.transpose(weights[i + 1]), errors[i + 1]);
      
      gradients[i] = statM.dActivation(hiddens[i + 1]);
      gradients[i].hadamard(errors[i]);
      gradients[i].multiply(learningRate);

      Matrix del = statM.staticMultiply(gradients[i], statM.transpose(hiddens[i]));

      weights[i].sum(del);
      bias[i].sum(gradients[i]);
    }
  }

  void print() {
    println("weights:");
    for (Matrix m : weights) {
      m.print();
    }

    println("bias:");
    for (Matrix m : bias) {
      m.print();
    }
  }
}
