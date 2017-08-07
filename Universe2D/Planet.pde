class Planet {

  float dis, ang, s, v, fur;
  Planet[] moons;
  boolean isMoon = false;
  Color c = new Color((int) random(255), (int) random(255), (int) random(255));

  Planet(float dis_, float ang_, float s_, float v_) {

    dis = dis_;
    ang = ang_;
    s = s_;
    v = v_ / dis;
    fur = s;

    //Creates random moons, if it's not already a moon
    if (!isMoon) {

      //Makes sure, there are not too many planets with moons
      int mc = (int) random(-5, 5);
      
      if (mc < 0) {
        mc = 0;
      }
      
      moons = new Planet[mc];

      for (int i = 0; i < moons.length; i++) {

        moons[i] = new Planet(random(1.1 * s, s + 20), random(TWO_PI), random(1, 5), random(1, 3), true);
      }
    }
  }

  //Moon constructor (so that moons don't get moons too)
  Planet(float dis_, float ang_, float s_, float v_, boolean moon) {

    dis = dis_;
    ang = ang_;
    s = s_;
    v = v_ / dis;
    isMoon = moon;
    //So that moons don't get that colorful
    int col =  (int) random(255);
    c = new Color(col, col, col);
  }
  
  //Displays planet in his color
  void show() {

    fill(c.r, c.g, c.b);
    stroke(c.r, c.g, c.b);
    ellipse(dis * cos(ang), dis * sin(ang), s, s);
  }

  //Displays and moves moons of this planet
  void showMoons() {

    if (moons.length > 0) {

      for (Planet m : moons) {

        translate(dis * cos(ang), dis * sin(ang));
        m.show();
        m.move();
        translate(-dis * cos(ang), -dis * sin(ang));
      }
    }
  }

  //Moves the planet
  void move() {

    ang += v;

    if (ang >= TWO_PI) {

      ang = ang - TWO_PI;
    }
  }
}