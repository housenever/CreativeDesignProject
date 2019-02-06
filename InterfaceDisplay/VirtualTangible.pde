class VirtualTangible {
 
  int x;
  int y;
  PImage sample;
 
  // controls whether we are dragging (holding the mouse)
  boolean hold; 
 
  // constructor
  VirtualTangible(int posx, int posy, 
    String imageNameAsString)
  { 
    x=posx;
    y=posy;
    sample = loadImage(imageNameAsString);
    sample.resize(55, 0);
  }// constructor
 
  void display() {
    image(sample, x, y);
  }
 
  void draggingpicMousePressed() {
    if (mouseX>x&&
      mouseY>y&&
      mouseX<x+sample.width && 
      mouseY<y+sample.height) {
      hold=true;
    }
  }
 
  void draggingpicMouseReleased() {
    hold=false;
  }
 
  void mouseDragged() 
  {
    if (hold) {
      x=mouseX; 
      y=mouseY;
    }
  }//method
  //
}
