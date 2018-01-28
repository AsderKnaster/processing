Planet[] p;

void setup() {
 
  size(800, 800);
  background(0);
  stroke(255);
  
  //Random planets for this solar system
  p = new Planet[(int) random(5, 15)];
  
  for (int i = 0; i < p.length; i++) {
    
    p[i] = new Planet(random(100, 400), random(TWO_PI), random(5, 25), random(1, 5));
    
    //Checking that there are no colliding orbits
    boolean col = true;
    
    while (col) {
      
      col = false;
      
      for (int j = 0; j < i; j++) {
      
        if (p[i].dis - p[i].s < p[j].dis + p[j].s && p[i].dis + p[i].s > p[j].dis - p[j].s) {
        
          col = true;
          p[i] = new Planet(random(100, 400), random(TWO_PI), random(5, 25), random(1, 5));
        }
      }
    }
  }
}

void draw() {

  background(0);
  translate(width/2, height/2);
  //Draws Sun
  fill(255, 165, 0);
  stroke(255, 165, 0);
  ellipse(0, 0, 80, 80);
  
  //Draws planets and their moons
  for (Planet p_ : p) {
    
    p_.move();
    p_.show();
    p_.showMoons();
  }
}