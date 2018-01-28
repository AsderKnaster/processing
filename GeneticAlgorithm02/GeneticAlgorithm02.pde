//Cleaned up version of GeneticAlgorythm01

Population pop;
String timestamp;
int genCount = 0;

void setup() {
  
  //Creates timestamp and folder for session
  timestamp = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) + Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());
  File f = new File(timestamp);
  f.mkdir();

  //Generates random new population
  pop = new Population();
  pop.randomNew();
}

void draw() {
  
  //Evaluate fitness of population
  pop.calcFitness();
  
  //Saves data
  pop.save(timestamp);
  
  //The actual evolution
  pop.evolve();
  genCount++;
  
  //Checks if goal has been reached
  if (pop.best.equals(new String("Genetic Algorithms: Make them your own"))) {
    
    println("Goal reached after " + pop.count + " generations");
    exit();
  }
}