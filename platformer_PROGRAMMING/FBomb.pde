class FBomb extends FBox {
  int timer; 

  FBomb() {
    super(gridSize, gridSize); //fbox constructor
    this.setFillColor(red);
    this.setPosition(player1.getX() +gridSize, player1.getY());
    timer = 60;
    this.setRotatable(false);
    world.add(this);
  }

  void tick() {
    timer--; 
    if (timer ==0) {
      explode();
      world.remove(this);
      bomb = null;
    }
  }

  void explode() {
    for (int i = 0; i < boxes.size(); i++) {
      FBox b = boxes.get(i);
      if (dist(this.getX(), this.getY(), b.getX(), b.getY())<200) {
        b.setStatic(false);
        vx = b.getX() - this.getX();
        vy = b.getY() - this.getY();
        b.setVelocity(vx*4, vy*4);
      }
    }
  }
}
