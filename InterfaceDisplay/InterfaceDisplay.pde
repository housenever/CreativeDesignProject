import java.util.Random;
import oscP5.*;
import netP5.*;

ArrayList <Mover> bouncers;
int moverNumvber = 200;
color backgroundColor;
VirtualTangible vt;

//Change the Color Pattern from 0 to 12.
int colorPattern = 1;

int mode;


  
OscP5 osc;
NetAddress receiver;

void oscEvent( OscMessage m ) {
  //print( "Received an osc message" );
  //print( ", address pattern: " + m.getAddress( ) );
  //print( ", typetag: " + m.getTypetag( ) );
  //if(m.getAddress( ).equals("/change") && m.getTypetag().equals("fff")) {
  //  /* transfer receivd values to local variables */
  //  x0 = m.floatValue(0);
  //  y0 = m.floatValue(1);
  //  r0 = m.floatValue(2);
  //}
  //println();
  
  OscArgument arg = m.get(0);
  int imageNumber = arg.intValue();
  PVector p1 = new PVector();
  p1.x = arg.floatValue();
  p1.y = arg.floatValue();
  
  PVector p2 = new PVector();
  p2.x = arg.floatValue();
  p2.y = arg.floatValue();
  
  PVector p3 = new PVector();
  p3.x = arg.floatValue();
  p3.y = arg.floatValue();
  
  PVector p4 = new PVector();
  p4.x = arg.floatValue();
  p4.y = arg.floatValue();
  
  
  // FAIRE QUELQUE CHOSE ICI
}

Random rand;

//0 = normal
//1 = fat
//2 = crippled


void setup () {
  //size (800, 800);
  fullScreen();
  smooth();

  bouncers = new ArrayList();
  mode = 0;
  
  vt = new VirtualTangible(400,400,"./testIMG.png");

  //Initial the instance from Mover class
  for (int i = 0; i < moverNumvber; i++) {
    Mover m = new Mover(colorPattern);
    m.setVirtualTangible(vt);
    bouncers.add (m);
  }
  
  rand = new Random();
  
  

  background (backgroundColor(colorPattern));
  //setGradientArea(0, 0, width, height, #FD518E, #F7841C, 100);

  frameRate (30);
  
   osc = new OscP5( this , 12000 );
  receiver = new NetAddress( "127.0.0.1" , 12000 );

}


void draw () {

  // To do the fake phantom effect
  fill (backgroundColor(colorPattern), 40);
  //setGradientArea(0, 0, width, height, #FD518E, #F7841C, 100);
  noStroke();
  rect (0, 0, width, height);

  int i = 0;
  
  vt.display();
  vt.mouseDragged();
  int rando = rand.nextInt(100);
  print(rando);
  if (rando%100 == 0) switchMode(rand.nextInt(7));
  while (i < bouncers.size () ) {
      if (mode == 0) //normal moving pattern
      {
        Mover m = bouncers.get(i);
        m.flock (bouncers);
        m.move();
        m.checkEdgesInAreaToTangible ();
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
          m.checkEdgesInAreaToTangible ();
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
        m.checkEdgesInAreaToTangible ();
        if (i == 1) m.display();
      }
      if (mode == 5) //No water.
      {
        int r = rand.nextInt(10000);
        Mover m = bouncers.get(i);
        //m.flock (bouncers);
        //m.move();
        //m.checkEdgesInArea ();
        if (r % 4 != 0) m.display();
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

void switchMode(int arg) //USE THIS TO SWAP MODE FOLLOWING DETECTION
{
  for(int i=0; i<bouncers.size(); i++)
    {
      if (arg == 1) //Fat and slow -- BURGER
      {
        mode = 0;
        bouncers.get(i).setRandomValues(20,30,2,3,0.5);
                colorPattern = 2;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 2) //Scared blobbos -- MEAT
      {
        mode = 1; 
        bouncers.get(i).setRandomValues(4,15,15,20,1.2);
                colorPattern = 5;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
         
      }
      else if (arg == 3) //Confused or anxious
      {
        mode = 3;
        bouncers.get(i).setRandomValues(4,15,2,15,1.2);
                colorPattern = 3;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 0) //Normal behaviour
      {
        mode = 0;
        bouncers.get(i).setRandomValues(4,15,5,10,1.2);
                colorPattern = 1;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 4) //Swimming in pesticide -- RICE
      {
         mode = 2;
         bouncers.get(i).setRandomValues(4,15,2,3,1.2);
                 colorPattern = 12;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 5) //Sad blobbos. :(
      {
        mode = 0;
        bouncers.get(i).setRandomValues(4,15,2,3,1.2);
        colorPattern = 7;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 6) //poor and lonesome blob -- FISH
      {
        mode = 4;
        bouncers.get(i).setRandomValues(4,4,4,5,1.2);
        colorPattern = 10;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
      else if (arg == 7) //no water -- CORN
      {
         mode = 5; 
        bouncers.get(i).setRandomValues(4,15,4,5,1.2);
        colorPattern = 11;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
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
      else if (key == 'w') //no water
      {
         mode = 5; 
        bouncers.get(i).setRandomValues(4,15,4,5,1.2);
        colorPattern = 11;
        bouncers.get(i).setRandomColor(colorPattern);
        background(backgroundColor(colorPattern));
      }
    }
    
  }
  
  void mousePressed() {
  vt.draggingpicMousePressed();
}
 
void mouseReleased() {
  vt.draggingpicMouseReleased();
}
