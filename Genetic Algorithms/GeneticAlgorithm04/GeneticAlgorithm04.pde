//GeneticAlgorithm but with rockets

Population pop;
String timestamp;
int genCount = 0;
int lifetime = 0;

void setup() {
  
  size(1000, 500);
  frameRate(Parameters.SPEED);
  //Creates timestamp and folder for session
  timestamp = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) + Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());
  File f = new File(timestamp);
  f.mkdir();

  //Generates random new population
  pop = new Population();
  pop.randomNew();
  pop.calcFitness();
  pop.save(timestamp);
}

void draw() {
  
  background(255);
  
  stroke(0);
  rect(Parameters.TARGET_X - 5, Parameters.TARGET_Y - 5, 10, 10);
  
  if (lifetime < Parameters.TRIES) {
    
    for (int i = 0; i < pop.members.length; i++) {
      
      pop.members[i].run();
      
      if ((pop.members[i].loc.x >= Parameters.TARGET_X - 5 && pop.members[i].loc.x <= Parameters.TARGET_X + 5) && (pop.members[i].loc.y >= Parameters.TARGET_Y - 5 && pop.members[i].loc.y <= Parameters.TARGET_Y + 5)) {
        
        frameRate(0);
      }
    }
    
    lifetime++;
  } else {

    lifetime = 0;
    pop.evolve();
    pop.calcFitness();
    pop.save(timestamp);
  }
}