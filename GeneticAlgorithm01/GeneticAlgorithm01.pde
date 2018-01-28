//First attempt at genetic algorythm

DNA[] pop;
String target = "to be or not to be";
int genCount = 0;
PrintWriter out;
String timestamp;

void setup() {
  
  timestamp = Integer.toString(year()) + Integer.toString(month()) + Integer.toString(day()) + Integer.toString(hour()) + Integer.toString(minute()) + Integer.toString(second());
  
  File f = new File(timestamp);
  f.mkdir();
  
  //generate a random starting population
  pop = new DNA[1000];
  
  for (int i = 0; i < pop.length; i++) {
    
    pop[i] = new DNA();
  }
  
  //save population data in file
  out = createWriter(timestamp + "/gen000.txt");
  
  for (int i = 0; i < pop.length; i++) {
    
    out.println(pop[i].fit + "," + pop[i].getPhrase());
  }
  out.flush();
  out.close();
}

void draw() {
  
  //evaluate fitness of every member
  //fitness-value equals to the number of right characters in the DNA (in percent)
  
  for (int i = 0; i < pop.length; i++) {
    
    pop[i].fitness();
  }
  
  //get maximum and average fitness of population
  float tot = 0;
  float max = 0;
  String best = "";
  
  for (int i = 0; i < pop.length; i++) {
    
    tot += pop[i].fit;
    
    if (max < pop[i].fit) {
    
      max = pop[i].fit;
      best = pop[i].getPhrase();
    }
  }
  
  println("Average fitness: " + (tot/pop.length));
  println("Maximum fitness: " + max);
  println(best);
  genCount++;
  
  //save population data in file
  out = createWriter(timestamp + "/gen" + genCount + ".txt");
  
  for (int i = 0; i < pop.length; i++) {
    
    out.println(pop[i].fit + "," + pop[i].getPhrase());
  }
  out.flush();
  out.close();
  
  //generate mating pool, each member is added so many times as its fitness-percentage
  ArrayList<DNA> pool = new ArrayList<DNA>();
  
  for (int i = 0; i < pop.length; i++) {
    
    for (int j = 0; j < round(pop[i].fit * 100); j++) {
      
      pool.add(pop[i]);
    }
  }
  
  //generate a new child from two random elements of pool
  for (int i = 0; i < pop.length; i++) {
    
    DNA a = pool.get(int(random(pool.size())));
    DNA b = pool.get(int(random(pool.size())));
    
    DNA c = a.cross(b);
    c.mutate(0.01);
    
    pop[i] = c;
  }
}