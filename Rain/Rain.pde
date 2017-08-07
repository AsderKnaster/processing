Drop[] drops;

void setup() {
  
  size (800, 600);
  drops = new Drop[600];
  
  for (int i = 0; i < drops.length; i++) {
    
    drops[i] = new Drop();
  }
  
  background(190);
  stroke(70, 0, 255);
  strokeWeight(2);
}

void draw() {
  
  background(190);
  for (int i = 0; i < drops.length; i++) {
    
    drops[i].y += drops[i].vel;
    drops[i].vel += drops[i].acc;
    strokeWeight(drops[i].wid);
    line(drops[i].x, drops[i].y, drops[i].x, drops[i].y + drops[i].len);
    
    if (drops[i].y > height) {
      
      drops[i] = new Drop();
    }
  }
}

class Drop {
  
  float x, y, len, vel, acc, wid;
  
  Drop() {
    
    this.vel = random(2, 4);
    this.acc = random(0.01, 0.015);
    this.x = random(0, width);
    this.y = random(-height, 0);
    this.len = map(this.acc, 0.01, 0.015, 5, 12);
    this.wid = map(this.acc, 0.01, 0.015, 1, 2);
  }
}