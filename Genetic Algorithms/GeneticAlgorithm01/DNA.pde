class DNA {

  char[] genes = new char[18];
  float fit;

  DNA() {

    for (int i = 0; i < genes.length; i++) {

      genes[i] = (char)(round(random(32, 122)));
    }
  }

  void fitness() {
    int score = 0;
    String target = "to be or not to be";
    for (int i = 0; i < genes.length; i++) {
      if (genes[i] == target.charAt(i)) {
        score++;
      }
    }
    fit = float(score)/target.length();
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
    }

    return child;
  }

  void mutate(float rate) {

    for (int i = 0; i < genes.length; i++) {

      if (random(1) < rate) {

        genes[i] = (char)(random(32, 122));
      }
    }
  }

  String getPhrase() {

    return new String(genes);
  }
}