import java.util.Random;

ArrayList <Mover> bouncers;
int moverNumvber = 200;
color backgroundColor;

//Change the Color Pattern from 0 to 12.
int colorPattern = 1;

int mode;

Random rand;

//0 = normal
//1 = fat
//2 = crippled


void setup () {
  size (800, 800);
  smooth();

  bouncers = new ArrayList();
  mode = 0;

  //Initial the instance from Mover class
  for (int i = 0; i < moverNumvber; i++) {
    Mover m = new Mover(colorPattern);
    bouncers.add (m);
  }
  
  rand = new Random();

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
      if (mode == 0) //normal moving pattern
      {
        Mover m = bouncers.get(i);
        m.flock (bouncers);
        m.move();
        m.checkEdgesInArea ();
        m.display();
      }
      else if (mode == 1) //scared blobs
      {
        Mover m = bouncers.get(i);
        //m.flock (bouncers);
        m.move();
        //m.checkEdgesInArea ();
        m.display();
      }
      else if (mode == 2) //crippled blobs
      {
        int r = rand.nextInt(10000);
        Mover m = bouncers.get(i);
        m.flock (bouncers);
        if (r%5 == 0)
        {

          m.move();
          m.checkEdgesInArea ();
          m.display();
        }
      }
      if (mode == 3) //confused blobs
      {
        Mover m = bouncers.get(i);
        //m.flock (bouncers);
        m.move();
        m.confusion ();
        m.display();
      }
      if (mode == 4) //lonely blob.
      {
        Mover m = bouncers.get(i);
        m.flock (bouncers);
        m.move();
        m.checkEdgesInArea ();
        if (i == 1) m.display();
      }
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

void keyTyped() 
  {
    for(int i=0; i<bouncers.size(); i++)
    {
      if (key == 'f') //Fat and slow.
      {
        mode = 0;
        bouncers.get(i).setRandomValues(20,30,2,3,0.5);
                colorPattern = 2;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (key == 's') //Scared blobbos
      {
        mode = 1; 
        bouncers.get(i).setRandomValues(4,15,15,20,1.2);
                colorPattern = 5;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
         
      }
      else if (key == 'c') //Confused or anxious
      {
        mode = 3;
        bouncers.get(i).setRandomValues(4,15,2,15,1.2);
                colorPattern = 3;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (key == 'n') //Normal behaviour
      {
        mode = 0;
        bouncers.get(i).setRandomValues(4,15,5,10,1.2);
                colorPattern = 1;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (key == 'p') //Swimming in pesticide
      {
         mode = 2;
         bouncers.get(i).setRandomValues(4,15,2,3,1.2);
                 colorPattern = 12;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (key == 'd') //Sad blobbos. :(
      {
        mode = 0;
        bouncers.get(i).setRandomValues(4,15,2,3,1.2);
        colorPattern = 7;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (key == 'l') //poor and lonesome blob
      {
        mode = 4;
        bouncers.get(i).setRandomValues(4,4,4,5,1.2);
        colorPattern = 10;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
    }
    
  }
