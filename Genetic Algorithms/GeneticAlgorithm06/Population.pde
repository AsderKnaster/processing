class Population {

  Rocket[] members = new Rocket[Parameters.POP_SIZE];
  int count;
  float avgFit;
  float max;
  String best;
  String ts;

  Population(String timestamp) {

    count = 0;
    ts = timestamp;
  }

  /*
   * Random new rocket
   */
  void randomNew() {

    for (int i = 0; i < members.length; i++) {

      members[i] = new Rocket();
    }
  }

  /*
   * Saves generation data as JSON
   */
  void save() {

    //general generation data
    JSONObject gen = new JSONObject();
    gen.setInt("member count", members.length);
    gen.setFloat("best fit", max);
    gen.setFloat("avg fit", avgFit);
    
    //Getting data for every rocket (member)
    JSONArray rockets = new JSONArray();
    
    for (int i = 0; i < members.length; i++) {
      
      JSONObject r = new JSONObject();
      
      r.setFloat("fitness", members[i].fit);
      r.setInt("time", members[i].targetTime);
      r.setJSONArray("genes", members[i].getJSONGenes());
      
      rockets.setJSONObject(i, r);
    }
    
    gen.setJSONArray("rockets", rockets);
    
    saveJSONObject(gen, ts + "/gen" + count + ".json");
  }

  /*
   * Calculates fitness for every member and whole generation
   */
  void calcFitness() {

    float tot = 0;
    max = 0;

    for (int i = 0; i < members.length; i++) {

      members[i].fitness();
      tot += members[i].fit;

      if (members[i].fit > max) {

        max = members[i].fit;
        ;
      }
    }

    avgFit = tot / members.length;
  }
  
  /*
   * Adjusts fitness value based on best score in generation
   */
  void adjustFit() {
    
    for (int i = 0; i < members.length; i++) {
      
      members[i].fit = map(members[i].fit, 0, max, 0, 100);
    }
  }

  /*
   * "Breeds" new generation
   */
  void evolve() {

    //generate mating pool, each member is added so many times as its fitness-percentage
    ArrayList<Rocket> pool = new ArrayList<Rocket>();

    for (int i = 0; i < members.length; i++) {

        for (int j = 0; j < round(members[i].fit); j++) {

          pool.add(members[i]);
        }
    }

    //generate a new child from two random elements of pool
    for (int i = 0; i < members.length; i++) {

      DNA a = pool.get(int(random(pool.size()))).dna;
      DNA b = pool.get(int(random(pool.size()))).dna;

      Rocket c = new Rocket(a.cross(b));

      members[i] = c;
    }

    count++;
  }
}