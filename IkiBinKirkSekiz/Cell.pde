class Cell {

  private Position position;
  private int cellSize = 150;

  private int number = 0;

  private color[] cellColors = {color(#D3D3D3), color(#E5DBCE), color(#F0D4B3), 
    color(#EDB269), color(#E57035), color(#C14040), color(#D81C1C), 
    color(#DECC48), color(#F2DC2E), color(#3FB22F), color(#27FC08)};

  Cell(Position position) {
    this.position = position;
    position.setX(position.getI() * cellSize);
    position.setY(position.getJ() * cellSize);
  }

  void draw() {
    fill(getColor());
    rect(position.getX(), position.getY(), cellSize, cellSize);
    if (!isCellEmpty()) {
      fill(0);
      textSize(40);
      textAlign(CENTER);
      text(number + " ", position.getX() + cellSize/2, 
        position.getY() + cellSize/2 + 10);
    }
  }

  void setNumber(int number) {
    this.number = number;
  }

  int getNumber() {
    return number;
  }

  color getColor() {
    return isCellEmpty() ? 
      cellColors[(int)(log(1)/log(2))] :
      cellColors[(int)(log(number)/log(2))];
  }

  boolean isCellEmpty() {
    return number == 0;
  }

  boolean equals(Cell other) {
    return this.number == other.getNumber();
  }
}
