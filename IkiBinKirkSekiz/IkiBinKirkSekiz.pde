

GameManager gameManager;

void setup() {
  size(600, 600);

  gameManager = new GameManager();

  gameManager.startGame();
}

void draw() {
  gameManager.draw();
}

void keyPressed() {
  gameManager.keyPressed();
}
