//import ddf.minim.*;
// see YouTube video about importing

int level;
Map map;
Corridor[] corridors;
Room room;

int Element;    // 0 = water, 1 = fire, 2 = earth, 3 = wind
Player player;
Minion minions;
// https://stackoverflow.com/questions/4134970/java-array-of-objects-and-inheritance


//Minim minim;
//AudioPlayer sound;

/*
minim = new Minim(this);
sound = minim.loadFile("shot.wav");

sound.play();
sound.rewind();
*/

void setup() {
  //createCorridor();
}

public void createCorridor() {
  map = new Map(level);
  map.makePath();
}

void draw() {
  
}
