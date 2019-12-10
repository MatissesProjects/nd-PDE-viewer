int cols = 200;
int rows = 200;

float [][] curr, prev;

float dampening = .9; //0-.9
float throwStrength = 500; //300-600 is good

void setup() {
  size(600, 400);
  cols = width;
  rows = height;
  curr = new float[cols][rows];
  prev = new float[cols][rows];
}

void draw() {
  background(0);
  loadPixels();
  for( int i = 1; i < cols-1; ++i) {
    for( int j = 1; j < rows-1; ++j) {
      // Check the things around me and subtract my amount
      curr[i][j] = (prev[i-1][j] +
                    prev[i+1][j] +
                    prev[i][j-1] +
                    prev[i][j+1]) / 2 -
                    curr[i][j];
      curr[i][j] = curr[i][j] * dampening;
      
      int index = i + j * cols;
      pixels[index] = color(curr[i][j]);
    }
  }
  updatePixels();
  
  float[][] temp = prev;
  prev = curr;
  curr = temp;
}

void mouseDragged() {
  try {
    prev[mouseX][mouseY] = throwStrength;
  } catch(ArrayIndexOutOfBoundsException e)
  {
    // ignore out of bounds
  }
}
