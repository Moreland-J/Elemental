import ddf.minim.*;
// see YouTube video about importing

int level;
Map map;
int currCorr;          // keeps track of user location

int Element;    // 0 = water, 1 = fire, 2 = earth, 3 = wind
Player player;
Minion minions;
// https://stackoverflow.com/questions/4134970/java-array-of-objects-and-inheritance


Minim minim;
AudioPlayer sound;

/*
minim = new Minim(this);
sound = minim.loadFile("shot.wav");

sound.play();
sound.rewind();
*/

void setup() {
  fullScreen();
  createCorridor();
}

public void createCorridor() {
  map = new Map(level);
  currCorr = map.route.size() - 1;
}

void draw() {
  map.draw(currCorr);
}

void mousePressed() {
  if (currCorr > 0) {
    currCorr--;
  }
}

// rectangles draw from top left corner
