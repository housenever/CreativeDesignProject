ArrayList <Mover> bouncers;
int moverNumvber = 200;
color backgroundColor;

//Change the Color Pattern from 0 to 12.
int colorPattern = 1;



void setup () {
  size (800, 800);
  smooth();

  bouncers = new ArrayList();

  //Initial the instance from Mover class
  for (int i = 0; i < moverNumvber; i++) {
    Mover m = new Mover(colorPattern);
    bouncers.add (m);
  }

  background (backgroundColor(colorPattern));
  //setGradientArea(0, 0, width, height, #FD518E, #F7841C, 100);

  frameRate (30);
}


void draw () {

  // To do the fake phantom effect
  fill (backgroundColor(colorPattern), 40);
  //setGradientArea(0, 0, width, height, #FD518E, #F7841C, 100);
  noStroke();
  rect (0, 0, width, height);


  int i = 0;
  while (i < bouncers.size () ) {
    Mover m = bouncers.get(i);

    m.flock (bouncers);
    m.move();
    m.checkEdgesInArea ();
    m.display();
    i = i + 1;
  }
}


color backgroundColor(int colorPattern) {

  //0. Default
  if (colorPattern == 0) backgroundColor = #FD518E;
  //1. Sweet
  else if (colorPattern == 1) backgroundColor = #FD518E;
  //2. Oil and fat
  else if (colorPattern == 2) backgroundColor = #FFE400;
  //3. Anxious
  else if (colorPattern == 3) backgroundColor = #000000;
  //4. Disorder
  else if (colorPattern == 4) backgroundColor = #F5515F;
  //5. Scary
  else if (colorPattern == 5) backgroundColor = #040033;
  //6. Bloody
  else if (colorPattern == 6) backgroundColor = #060026;
  //7. Bareen and sad
  else if (colorPattern == 7) backgroundColor = #B2AEAB;
  //8. Calm
  else if (colorPattern == 8) backgroundColor = #145582;
  //9. Over Nutrition
  else if (colorPattern == 9) backgroundColor = #1AAD7E;
  //10. Waste and dirty
  else if (colorPattern == 10) backgroundColor = #4A435F;
  //11. Pollution
  else if (colorPattern == 11) backgroundColor = #2D2D2D;
  //12. Pesticide
  else backgroundColor = #38287F;

  return backgroundColor;
}




//Set background a gradient color
//But it will be slow
void setGradientArea(int x, int y, float w, float h, color c1, color c2, int alpha) {

  noFill();

  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c, alpha);
    line(i, y, i, y+h);
  }
}