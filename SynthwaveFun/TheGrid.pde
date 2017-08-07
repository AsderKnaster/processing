import processing.sound.*;
SoundFile sound;

//Position of horizon line
int h = 150;
//Height above ground (the higher p, the lower you are to the ground)
float p = 4.5;
ArrayList<Line> l = new ArrayList<Line>();
//For colorfading
int c = 0;
int dir = 1;

void setup() {

  fullScreen(P2D);
  background(0);
  colorMode(HSB);
  sound = new SoundFile(this, "synthwave.mp3");
  sound.loop();
}

void draw() {
  //Fades the hue of the lines
  c += dir;
  background(0);
  stroke(c, 100, 100);
  strokeWeight(2);
  
  //Tiny pause at start
  if (frameCount > 120) {
    line(0, h, width, h);
  }
  
  translate(width/2, 0);

  //Adds new lines once in a while
  if (frameCount % 10 == 0) {

    l.add(new Line(h));
  }

  //Tiny pause at start
  if (frameCount > 120) {
    
    //Draws vertical lines
    for (float i = 0; i < width/2; i = i + map(i, 0, width/2, 60, 45)) {

      line(i, h, map(i, 0, width/2, 0, width * p), height);
      line(-i, h, map(-i, 0, width/2, 0, width * p), height);
    }
  }

  //Draws horizontal lines
  for (int i = 0; i < l.size(); i++) {

    l.get(i).move();
    
    //Tiny pause at beginning
    if (frameCount > 120) {
      l.get(i).show();
    }

    //Removes lines when out of sight
    if (l.get(i).pos + h > height * 2) {

      l.remove(i);
    }
  }

  //Changes direction of colorfading once in a while
  if (c >= 360 || c <= 0) {

    dir *= -1;
  }
}