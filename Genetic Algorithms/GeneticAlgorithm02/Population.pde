class Population {

  DNA[] members = new DNA[Parameters.POP_SIZE];
  int count;
  float avgFit;
  float max;
  String best;
  
  Population() {
  
    count = 0;
  }

  void randomNew() {

    for (int i = 0; i < members.length; i++) {

      members[i] = new DNA();
    }
  }

  void save(String ts) {

    PrintWriter out = createWriter(ts + "/gen" + count + ".txt");
    
    out.println("avg:" + avgFit);
    out.println("max:" + max);
    out.println("best:" + best);

    for (int i = 0; i < members.length; i++) {

      out.println(members[i].fit + "," + members[i].getPhrase());
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
        best = members[i].getPhrase();
      }
    }
    
    avgFit = tot / members.length;
  }

  void evolve() {

    //generate mating pool, each member is added so many times as its fitness-percentage
    ArrayList<DNA> pool = new ArrayList<DNA>();

    for (int i = 0; i < members.length; i++) {

      for (int j = 0; j < round(members[i].fit * 100); j++) {

        pool.add(members[i]);
      }
    }

    //generate a new child from two random elements of pool
    for (int i = 0; i < members.length; i++) {

      DNA a = pool.get(int(random(pool.size())));
      DNA b = pool.get(int(random(pool.size())));

      DNA c = a.cross(b);
      c.mutate(Parameters.MUT_RATE);

      members[i] = c;
    }
    
    count++;
  }
}