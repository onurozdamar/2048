class Position {

  private float x, y; // coordinate
  private int i, j;  // indexes

  Position() {
    x = -1;
    y = -1;
  }

  Position(int i, int j) {
    this.i = i;
    this.j = j;
  }

  void setX(float x) {
    this.x = x;
  }

  void setY(float y) {
    this.y = y;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  void setI(int i) {
    this.i = i;
  }

  void setJ(int j) {
    this.j = j;
  }

  int getI() {
    return i;
  }

  int getJ() {
    return j;
  }

  String toString() {
    return "x: "+x+" y " + y;
  }
}
