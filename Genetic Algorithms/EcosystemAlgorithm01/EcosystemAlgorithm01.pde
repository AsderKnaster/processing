//Ecosystem: living and dying
//A world contains food and members
//members age with every frame
//if they eat food the live longer
//if they live longer they can reproduce more often
//doesnt work: members dont move

World w;

void setup() {

  size(1000, 500);
  w = new World();
  ellipseMode(CORNER);
  frameRate(Param.SPEED);
}

void draw() {
  
  background(255);
  w.update();
  w.display();
}