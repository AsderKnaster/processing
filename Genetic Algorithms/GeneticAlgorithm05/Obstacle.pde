class Obstacle {

  PVector loc;
  int w,h;
  
  Obstacle(int loc_x, int loc_y, int w_, int h_) {
    
    loc = new PVector(loc_x, loc_y);
    w = w_;
    h = h_;
  }
  
  boolean contains(PVector v) {
    
    if (v.x >= loc.x && v.x <= loc.x + w && v.y >= loc.y && v.y <= loc.y + h) {
      
      return true;
    } else {
    
      return false;
    }
  }
  
  void display() {
    
    stroke(0);
    fill(100);
    rect(loc.x, loc.y, w, h);
  }
}