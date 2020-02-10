import fisica.*;

color black = #000000;
color green = color(0,255,0);
color blue = color(153, 217, 234);
color yellow = color(255, 242, 0);
color brown = color(185, 122, 87);
color deepBlue = color(5, 109, 177);
color pink = color(255, 174, 201);
color red = color(236,28,36);

boolean akey, wkey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey;
float vx, vy;
PImage map, brick;
int x=0;
int y=0;
int gridSize = 40;
int zoom;
float topSpeed = 500;
FBox player1, player2;
FWorld world;
ArrayList<FBox> boxes = new ArrayList<FBox>();

void setup() {
  size(800, 600);

  Fisica.init(this);
  world = new FWorld(-10000, -10000, 10000, 10000);
  world.setGravity(0, 900);

  map = loadImage("map.png");
 brick = loadImage("brick.png");
 brick.resize(40,40);
 
 zoom =5;
  player1 = new FBox(40, 40);
  player1.setNoStroke();
  player1.setPosition(1,40);
  player1.setFill(227,234,40);
  //player1.attachImage(earth);
  player1.setRotatable(false);
  player1.setFriction(0.9);
  world.add(player1);

  //  player2 = new FBox(40,40);
  //player2.setNoStroke();
  //player2.setPosition(400, 200);
  //player2.setFill(6, 71, 128);
  ////player.attachImage(moon);
  //player2.setRotatable(false);
  //player2.setFriction(0.9);
  //world.add(player2);

  //load the world
  while (y <map.height) { // keep going until we get to the
    //end of the map image

    color c = map.get(x, y); //get a pixel's color from the map 

    if (c == black) {
      FBox b = new FBox(gridSize, gridSize);
      b.setName("walls");
      b.attachImage(brick);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      world.add(b);
    }

    if (c == green) {
      FBox b = new FBox(gridSize, gridSize);
      b.setName("ground");
      b.setFillColor(green);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      world.add(b);
    }


    x++;                    // move down the row

    if (x == map.width) { //if we get to the end of the row
      x = 0;                //then go back to the beginning
      y++;                   //and down to the next row
    }
  }
}

void draw() {
  background(255);

pushMatrix(); //begin some transformations
translate(-player1.getX()+ width/2, -player1.getY()+ height/2);
  world.draw();
  world.step();


  popMatrix();

  //left,right movement
  vx = 0;
  if (leftkey) vx =-500;
  if (rightkey) vx = 500;
  player1.setVelocity(vx, player1.getVelocityY());

  //jumping 
  ArrayList<FContact> contacts = player1.getContacts();
  if (upkey && contacts.size() > 0) player1.setVelocity(player1.getVelocityX(), -500);

  //pushMatrix();
}

//void loadWorld() {

//  world = new FWorld( 0, 0, 10000, 10000);
//  world.setGravity(0, 900);

//  int x= 0;
//  int y=0;

//  while ( y<map.height) {
//    color c = map.get(x, y);
//    //if (c==red) {
//    //  LavaBox lb = new LavaBox();
//    //}
//  }


//  while (y < map.height) {
//    color c = map.get(x, y);
//    if (c ==0) {

//      //    if (c == red) {
//      //      LavaBox lb = new LavaBox();
//      //      lb.setPosition(x*gridSize, y*gridSize);
//      //      currentWorld.add(lb);
//      //      terrain.add(lb);
//      //    }
//      //    if (c == deepBlue) {
//      //      FBox b = new FBox(gridSize, gridSize);
//      //      b.setName("water");
//      //      b.setFill(5, 109, 177, 170);
//      //      b.setStroke(5, 109, 177, 18);
//      //      b.setPosition(x*gridSize, y*gridSize);
//      //    }
//      //  }
//      //}
//    }
//  }
//}

void keyPressed() {
  if (key == 'W' || key == 'w' ) wkey = true;
  if (key == 'S' || key == 's' ) skey = true;
  if (key == 'A' || key == 'a' ) akey = true;
  if (key == 'D' || key == 'd' ) dkey = true;
  if (keyCode == ' ') spacekey = true;
  if (keyCode == UP) upkey = true;
  if (keyCode == DOWN) downkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w' ) wkey = false;
  if (key == 'S' || key == 's' ) skey = false;
  if (key == 'A' || key == 'a' ) akey = false;
  if (key == 'D' || key == 'd' ) dkey = false;
  if (keyCode == ' ') spacekey = false;
  if (keyCode == UP) upkey = false;
  if (keyCode == DOWN) downkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
}
