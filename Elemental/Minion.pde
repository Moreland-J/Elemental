class Minion {
  PVector pos;
  int width, height;
  int col1, col2, col3;
  
  int element, health;
  
  Minion() {
    this.pos = new PVector((int) random(displayWidth / 8, displayWidth / 8 * 7), (int) random(displayHeight / 8, displayHeight / 8 * 7));
    
    // TODO: check if minion is in the platform
    //        keep finding x and y until it's gone
    
    this.width = displayWidth / 45;
    this.height = displayHeight / 26;
    this.element = (int) random(1, level + 1);
    this.health = 3;
    switch (element) {
      case 1:    // WATER
        this.col1 = 0;
        this.col2 = 65;
        this.col3 = 194;
        break;
      case 2:    // FIRE
        this.col1 = 228;
        this.col2 = 34;
        this.col3 = 23;
        break;
      case 3:    // AIR
        this.col1 = 255;
        this.col2 = 255;
        this.col3 = 255;
        break;
      case 4:    // EARTH
        this.col1 = 52;
        this.col2 = 128;
        this.col3 = 23;
        break;
    }
  }
  
  public void draw() {
    fill(col1, col2, col3);
    ellipse(pos.x, pos.y, width, height);
    move();
  }
  
  public void move() {
    // A* tracking
    // fire possibility
  }
  
  // RETURNS PROJECTILE TO MAIN PROCESS
  //public Projectile fire() {
  //  Projectile proj = new Projectile();
  //  return proj;
  //}
  
  public void hit() {
    
  }
}
