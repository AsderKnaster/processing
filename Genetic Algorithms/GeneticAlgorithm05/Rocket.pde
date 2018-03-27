class Rocket {

  PVector loc = new PVector(500, 500);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float fit;
  DNA dna;
  int geneCounter = 0;
  boolean crash = false;
  int crashCount = 0;
  boolean target = false;
  int targetTime = 0;

  Rocket() {

    dna = new DNA();
  }

  Rocket(DNA dna_) {

    dna = dna_;
  }

  void applyForce(PVector f) {

    acc.add(f);
  }

  void update() {

    if (!crash && !target) {

      vel.add(acc);
      loc.add(vel);
      //Sets vector to 0
      acc.mult(0);
    } else {
      
      loc.sub(vel);
      vel.mult(0);
    }
  }

  void run() {

    applyForce(dna.genes[geneCounter]);
    update();
    geneCounter++;
    display();
  }

  void display() {

    stroke(0);
    fill(0);
    point(loc.x, loc.y);
  }

  void fitness() {
    
    fit = 1000 / PVector.dist(loc, new PVector(Parameters.TARGET_X, Parameters.TARGET_Y));
    
    fit *= fit;
    fit /= 10 * crashCount + 1;
      
    if (target) {
      
      fit *= 10;
      fit *= Parameters.TRIES / targetTime;
    } 
     
  }

  String getGenes() {

    String out = "";

    for (int i = 0; i < dna.genes.length; i++) {

      out += round(dna.genes[i].x * 100);
      out += ",";
      out += round(dna.genes[i].y * 100);
      out += "|";
    }

    return out;
  }

  void checkCrash(ArrayList<Obstacle> obs) {

    crash = false;
    for (Obstacle o : obs) {

      if (o.contains(loc)) {

        crash = true;
        crashCount++;
      }
    }
  }
  
  void checkTarget(Obstacle tar) {
    
    if (tar.contains(loc)) {
      
      target = true;
      targetTime = geneCounter;
    }
  }
}