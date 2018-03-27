class Member {

  PVector loc, vel;
  float size, speed, health;

  Member() {

    loc = new PVector(random(Param.W), random(Param.H));
    size = random(10, 40);
    health = size * 10;
    speed = 100 / size;
    vel = new PVector(0, 0);
  }
  
  //sets vel pointing towards nearest food
  void moveToNearest(ArrayList<Food> f) {

    float min = Param.W * Param.H;
    int minI = -1;

    //Checks distance between every food
    for (int i = 0; i < f.size(); i++) {

      if (PVector.dist(loc, f.get(i).loc) < min) {

        minI = i;
        min = PVector.dist(loc, f.get(i).loc);
      }
    }
    
    //creates new vel vector from location values
    if (minI > -1) {

      vel = loc.sub(f.get(minI).loc).normalize().mult(-speed);
      println(vel.x + "," + vel.y + ", S:" + speed);
    } else {
      
      vel = new PVector(0, 0);
    }
  }

  //Returns index of food on which members is standing
  //if none: return -1
  int checkFood(ArrayList<Food> f) {

    for (int i = 0; i < f.size(); i++) {

      if (f.get(i).loc.x > loc.x && f.get(i).loc.x < loc.x + size && f.get(i).loc.y > loc.y && f.get(i).loc.y < loc.y + size) {

        return i;
      }
    }

    return -1;
  }
  
  //Updates location of member
  void update() {
  
    loc.add(vel);
  }

  //displays the member
  void display() {

    fill(200, 0, 0);
    ellipse(loc.x, loc.y, size, size);
  }
}