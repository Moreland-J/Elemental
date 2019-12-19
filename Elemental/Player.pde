public class Player {
  PVector pos;
  int width, height;
  PVector velocity, acceleration, gravity;
  float mass, magnitude;
  Corridor corr;
  int minX, maxX, minY, maxY;
  PVector origin;
  boolean jump, duck;
  int element, lives;    // 1 = water, 2 = fire, 3 = air, 4 = earth
  
  Player(int room, int current) {
    // get kind of room and insert player at appropriate position
    // do starting point
    if (room == 1 || room == 2) {
      pos = new PVector(map.corridors[current].tiles[5][map.corridors[current].tiles[5].length - 6].pos.x, map.corridors[current].tiles[5][map.corridors[current].tiles[5].length - 5].pos.y);
      System.out.println(pos.x + " " + pos.y);
    }
    else {
      pos = new PVector(0, 0);
    }
    
    Tile tile = new Tile(0, 0, false);
    this.width = tile.width;
    this.height = tile.height * 2; 
    this.mass = 0.01f;
    this.corr = map.corridors[current];
    
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.gravity = new PVector(0, displayHeight);
    float distance = gravity.mag();
    gravity.mult(3/distance);
    
    this.lives = 5;
  }
  
  public void draw() {
    fill(0, 0, 255);
    rect(pos.x, pos.y, width, height);
    forces();
    
    // return char of direction up or down
  }
  
  // movement, left right and jump
  // affected by collected gems
  
  // SETS TILES OF X AND Y COORDINATES FOR PLAYER
  public void getTiles() {
    // for all 4 corners of player
      
    // I REPRESEENTS X TILES
    for (int i = 0; i < corr.tiles.length; i++) {
      // J REPRESENTS Y TILES
      for (int j = 0; j < corr.tiles[i].length; j++) {
        // check left side
        if (pos.x >= corr.tiles[i][j].pos.x && pos.x <= corr.tiles[i][j].pos.x + width
            && pos.y >= corr.tiles[i][j].pos.y && pos.y <= corr.tiles[i][j].pos.y + height / 2) {
              minX = i;
              minY = j;
              maxX = i + 1;
              maxY = j + 2;
              if (!corr.tiles[minX][maxY].isOn()) {
                minY--;
                maxY--;
                pos.y--;
              }
              return;
        }
      }
    }
  }
  
  
  public char move(char dir) {
    // check walls and floors
    // get current tile
    // check if adding or lessening would move onto off tile
    getTiles();
    
    int speed = 20;
    if (dir == 'a') {
      if (pos.x - speed < corr.tiles[minX][maxY].pos.x && minX == 0) {
        return 'w';
      }
      else if (pos.x - speed < corr.tiles[minX][minY].pos.x && !corr.tiles[minX - 1][minY].isOn()) {
        // get distance between player x and wall
        // minus wall x from player x
        // negate that speed
        pos.x = pos.x - (pos.x - corr.tiles[minX][minY].pos.x);
      }
      //else if (pos.x - speed < corr.tiles[minX][maxY].pos.x && !corr.tiles[minX - 1][maxY].isOn()) {
      //  pos.x = pos.x - (pos.x - corr.tiles[minX][maxY].pos.x);
      //}
      else {
        pos.x = pos.x - speed;
      }
    }
    else if (dir == 'd') {
      if ((pos.x + width + speed) > corr.tiles[maxX][maxY].pos.x + width && maxX == corr.tiles.length - 1) {
        return 'e';
      }
      else if ((pos.x + width + speed) > corr.tiles[maxX][minY].pos.x + width && !corr.tiles[maxX + 1][minY].isOn()) {
        pos.x = pos.x + (corr.tiles[maxX + 1][minY].pos.x - (pos.x + width));
      }
      //else if ((pos.x + width + speed) > corr.tiles[maxX][maxY].pos.x + width && !corr.tiles[maxX + 1][maxY].isOn()) {
      //  pos.x = pos.x + (corr.tiles[maxX + 1][maxY].pos.x - (pos.x + width));
      //}
      else {
        pos.x = pos.x + speed;
      }
    }
    
    
    
    return 'x';
  }
  
  public void forces() {
    getTiles();
    // isOn() FOR FALLING, JUMP FOR INTITIAL RISING
    if ((corr.tiles[maxX][maxY].isOn() && corr.tiles[minX][maxY].isOn()) || jump) {
      applyForces();
      jump = false;
      if (!corr.tiles[minX][maxY].isOn()) {
        System.out.println("sub");
        //pos.sub(velocity);
      }
    }
    //if (duck) {
    //  applyForces();
    //  Tile tile = new Tile();
    //  if (pos.y == origin.y + tile.height) {
    //    duck = false;
    //  }
    //}
  }
  
  public void applyForces() {
    pos.add(velocity);
    acceleration = gravity.copy();
    acceleration.mult(mass);
    velocity.add(acceleration);
    velocity.mult(DAMPING);
    getTiles();
  }
  
  public void jump() {    
    int speed = 75;
    Tile tile = new Tile(0, 0, false);
    PVector target = new PVector(pos.x, pos.y - tile.height * 6);
    PVector vector = new PVector((target.x - pos.x), (target.y - pos.y));
    velocity = new PVector((float)vector.x / speed, (float)vector.y / speed);
    //velocity = velocity.normalize().mult(10);
    jump = true;
  }
  
  public void duck() {
    System.out.println("duck");
    duck = true;
    origin = new PVector();
    origin = pos.copy();
  }
  
  public Projectile fire(int x, int y) {
    Projectile proj = new Projectile((int) pos.x, (int) pos.y, true, 1, x, y);
    return proj;
  }
  
  public void hit() {
    lives--;
    // TODO: drop a gem
  }
}
