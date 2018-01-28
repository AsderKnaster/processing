ArrayList<Field> f;
//If true: player has selected and moving options are displayed
boolean sel = false;

void setup() {

  size(900, 900);

  f = new ArrayList<Field>();

  for (int i = 0; i < 64; i++) {

    int a = i % 8;
    int b = i / 8;

    f.add(new Field(a, b));
  }

  for (int i = 8; i < 16; i++) {

    Figure temp = new Figure(Figure.B, true);
    f.get(i).fig = temp;
  }

  for (int i = 48; i < 56; i++) {

    Figure temp = new Figure(Figure.B, false);
    f.get(i).fig = temp;
  }

  f.get(0).fig = new Figure(Figure.T, true);
  f.get(7).fig = new Figure(Figure.T, true);

  f.get(63).fig = new Figure(Figure.T, false);
  f.get(56).fig = new Figure(Figure.T, false);

  f.get(1).fig = new Figure(Figure.P, true);
  f.get(6).fig = new Figure(Figure.P, true);

  f.get(62).fig = new Figure(Figure.P, false);
  f.get(57).fig = new Figure(Figure.P, false);

  f.get(2).fig = new Figure(Figure.L, true);
  f.get(5).fig = new Figure(Figure.L, true);

  f.get(61).fig = new Figure(Figure.L, false);
  f.get(58).fig = new Figure(Figure.L, false);

  f.get(3).fig = new Figure(Figure.K, true);
  f.get(4).fig = new Figure(Figure.D, true);

  f.get(60).fig = new Figure(Figure.K, false);
  f.get(59).fig = new Figure(Figure.D, false);
}

void draw() {

  if (!sel) {
    board();

    figs();
  }
}

//Draws the board
void board() {

  image(loadImage("board.png"), 0, 0);
}

//Draws the figures
void figs() {

  translate(50, 50);
  for (int i = 0; i < 64; i++) {

    f.get(i).disp();
  }
}

void mouseReleased() {

  sel = !sel;

  float x = (mouseX - 50);
  float y = (mouseY - 50);

  x /= 100;
  y /= 100;

  int ft = floor(x) + floor(y)* 8;

  if (sel) {
    ArrayList<Integer> opt = f.get(ft).dispOptions();

    print(opt.toString());

    for (int i = 0; i < opt.size(); i++) {

      f.get(opt.get(i) + ft).dispOpt();
    }
  }
}