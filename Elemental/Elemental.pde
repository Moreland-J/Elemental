import ddf.minim.*;
// see YouTube video about importing

int level;
Map map;
int currCorr;          // keeps track of user location

int Element;    // 0 = water, 1 = fire, 2 = earth, 3 = wind
Player player;
ArrayList<Projectile> projs;
final float DAMPING = .995f;

int tileWidth = displayWidth / 45;
int tileHeight = displayHeight / 26;

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
  level = 1;
  restart(); 
}

void restart() {
  createCorridor();
  player = new Player(map.corridors[map.corridors.length - 1].shape, currCorr);
  projs = new ArrayList<Projectile>();
}

public void createCorridor() {
  map = new Map(level);
  currCorr = map.route.size() - 1;
}

void draw() {
  if (player.lives > 0) {
    map.draw(currCorr);
    player.draw();
    
    for (int i = 0; i < map.corridors[currCorr].minions.size(); i++) {
      map.corridors[currCorr].minions.get(i).draw();
    }
    
    for (int i = 0; i < projs.size(); i++) {
      if (projs.get(i).draw()) {
        projs.remove(i);
      }
    }
  }
  else {
    // DISPLAY FINISHED MESSAGE
    // CALL RESET
  }
}

void mouseReleased() {
  //if (currCorr > 0) {
  //  currCorr--;
  //  player.corr = map.corridors[currCorr];
  //}
  projs.add(player.fire(mouseX, mouseY));
}



void keyPressed() {
  char corrChange = 'x';
  if (key == 'a') {
    corrChange = player.move('a');
  }
  else if (key == 'd') {
    corrChange = player.move('d');
  }
  else if (key == 'w' || key == ' ') {
    player.jump();
  }
  else if (key == 's') {
    player.duck();
  }
  
  if (corrChange != 'x') {
    if (corrChange == 'e' && currCorr > 0 && map.checkNext(currCorr) == corrChange) {
      currCorr--;
      player.corr = map.corridors[currCorr];
      player.pos.x = 0;
      projs.clear();
    }
    else if (corrChange == 'e' && map.checkPrev(currCorr) == corrChange) {
      currCorr++;
      player.corr = map.corridors[currCorr];
      player.pos.x = 0;
      projs.clear();
    }
    else if (corrChange == 'w' && currCorr > 0 && map.checkNext(currCorr) == corrChange) {
      currCorr--;
      player.corr = map.corridors[currCorr];
      player.pos.x = map.corridors[currCorr].tiles[map.corridors[currCorr].tiles.length - 1][0].pos.x;
      projs.clear();
    }
    else if (corrChange == 'w' && map.checkPrev(currCorr) == corrChange) {
      currCorr++;
      player.corr = map.corridors[currCorr];
      player.pos.x = map.corridors[currCorr].tiles[map.corridors[currCorr].tiles.length - 1][0].pos.x;
      projs.clear();
    }
  }
  else if (currCorr == 0) {
    // RECALL SEETUP WITH NEW WAVE
  }
}

public void reset() {
  level = 1;
  restart();
}
// rectangles draw from top left corner
