public class Tile {
  PVector pos;
  int width, height;
  int col1, col2, col3;
  boolean on, platform;      // on means a part of the room, off means a wall
                            // is there a platform on this tile of the room?
  
  Tile() {
    this.width = displayWidth / 45;
    this.height = displayHeight / 26;
  }
  
  Tile(int x, int y, boolean on) {
    this.pos = new PVector(x, y);
    // generate height and width according to display
    this.width = displayWidth / 45;
    this.height = displayHeight / 26;
    this.on = on;
    
    if (on) {
      turnOn();
    }
    else {
      turnOff();
    }
  }
  
  public void draw() {
    fill(col1, col2, col3);
    rect(pos.x, pos.y, width, height);
  }
  
  public void turnOn() {
    on = true;
    col1 = 192;
    col2 = 192;
    col3 = 192;
  }
  
  public boolean isOn() {
    return on;
  }
  
  public void turnOff() {
    on = false;
    col1 = 32;
    col2 = 32;
    col3 = 32;
  }
  
  public void setPlat() {
    platform = true;
  }
  
  public boolean getPlat() {
    return platform;
  }
}
