class Rocket {
  
  PVector loc = new PVector(500, 400);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float fit;
  DNA dna;
  int geneCounter = 0;
  
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
    
    vel.add(acc);
    loc.add(vel);
    //Sets vector to 0
    acc.mult(0);
  }
  
  void run() {
    
    applyForce(dna.genes[geneCounter]);
    update();
    geneCounter++;
    display();
  }
  
  void display() {
    
    stroke(0);
    rect(loc.x - 2, loc.y - 2, 4, 4);
  }
  
  void fitness() {
    
    fit = 1000 / PVector.dist(loc, new PVector(Parameters.TARGET_X, Parameters.TARGET_Y));
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
}