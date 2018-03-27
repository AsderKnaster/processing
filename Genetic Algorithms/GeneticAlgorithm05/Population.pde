class Population {

  Rocket[] members = new Rocket[Parameters.POP_SIZE];
  int count;
  float avgFit;
  float max;
  String best;

  Population() {

    count = 0;
  }

  void randomNew() {

    for (int i = 0; i < members.length; i++) {

      members[i] = new Rocket();
    }
  }

  void save(String ts) {

    PrintWriter out = createWriter(ts + "/gen" + count + ".txt");

    out.println("avg:" + avgFit);
    out.println("max:" + max);
    out.println("best:" + best);

    for (int i = 0; i < members.length; i++) {

      out.println("f:" + members[i].fit + ", t:" + members[i].targetTime + "," + members[i].getGenes());
    }
    out.flush();
    out.close();
  }

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
  
  void adjustFit() {
    
    for (int i = 0; i < members.length; i++) {
      
      members[i].fit = map(members[i].fit, 0, max, 0, 100);
    }
  }

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