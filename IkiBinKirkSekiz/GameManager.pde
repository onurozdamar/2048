class GameManager {
  int verticalCellNumber = 4;
  int horizontalCellNumber = 4;

  Cell[][] cells;

  boolean gameOver = false;

  GameManager() {
    cells = new Cell[horizontalCellNumber][verticalCellNumber];

    for (int i = 0; i < horizontalCellNumber; i++) {
      for (int j = 0; j < verticalCellNumber; j++) {
        cells[i][j] = new Cell(new Position(i, j));
      }
    }
  }

  void draw() {
    background(0);

    for (int i = 0; i < horizontalCellNumber; i++) {
      for (int j = 0; j < verticalCellNumber; j++) {
        cells[i][j].draw();
      }
    }

    if (gameOver) {
      fill(0);
      text("oyun bitti", width / 2, height / 2);
    }
  }

  int value = 1; // if value changes it means it is not played
  void keyPressed() {
    if (keyCode != UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT) return;

    int v = 1, previousValue = value;

    if (keyCode == UP) {
      v = slideUp();
    } else if (keyCode == DOWN) {
      v = slideDown();
    } else if (keyCode == LEFT) {
      v = slideLeft();
    } else if (keyCode == RIGHT) {
      v = slideRight();
    }

    value *= v;

    if (value == previousValue) { // kaydıysa rastgele bir kareye sayı koy
      Cell randomEmptyCell = getRandomEmptyCell();
      if (randomEmptyCell != null && randomEmptyCell.isCellEmpty()) {
        randomEmptyCell.setNumber(2);
        value = 1;
      }
    }

    if (!canItSlide()) gameOver = true;
  }

  Cell getRandomEmptyCell() {
    ArrayList < Position > emptyCellsPositions = new ArrayList();

    for (int i = 0; i < horizontalCellNumber; i++) {
      for (int j = 0; j < verticalCellNumber; j++) {
        Position pos = new Position(i, j);
        if (getCell(pos).isCellEmpty()) {
          emptyCellsPositions.add(pos);
        }
      }
    }

    if (emptyCellsPositions.isEmpty()) {
      return null;
    }

    Position randomPosition = 
      emptyCellsPositions.get(int(random(emptyCellsPositions.size())));

    return getCell(randomPosition);
  }

  Cell getCell(Position pos) {
    return cells[pos.getI()][pos.getJ()];
  }

  void startGame() {
    gameOver = false;
    Cell randomEmptyCell = getRandomEmptyCell();
    randomEmptyCell.setNumber(2);
    randomEmptyCell = getRandomEmptyCell();
    randomEmptyCell.setNumber(4);
  }

  int slideLeft() {
    int slide = 2;
    for (int i = 1; i < horizontalCellNumber; i++) {
      for (int j = 0; j < verticalCellNumber; j++) {
        if (!cells[i][j].isCellEmpty() && cells[i][j].equals(cells[i - 1][j])) {
          cells[i - 1][j].setNumber(cells[i][j].getNumber() * 2);
          cells[i][j].setNumber(0);
          slide = 1;
        } 
        if (!cells[i][j].isCellEmpty() && cells[i - 1][j].isCellEmpty()) {
          cells[i - 1][j].setNumber(cells[i][j].getNumber());
          cells[i][j].setNumber(0);
          slideLeft();
          slide = 1;
        }
      }
    }
    return slide;
  }

  int slideRight() { 
    int slide = 3;
    for (int i = 0; i < horizontalCellNumber - 1; i++) {
      for (int j = 0; j < verticalCellNumber; j++) {
        if (!cells[i][j].isCellEmpty() && cells[i][j].equals(cells[i + 1][j])) {
          cells[i + 1][j].setNumber(cells[i][j].getNumber() * 2);
          cells[i][j].setNumber(0);
          slide = 1;
        } 
        if (!cells[i][j].isCellEmpty() && cells[i + 1][j].isCellEmpty()) {
          cells[i + 1][j].setNumber(cells[i][j].getNumber());
          cells[i][j].setNumber(0);
          slideRight();
          slide = 1;
        }
      }
    }
    return slide;
  }

  int slideUp() { 
    int slide = 5;
    for (int i = 0; i < horizontalCellNumber; i++) {
      for (int j = 1; j < verticalCellNumber; j++) {
        if (!cells[i][j].isCellEmpty() && cells[i][j].equals(cells[i][j - 1])) {
          cells[i][j - 1].setNumber(cells[i][j].getNumber() * 2);
          cells[i][j].setNumber(0);
          slide = 1;
        } 
        if (!cells[i][j].isCellEmpty() && cells[i][j - 1].isCellEmpty()) {
          cells[i][j - 1].setNumber(cells[i][j].getNumber());
          cells[i][j].setNumber(0);
          slideUp();
          slide = 1;
        }
      }
    }
    return slide;
  }

  int slideDown() { 
    int slide = 7;
    for (int i = 0; i < horizontalCellNumber; i++) {
      for (int j = 0; j < verticalCellNumber - 1; j++) {
        if (!cells[i][j].isCellEmpty() && cells[i][j].equals(cells[i][j + 1])) {
          cells[i][j + 1].setNumber(cells[i][j].getNumber() * 2);
          cells[i][j].setNumber(0);
          slide = 1;
        } 
        if (!cells[i][j].isCellEmpty() && cells[i][j + 1].isCellEmpty()) {
          cells[i][j + 1].setNumber(cells[i][j].getNumber());
          cells[i][j].setNumber(0);
          slideDown();
          slide = 1;
        }
      }
    }
    return slide;
  }

  boolean canItSlide() {
    boolean canSlideDown = canSlide(0, 0, 0, -1, 0, 1);

    boolean canSlideUp = canSlide(0, 0, 1, 0, 0, -1);

    boolean canSlideRight = canSlide(0, -1, 0, 0, 1, 0);

    boolean canSlideLeft = canSlide(1, 0, 0, 0, -1, 0);

    return canSlideRight || canSlideLeft || canSlideUp || canSlideDown;
  }

  boolean canSlide(int startI, int endI, int startJ, int endJ, int indexI, int indexJ) {
    boolean slide = false;

    for (int i = startI; i < horizontalCellNumber + endI; i++) {
      for (int j = startJ; j < verticalCellNumber + endJ; j++) {
        if (!cells[i][j].isCellEmpty() && cells[i][j].equals(cells[i + indexI][j+indexJ])) {
          slide = true;
        } 
        if (!cells[i][j].isCellEmpty() && cells[i + indexI][j+indexJ].isCellEmpty()) {
          slide = true;
        }
      }
    }

    return slide;
  }
}
