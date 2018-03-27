class Parameters {
  
  final static int POP_SIZE = 100;
  final static float MUT_RATE = 0.001;
  final static int TRIES = 2000;
  final static float MAX_FORCE = 0.1;
  final static int TARGET_X = 500;
  final static int TARGET_Y = 50;
  final static int SPEED = 10000;
  final static float PASS_MIN = 0.1;
  
  String ts;
  
  Parameters(String t) {ts = t;}
  
  //saves parameters in JSON format
  void saveParams() {
  
    JSONObject p = new JSONObject();
    
    p.setInt("population size", POP_SIZE);
    p.setFloat("mutation rate", MUT_RATE);
    p.setInt("tries", TRIES);
    p.setFloat("maximum force", MAX_FORCE);
    p.setInt("speed", SPEED);
    p.setFloat("minimum fitness", PASS_MIN);
    
    saveJSONObject(p, ts + "/parameters.json");
  }
}