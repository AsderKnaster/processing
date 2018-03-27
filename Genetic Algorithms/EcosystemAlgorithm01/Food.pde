class Food {
  
  PVector loc;
  
  Food() {
    
    loc = new PVector(random(Param.W), random(Param.H));
  }
  
  void display() {
    
    rect(loc.x, loc.y, Param.FOOD_S, Param.FOOD_S);
  }
}