public class Corridor {
  Tile[][] tiles;
  int type;    // 1 = s, 2 = r, 3 = g
  int shape;  // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
  
  Corridor(char prev, char next) {
    getCorrShape(prev, next);
    //System.out.println(shape);
    
    // tiles arranged according to shape
    Tile tile = new Tile(0, 0, false);
    tiles = new Tile[(displayWidth / tile.width) + 1][(displayHeight / tile.height) + 1];
    setTiles();
  }
  
  public void draw() {
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) {
        tiles[i][j].draw();
      }
    }
  }
  
  public void getCorrShape(char prev, char next) {
    // shape of start corridor
    // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
    if (prev == '0') {
      type = 1;
      if (next == 'n') {
        shape = 2;
      }
      else if (next == 's') {
        shape = 3;
      }
      else if (next == 'e') {
        shape = 1;
      }
    }
    
    // shape of end corridor
    // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
    else if (next == '0') {
      type = 3;
      if (prev == 'n' || prev == 's') {
        shape = 5;
      }
      else if (prev == 'w') {
        shape = 4;
      }
    }
    
    // shape of mid corridor
    // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
    else {
      type = 2;
      if ((prev == 'w' && next == 'e') || (prev == 'e' && next == 'w')) {
        shape = 4;
      }
      else if ((prev == 's' && next == 'n') || (prev == 'n' && next == 's')) {
        shape = 5;
      }
      else if ((prev == 'n' && next == 'e') || (prev == 'e' && next == 'n')) {
        shape = 6;
      }
      else if ((prev == 'w' && next == 'n') || (prev == 'n' && next == 'w')) {
        shape = 7;
      }
      else if ((prev == 's' && next == 'e') || (prev == 'e' && next == 's')) {
        shape = 8;
      }
      else if ((prev == 'w' && next == 's') || (prev == 's' && next == 'w')) {
        shape = 9;
      }
    }
    // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
  }
  
  public void setTiles() {
    // create all tiles
    Tile tile = new Tile(0, 0, false);
    int x = 0;
    int y = 0;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) {
        tiles[i][j] = new Tile(x, y, true);
        y = y + tile.height;
      }
      y = 0;
      x = x + tile.width;
    }
    
    // use shape to define tile positioning
    // top wall
    if (shape == 1 || shape == 3 || shape == 4 || shape == 8 || shape == 9) {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i][0].turnOff();
        tiles[i][1].turnOff();
        tiles[i][2].turnOff();
      }
    }
    // bottom wall
    if (shape == 1 || shape == 2 || shape == 4 || shape == 6 || shape == 7) {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i][tiles[i].length - 1].turnOff();
        tiles[i][tiles[i].length - 2].turnOff();
        tiles[i][tiles[i].length - 3].turnOff();
      }
    }
    // left wall
    if (shape == 1 || shape == 2 || shape == 3 || shape == 5 || shape == 6 || shape == 8) {
      for (int i = 0; i < tiles[0].length; i++) {
        tiles[0][i].turnOff();
        tiles[1][i].turnOff();
        tiles[2][i].turnOff();
      }
    }
    // right wall
    if (shape == 2 || shape == 3 || shape == 5 || shape == 7 || shape == 9) {
      for (int i = 0; i < tiles[0].length; i++) {
        tiles[tiles.length - 1][i].turnOff();
        tiles[tiles.length - 2][i].turnOff();
        tiles[tiles.length - 3][i].turnOff();
      }
    }
    
    // corner piece blocks
    // 1 = ls, 2 = bs, 3 = ts, 4 = hori, 5 = vert, 6 = blc, 7 = brc, 8 = tlc, 9 = trc
    if (shape == 6) {
      tiles[tiles.length - 1][tiles[tiles.length - 1].length - 1].turnOff();
      tiles[tiles.length - 2][tiles[tiles.length - 1].length - 2].turnOff();
    }
    if (shape == 7) {
      tiles[0][0].turnOff();
      tiles[0][1].turnOff();
      tiles[1][0].turnOff();
      tiles[1][1].turnOff();
    }
    if (shape == 8) {
      
    }
    if (shape == 9) {
      
    }
  }
}

// http://fbksoft.com/procedural-level-generation-for-a-2d-platformer/
