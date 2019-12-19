public class Projectile {
  PVector pos, vector, velocity;
  int width, height;
  boolean owner;  // true = player, false = enemy
  int element;    // water, fire, air, earth
  int col1, col2, col3;
  
  Projectile(int x, int y, boolean owner, int element, int tx, int ty) {
    this.pos = new PVector(x, y);
    this.width = displayWidth / 80;
    this.height = displayHeight / 50;
    this.owner = owner;
    this.element = element;
    
    int speed = 5;
    switch (element) {
      case 1:    // WATER
        this.col1 = 0;
        this.col2 = 65;
        this.col3 = 194;
        speed = 6;
        break;
      case 2:    // FIRE
        this.col1 = 228;
        this.col2 = 34;
        this.col3 = 23;
        speed = 8;
        break;
      case 3:    // AIR
        this.col1 = 255;
        this.col2 = 255;
        this.col3 = 255;
        speed = 8;
        break;
      case 4:    // EARTH
        this.col1 = 52;
        this.col2 = 128;
        this.col3 = 23;
        speed = 5;
        break;
    }
    
    this.vector = new PVector(tx - pos.x, ty - pos.y);
    this.velocity = new PVector((float)vector.x * 100, (float)vector.y * 100);
    velocity = velocity.normalize().mult(speed);
  }
  
  public boolean draw() {
    fill(col1, col2, col3);
    ellipse(pos.x, pos.y, width, height);
    return move();
  }
  
  public boolean move() {
    pos.add(velocity);
    // CHECK COLLISIONS
    if (collision() || impact() || attack()) {
      return true;
    }
    return false;
  }
  
  // DETECT COLLISION BETWEEN PROJECTILES
  public boolean collision() {
    
    // REMOVE PROJ OF SPECIFIC INDEX
    
    return false;
  }
  
  // PROJECTILE MAKES CONTACT WITH A WALL
  public boolean impact() {
    PVector dist = new PVector();
    
    for (int i = 0; i < map.corridors[currCorr].platforms.size(); i++){ //<>// //<>//
      Tile tile = map.corridors[currCorr].tiles[(int) map.corridors[currCorr].platforms.get(i).x][(int) map.corridors[currCorr].platforms.get(i).y];
      dist.x = abs(pos.x - (tile.pos.x + tile.width / 2));
      dist.y = abs(pos.y - (tile.pos.y + tile.height / 2));

      // CHECK IF BEYOND LIMITS
      if (dist.x > tile.width / 2 + width / 2) {
        //return false;
      }
      if (dist.y > tile.height / 2 + height / 2) {
        //return false;
      }

      // CHECK IF WITHIN LIMITS
      if (dist.x <= tile.width / 2 && dist.y <= tile.height / 2) {
        return true;
      }
      
      int square = (int) Math.pow(dist.x - tile.width / 2, 2) + (int) Math.pow(dist.y - tile.height / 2, 2); 
      if (square <= (int) Math.pow(width / 2, 2)) {
        return true;
      }
    }
    return false;
  }
  
  // RETURN INDEX OF CHARACTER TO DO DAMAGE TO
  public boolean attack() {
    // CALL CHARACTER TO HAVE DAMAGE
    
    return false;
  }
}
