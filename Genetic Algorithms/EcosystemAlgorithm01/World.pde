class World {

  ArrayList<Member> m = new ArrayList<Member>();
  ArrayList<Food> f = new ArrayList<Food>();

  World() {

    for (int i = 0; i < Param.START_N; i++) {

      m.add(new Member());
    }
    
    for (int i = 0; i < Param.START_F; i++) {
      
      f.add(new Food());
    }
  }

  void update() {

    //randomly spawns food
    if (random(100 * Param.SPEED) < Param.SPAWN_R) {

      f.add(new Food());
    }

    //Members will go towards nearest food

    for (Member m_ : m) {

      m_.moveToNearest(f);
      m_.update();

      //Removes food when eaten
      if (m_.checkFood(f) != -1) {

        f.remove(m_.checkFood(f));
        m_.health += 10;
      }
    }
  }

  void display() {

    for (Member m_ : m) {

      m_.display();
    }


    for (Food f_ : f) {

      f_.display();
    }
  }
}