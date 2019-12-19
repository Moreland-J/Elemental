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
      // IF IT REACHES AN ERROR START AGAIN
    }
    
    for (int i = 0; i < route.size(); i++) {
      System.out.println("r x: " + route.get(i).x + " y: " + route.get(i).y);
    }
    
    corridors = new Corridor[route.size()];
    char prev = '0';
    char next = '0';
    // REMEMBER WE'VE SAVED ROUTE IN REVERSE ORDER (goal to start)
    for (int i = 0; i < route.size(); i++) {
      if (i == 0) {
        prev = checkPrev(i);
        next = '0';
        corridors[i] = new Corridor(prev, next);
      }
      else if (i == route.size() - 1) {
        prev = '0';
        next = checkNext(i);
        corridors[i] = new Corridor(prev, next);
      }
      else {
        prev = checkPrev(i);
        next = checkNext(i);
        corridors[i] = new Corridor(prev, next);
      }
    }
    
    // CALL FOR DEFINITE PATH CREATION
    solutionPath();
    
    return corridors;
  }
  
  public boolean findPath(int x, int y, int minDist) {
    // now writing pseudo as real code
    if (x == goal.x && y == goal.y && minDist <= 0) {
      addCoords(x, y);
      return true;
    }
    
    // ERROR
    if (x >= area.length || x < 0 || y >= area[0].length || y < 0 || area[x][y]) {
      return false;
    }
    
    // ADD PREVIOUS CORRIDOR TO PATH
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
  
  // CHECK DIRECTION LAST CORRIDOR CAME FROM
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
  
  // CHECK WHAT DIRECTION NEXT CORRIDOR IS GOING TO
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
  
  // ENSURES PATH ALONG ALL CORRIDORS
  public void solutionPath() {
    //for (int i = corridors.length - 1; i > 0; i--) {
    //  // GET X, Y FROM CORRIDOR SPACE
    //  PVector current = new PVector((int) random(4, corridors[i].tiles.length - 5), (int) random(9, corridors[i].tiles[0].length - 7));
    //  PVector next = new PVector((int) random(4, corridors[i - 1].tiles.length - 5), (int) random(9, corridors[i - 1].tiles[0].length - 7));
    //  PVector cursor = current.copy();
      
    //  while (cursor.x != next.x && cursor.y != next.y) {
    //    // choose to make either platform or ladder (go vertical or horizontal movement)
    //    if (corridors[i].shape == 1 || corridors[i].shape == 4 || corridors[i].shape ==  7 || corridors[i].shape == 8 || corridors[i].shape ==  9
    //        && (corridors[i - 1].shape == 1 || corridors[i - 1].shape == 4 || corridors[i - 1].shape == 6 || corridors[i - 1].shape == 7 || corridors[i - 1].shape == 8 || corridors[i - 1].shape == 9)) {
    //      // draw platform at location
    //      corridors[i].addPlat((int) cursor.x, (int) cursor.y, (int) next.x, (int) next.y, checkNext(i));
    //      cursor.x = next.x;
    //    }
    //    else {
    //      // draw ladder at location?
    //      // go up with no ladder?
    //      cursor.y = next.y;
    //    }
    //  }
      
    //  cursor.y = next.y;
    //  corridors[i].addPlat((int) cursor.x, (int) cursor.y, (int) next.x, (int) next.y, checkNext(i));
    //}
    
    for (int i = corridors.length - 1; i >= 0; i--) {
      corridors[i].constructPlats();
    }
  }
}
