public class Map {
  int level;
  PVector goal;
  Corridor[] corridors;
  Room room;
  
  Map(int level) {
    this.level = level;
    this.goal = new PVector((int) random(0 + tile.width * , displayWidth), (int) random());
    this.corridors = makePath();
  }
  
  // keep a clear section above/below/to sides of corridor
  public Corridor[] makePath() {
    // random 
    findPath();
  }
  
  public void findPath(int x, int y, int minDist) {
    if () {
      
    }
  }
}
