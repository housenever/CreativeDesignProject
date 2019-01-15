ArrayList <Mover> bouncers;
int moverNumvber = 200;
int bewegungsModus = 5;


void setup () {
  size (800, 800);
  smooth();

  bouncers = new ArrayList();

  //Initial the instance from Mover class
  for (int i = 0; i < moverNumvber; i++) {
    Mover m = new Mover();
    bouncers.add (m);
  }

  background (#1B1C1F);
  frameRate (30);
}


void draw () {

  // To do the fake phantom effect
  fill (#1B1C1F, 40);
  noStroke();
  rect (0, 0, width, height);


  int i = 0;
  while (i < bouncers.size () ) {
    Mover m = bouncers.get(i);

    m.flock (bouncers);
    m.move();
    m.checkEdgesInArea ();
    //m.checkEdges();
    m.display();
    i = i + 1;
  }
}