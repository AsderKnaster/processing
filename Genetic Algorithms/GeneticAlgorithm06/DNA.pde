class DNA {

  PVector[] genes = new PVector[Parameters.TRIES];
  float fit;

  DNA() {

    for (int i = 0; i < genes.length; i++) {

      genes[i] = PVector.random2D();
      genes[i] = genes[i].mult(random(0, Parameters.MAX_FORCE));
    }
  }

  DNA cross(DNA b) {

    DNA child = new DNA();

    for (int i = 0; i < genes.length; i++) {

      //chooses at random for every gene of child from which parent it should come
      if (random(2) < 1) {

        child.genes[i] = this.genes[i];
      } else {

        child.genes[i] = b.genes[i];
      }
      
      if (random(1) < Parameters.MUT_RATE) {
        
        child.genes[i] = PVector.random2D().mult(random(0, Parameters.MAX_FORCE));
      }
    }

    return child;
  }
}