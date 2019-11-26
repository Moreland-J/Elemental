public class Tile {
  int width, height;
  int col1, col2, col3;
  
  Tile() {
    // generate height and width according to display
    this.width = displayWidth / 24;
    this.height = displayHeight / 16;
  }
}
