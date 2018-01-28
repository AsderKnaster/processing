//GeneticAlgorithm but with rockets and obstacles

Population pop;
String timestamp;
int genCount = 0;
int lifetime = 0;
ArrayList<Obstacle> obs;
Obstacle tar;

void setup() {
  
  size(1000, 500);
  frameRate(Parameters.SPEED);
  //Creates timestamp and folder for session
  timestamp = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) + Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());
  File f = new File(timestamp);
  f.mkdir();
  
  //Obstacles
  obs = new ArrayList<Obstacle>();
  obs.add(new Obstacle(350, 250, 300, 50));
  obs.add(new Obstacle(100, 100, 500, 100));
  obs.add(new Obstacle(700, 100, 200, 20));
  obs.add(new Obstacle(625, 70, 50, 100));
  obs.add(new Obstacle(50, 200, 20, 150));
  
  obs.add(new Obstacle(0, -20, 1000, 20));
  
  //Target
  tar = new Obstacle(Parameters.TARGET_X, Parameters.TARGET_Y, 10, 10);

  //Generates random new population
  pop = new Population();
  pop.randomNew();
  pop.calcFitness();
  pop.save(timestamp);
}

void draw() {
  
  //background(255);
  
  stroke(0);
  
  for (Obstacle o : obs) {
    
    o.display();
  }
  
  tar.display();
  text("Gen:" + pop.count,10,30);
  
  if (lifetime < Parameters.TRIES) {
    
    for (int i = 0; i < pop.members.length; i++) {
      
      pop.members[i].run();
      pop.members[i].checkCrash(obs);
      pop.members[i].checkTarget(tar);
    }
    
    lifetime++;
  } else {

    background(255);
    lifetime = 0;
    pop.calcFitness();
        pop.adjustFit();
    pop.save(timestamp);

    pop.evolve();
  }
}