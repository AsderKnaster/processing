float lastX, lastY;
int len;
int[] col = {40, 40, 40};
int curr;
int change;

void setup() {
  
  size(800, 600, P2D);
  background(0);
  strokeWeight(5);
  lastX = width / 2;
  lastY = height / 2;
  len = 30;
  curr = 0;
  change = 1;
}

void draw() {
  
  stroke(col[0], col[1], col[2]);
  
  col[curr] += change;
  
  if (col[curr] > 200 || col[curr] < 40) {
    
    curr++;
  }
  
  if (curr > 2) {
    
    curr = 0;
    change *= -1;
  }
  
  line(lastX, lastY, lastX += random(-len, len), lastY += random(-len, len));
  
  lastX = constrain(lastX, 0, width);
  lastY = constrain(lastY, 0, height);
}