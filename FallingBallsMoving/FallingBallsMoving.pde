Ball[] balls;

void setup() {
  
  size(800, 600);
  balls = new Ball[50];
  
  for (int i = 0; i < balls.length; i++) {
    
    balls[i] = new Ball();
  }
  
  ellipseMode(CORNER);
}

void draw() {
  
  background(255);
  
  for (int i = 0; i < balls.length; i++) {
    
    balls[i].y += balls[i].vel;
    balls[i].vel += balls[i].acc;
    
    balls[i].x += balls[i].velX;
    
    if (balls[i].x + balls[i].size > width || balls[i].x < 0) {
      
      balls[i].velX *= -1;
    }
    
    stroke(balls[i].c);
    ellipse(balls[i].x, balls[i].y, balls[i].size, balls[i].size);
    fill(balls[i].c);
    
    //Bounces the balls from the ground
    if (balls[i].y + balls[i].size > height) {
      
      balls[i].vel *= -1;
      balls[i].acc *= 5;
      
      if (!balls[i].touched) {
         
        balls[i].touched = true;
        balls[i].velX = random(-2, 2);
      }
    }
    
    //Speeds the balls up, when falling for the second time
    if (balls[i].vel > 0 && balls[i].touched) {
      
      balls[i].acc = 0.1;
    }
    
    //Stopps the balls lying on the ground
    if (abs(balls[i].vel) <= 0.6 && balls[i].y > height - balls[i].size) {
      
      balls[i].vel = 0;
      balls[i].acc = 0;
      balls[i].y = height - balls[i].size;
      balls[i].lying = true;
    }
    
    //Slowly stops the ball from rolling sideways when lying on the ground
    if (balls[i].lying) {
      
      if (balls[i].velX > 0.2) {
        
        balls[i].velX -= 0.01; 
      }
      
      if (balls[i].velX < -0.2) {
        
        balls[i].velX += 0.01;
      }
      
      if (abs(balls[i].velX) <= 0.2) {
        
        balls[i].velX = 0;
      }
    }
  }
}

class Ball {
  
  float x, y, vel, acc, size, velX;
  color c;
  boolean touched, lying;
  
  Ball() {
    
    this.x = random(0, width);
    this.y = random(-height, 0);
    this.velX = 0;
    this.vel = random(5, 12);
    this.acc = 0.012;
    this.c = color(random(40, 200), random(40, 200), random(40, 200));
    this.touched = false;
    this.lying = false;
    this.size = random(15, 45);
  }
}