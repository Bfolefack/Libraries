// Will eventually be replaced by EJML
class Matrix {
  float[][] matrix;
  int rows, cols;


  Matrix(int w_, int h_) {
    rows = w_;
    cols = h_;
    matrix = new float[rows][cols];
    for (int i = 0; i < rows; i++) {
      float[] temp = new float[cols];
      for (int j = 0; j < cols; j++) {
        temp[j] = 0f;
      }
      matrix[i] = temp;
    }
  }



  Matrix clone(Matrix m) {
    Matrix result = new Matrix(m.rows, m.cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result.matrix[i][j] = m.matrix[i][j];
      }
    }
    return result;
  }

  Matrix clone() {
    Matrix result = new Matrix(rows, cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result.matrix[i][j] = matrix[i][j];
      }
    }
    return result;
  }
  /*********************************************************************************************************************/

  String parseString() {
    String s = "";
    for (int i = 0; i < matrix.length; i++) {
      s += "[ ";
      for (int j = 0; j < matrix[i].length; j++) {
        s += matrix[i][j];
        if (j < matrix[i].length -1) {
          s += ", ";
        }
      }
      s += " ] \n";
    }
    return s;
  }

  void print() {
    println(parseString());
  }

  /*********************************************************************************************************************/

  void setVals(float[][] f) {
    if (f.length == matrix.length && f[0].length == matrix[0].length) {
      matrix = f;
    } else { 
      println("ERROR: LENGTH MISMATCH IN SETVALS()");
    }
  }

  void setVal(int x, int y, float f) {
    matrix[y][x] = f;
  }

  /*********************************************************************************************************************/

  float[][] getVals() {
    return matrix;
  }

  float getVal(int y, int x) {
    return matrix[y][x];
  }

  /*********************************************************************************************************************/

  void randomize() {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        matrix[i][j] = random(-1, 1);
      }
    }
  }
  
  Matrix statRandomize(int rows, int cols) {
    Matrix r = new Matrix(rows, cols);
    for (int i = 0; i < r.matrix.length; i++) {
      for (int j = 0; j < r.matrix[i].length; j++) {
        r.matrix[i][j] = random(-1, 1);
      }
    }
    return r;
  }

  /*********************************************************************************************************************/

  void simpleSum(float f) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        matrix[i][j] += f;
      }
    }
  }

  void sum(float[][] f) {
    if (f.length == matrix.length && f[0].length == matrix[0].length) {
      for (int i = 0; i < matrix.length; i++) {
        for (int j = 0; j < matrix[i].length; j++) {
          matrix[i][j] += f[i][j];
        }
      }
    }
  }

  void sum(Matrix m) {
    sum(m.getVals());
  }

  float[][] staticSum(float[][] f, float[][] m) {
    float[][] c = new float[f.length][f[0].length];
    if (f.length == m.length && f[0].length == m[0].length) {
      for (int i = 0; i < m.length; i++) {
        for (int j = 0; j < m[i].length; j++) {
          c[i][j] = m[i][j] + f[i][j];
        }
      }
    }
    return c;
  }

  Matrix staticSum(Matrix m, Matrix f) {
    Matrix r = new Matrix(m.rows, m.cols);
    r.setVals(staticSum(m.getVals(), f.getVals()));
    return r;
  }

  /*********************************************************************************************************************/

  void simpleDiff(float f) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        matrix[i][j] -= f;
      }
    }
  }

  void diff(float[][] f) {
    if (f.length == matrix.length && f[0].length == matrix[0].length) {
      for (int i = 0; i < matrix.length; i++) {
        for (int j = 0; j < matrix[i].length; j++) {
          matrix[i][j] -= f[i][j];
        }
      }
    }
  }

  void diff(Matrix m) {
    diff(m.getVals());
  }

  float[][] staticDiff(float[][] m, float[][] f) {
    float[][] c = new float[f.length][f[0].length];
    if (f.length == m.length && f[0].length == m[0].length) {
      for (int i = 0; i < m.length; i++) {
        for (int j = 0; j < m[i].length; j++) {
          c[i][j] = m[i][j] - f[i][j];
        }
      }
    } else {
      println("ERROR: SUBTRACTION INCOMPATIBLE");
    }
    return c;
  }

  Matrix staticDiff(Matrix m, Matrix f) {
    Matrix r = new Matrix(m.rows, m.cols);
    r.setVals(staticDiff(m.getVals(), f.getVals()));
    return r;
  }
  /*********************************************************************************************************************/

  void multiply(float a) {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        matrix[i][j] *= a;
      }
    }
  }

  Matrix staticMultiply(float a) {
    Matrix result = new Matrix(rows, cols);
    result.setVals(matrix);
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        result.matrix[i][j] *= a;
      }
    }
    return result;
  }

  float[][] multiply(float[][] b) {
    float[][] a = matrix.clone();
    if (a[0].length != b.length) {
      println("ERROR MATRIX MULTIPLICATION INCOMPATIBLE");
      return a;
    }

    float[][] result = new float[a.length][b[0].length];
    for (int i = 0; i < result.length; i++) {
      for (int j = 0; j < result[0].length; j++) {
        float sum = 0;
        for (int k = 0; k < a[0].length; k++) {
          sum += a[i][k] * b[k][j];
        }
        result[i][j] = sum;
      }
    }

    return result;
  }

  float[][] staticMultiply(float[][] a, float[][] b) {
    if (a[0].length != b.length) {
      println("ERROR MATRIX MULTIPLICATION INCOMPATIBLE");
      return a;
    }

    float[][] result = new float[a.length][b[0].length];
    for (int i = 0; i < result.length; i++) {
      for (int j = 0; j < result[0].length; j++) {
        float sum = 0;
        for (int k = 0; k < a[0].length; k++) {
          sum += a[i][k] * b[k][j];
        }
        result[i][j] = sum;
      }
    }

    return result;
  }

  Matrix hadamard(Matrix f) {
    Matrix result = new Matrix(rows, cols);
    if (f.matrix.length == matrix.length && f.matrix[0].length == matrix[0].length) {
      for (int i = 0; i < matrix.length; i++) {
        for (int j = 0; j < matrix[i].length; j++) {
          result.matrix[i][j] = matrix[i][j] * f.matrix[i][j];
        }
      }
    } else {
      println("ERROR HADAMARD INCOMPATIBLE");
    }
    return result;
  }

  Matrix multiply(Matrix m) {
    Matrix result = new Matrix(rows, m.cols);
    result.setVals(multiply(m.matrix.clone()));
    return result;
  }

  Matrix staticMultiply(Matrix m, Matrix f) {
    Matrix result = new Matrix(m.rows, f.cols);
    result.setVals(staticMultiply(m.matrix, f.matrix));
    return result;
  }

  /*********************************************************************************************************************/

  float[][] transposeArr() {

    float[][] result = new float[cols][rows];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result[j][i] = matrix[i][j];
      }
    }

    return result;
  }

  float[][] transposeArr(Matrix m) {

    float[][] result = new float[m.cols][m.rows];
    for (int i = 0; i < m.rows; i++) {
      for (int j = 0; j < m.cols; j++) {
        result[j][i] = m.matrix[i][j];
      }
    }

    return result;
  }

  Matrix transpose() {
    Matrix result = new Matrix(cols, rows);
    result.setVals(transposeArr());
    return result;
  }

  Matrix transpose(Matrix m) {
    Matrix result = new Matrix(m.cols, m.rows);
    result.setVals(transposeArr(m));
    return result;
  }

  /*********************************************************************************************************************/

  void sigmoid() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        matrix[i][j] = (float)(1/(1 + Math.pow(e, -matrix[i][j])));
      }
    }
  }

  void dsigmoid() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        matrix[i][j] = matrix[i][j] * (1 - matrix[i][j]);
      }
    }
  }
  
  Matrix dsigmoid(Matrix m) {
    Matrix result = new Matrix(m.rows, m.cols);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result.matrix[i][j] = m.matrix[i][j] * (1 - m.matrix[i][j]);
      }
    }
    return result;
  }

  /*********************************************************************************************************************/

  Matrix fromArray(float[] f) {
    Matrix m = new Matrix(1, f.length);
    m.setVals(new float[][]{f});
    m = m.transpose();
    return m;
  }

  float[] toArray() {
    float[] f = new float[rows * cols];
    int count = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        f[count] = matrix[i][j];
        count++;
      }
    }
    return f;
  }

  /*********************************************************************************************************************/
}
