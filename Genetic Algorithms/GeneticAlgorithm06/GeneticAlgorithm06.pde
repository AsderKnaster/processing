//GeneticAlgorithm05 but saving generation data in JSON

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
  
  //Saves parameters as JSON file
  (new Parameters(timestamp)).saveParams();
  
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
  
  //Save Obstacles in JSON file
  JSONArray obstacles = new JSONArray();
  
  //Getting postion data from every obstacle
  for (int i = 0; i < obs.size(); i++) {
  
    JSONObject temp = new JSONObject();
    
    temp.setInt("xpos", round(obs.get(i).loc.x));
    temp.setInt("ypos", round(obs.get(i).loc.y));
    temp.setInt("width", round(obs.get(i).w));
    temp.setInt("height", round(obs.get(i).h));
    
    obstacles.setJSONObject(i, temp);
  }
  
  //getting position data for target
  JSONObject targetJson = new JSONObject();
  targetJson.setInt("xpos", round(tar.loc.x));
  targetJson.setInt("ypos", round(tar.loc.y));
  targetJson.setInt("width", round(tar.w));
  targetJson.setInt("height", round(tar.h));
  
  //putting it all together
  JSONObject finalJson = new JSONObject();
  finalJson.setJSONObject("target", targetJson);
  finalJson.setJSONArray("obstacles", obstacles);
  saveJSONObject(finalJson, timestamp + "/obstacles.json");

  //Generates random new population
  pop = new Population(timestamp);
  pop.randomNew();
  pop.calcFitness();
  pop.save();
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
    pop.save();

    pop.evolve();
  }
}