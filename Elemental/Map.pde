public class Map {
  int level;
  boolean[][] area;
  ArrayList<PVector> route;
  PVector goal;
  Corridor[] corridors;
  Room room;
  
  Map(int level) {
    this.level = level;
    area = new boolean[5 + level][5 + level];
    route = new ArrayList<PVector>();
    this.goal = new PVector(area.length - 1, (int) random(0, area[0].length));
    System.out.println("Goal x: " + goal.x + " y: " + goal.y);
    area[(int) this.goal.x][(int) this.goal.y] = true;
    this.corridors = makePath();
    this.room = new Room(level);
  }
  
  public void draw(int current) {
    corridors[current].draw();
  }
  
  // keep a clear section above/below/to sides of corridor
  public Corridor[] makePath() {
    int startX = 0;
    int startY = (int) random (0, area[0].length);
    while (startY == goal.y) {
      startY = (int) random (0, area.length);
    }
    
    System.out.println("Start x: " + startX + " y: " + startY);
    while (!findPath(startX, startY, 5)) {
      // repeat
    }
    
    for (int i = 0; i < route.size(); i++) {
      System.out.println("r x: " + route.get(i).x + " y: " + route.get(i).y);
    }
    
    corridors = new Corridor[route.size()];
    // make corridors out of route
    char prev = '0';
    char next = '0';
    // remember we've saved the route in reverse order (goal to start)
    for (int i = 0; i < route.size(); i++) {
      if (i == 0) {
        // don't check next, just check prev
        prev = checkPrev(i);
        next = '0';
        corridors[i] = new Corridor(prev, next);
      }
      else if (i == route.size() - 1) {
        // don't check prev, just check next
        prev = '0';
        next = checkNext(i);
        corridors[i] = new Corridor(prev, next);
      }
      else {
        // check prev and next
        prev = checkPrev(i);
        next = checkNext(i);
        corridors[i] = new Corridor(prev, next);
      }
      //System.out.println(prev + " " + next);
    }
    
    return corridors;
  }
  
  public boolean findPath(int x, int y, int minDist) {
    // now writing pseudo as real code
    if (x == goal.x && y == goal.y && minDist <= 0) {
      addCoords(x, y);
      return true;
    }
    
    //System.out.println("x: " + x + " y: " + y);
    if (x >= area.length || x < 0 || y >= area[0].length || y < 0 || area[x][y]) {
      //System.out.println("Error");
      return false;
    }
    
    area[x][y] = true;
    switch((int) random(1, 5)) {
      case 1:
        if (findPath(x, y - 1, minDist - 1)) {
          addCoords(x, y);
          return true;
        }
      case 2:
        if (findPath(x + 1, y, minDist - 1)) {
          addCoords(x, y);
          return true;
        }
      case 3:
        if (findPath(x, y + 1, minDist - 1)) {
          addCoords(x, y);
          return true;
        }
      case 4:
        if (findPath(x - 1, y, minDist - 1)) {
          addCoords(x, y);
          return true;
        }
    }
    area[x][y] = false;
    return false;
  }
  
  public void addCoords(int x, int y) {
    if (!route.contains(new PVector(x, y))) {
      route.add(new PVector(x, y));
    }
  }
  
  public char checkPrev(int i) {
    if (north(i, i + 1)) {
      return 'n';
    }
    else if (south(i, i + 1)) {
      return 's';
    }
    else if (east(i, i + 1)) {
      return 'e';
    }
    else if (west(i, i + 1)) {
      return 'w';
    }
    return 'u';
  }
  
  public char checkNext(int i) {
    if (north(i, i - 1)) {
      return 'n';
    }
    else if (south(i, i - 1)) {
      return 's';
    }
    else if (east(i, i - 1)) {
      return 'e';
    }
    else if (west(i, i - 1)) {
      return 'w';
    }
    return 'u';
  }
  
  public boolean north(int i, int j) {
    if (route.get(j).y < route.get(i).y) {
      return true;
    }
    return false; 
  }
  
  public boolean south(int i, int j) {
    if (route.get(j).y > route.get(i).y) {
      return true;
    }
    return false; 
  }
  
  public boolean east(int i, int j) {
    if (route.get(j).x > route.get(i).x) {
      return true;
    }
    return false; 
  }
  
  public boolean west(int i, int j) {
    if (route.get(j).x < route.get(i).x) {
      return true;
    }
    return false; 
  }
}
