class Field {

  int x, y;
  Figure fig;

  Field(int x_, int y_) {

    x = x_;
    y = y_;
    fig = new Figure(-1, false);
  }

  void disp() {

    if (fig.t > -1) {

      String img = "";

      if (fig.c) {

        img += "white";
      } else {

        img += "black";
      }

      img += fig.t;
      img += ".png";
      image(loadImage(img), x * 100, y * 100);
    }
  }

  ArrayList<Integer> dispOptions() {

    if (fig.t > -1) {

      ArrayList<Integer> out = new ArrayList<Integer>();

      switch(fig.t) {

      case 0 : 

        if (fig.c) {

          if (y < 8) {
            out.add(8);

            if (y == 1) {

              out.add(16);
            }
          }
        } else {

          if (y > 0) {
            out.add(-8);

            if (y == 6) {

              out.add(-16);
            }
          }
        }
        return out;

      default :
        return null;
      }
    } else {

      return null;
    }
  }
  
  void dispOpt() {
  
    image(loadImage("poss.png"), x * 100, y * 100);
  }
}