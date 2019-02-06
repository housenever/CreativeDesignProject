class Mover {

  PVector direction;
  PVector location;

  float speed;
  float SPEED;

  float noiseScale;
  float noiseStrength;
  float forceStrength;

  float ellipseSize;
  
  float dispersionMultiplier;

  color c;
  
  VirtualTangible vt;

  //---------------------------
  //1.Constructor 
  //---------------------------

  Mover (int colorPattern) {
    setRandomValues(4,15,5,10,1.2);
    setRandomColor(colorPattern);
  }

  void setVirtualTangible(VirtualTangible vt)
  {
    this.vt = vt;
  }

  //---------------------------
  //2.Set the defult value
  //---------------------------

  void setRandomValues (int sizeMin, int sizeMax, float speedMin, float speedMax, float dispersion) {
    location = new PVector (random (width), random (height));
    ellipseSize = random (sizeMin, sizeMax);

    float angle = random (TWO_PI);
    direction = new PVector (cos (angle), sin (angle));

    speed = random (speedMin, speedMax);
    SPEED = speed;
    noiseScale = 80;
    noiseStrength = 1;
    forceStrength = random (0.1, 0.2);
    
    dispersionMultiplier = dispersion;
  }

  //Set the color pattern

  void setRandomColor (int colorPattern) {

    int colorDice = (int) random (4);

    if (colorPattern == 0) {
      if (colorDice == 0) c = #ffedbc;
      else if (colorDice == 1) c = #A75265;
      else if (colorDice == 2) c = #ec7263;
      else c = #febe7e;
    }
    //Sweet
    else if (colorPattern == 1) {
      if (colorDice == 0) c = #00FFF4;
      else if (colorDice == 1) c = #FFF600;
      else if (colorDice == 2) c = #5100FF;
      else c = #FFAAD6;
    }
    //Oil and Fat
    else if (colorPattern == 2) {
      if (colorDice == 0) c = #FFC300;
      else if (colorDice == 1) c = #FEFFA2;
      else if (colorDice == 2) c = #FF9124;
      else c = #FF5A44;
    }
    //Anxious
    else if (colorPattern == 3) {
      if (colorDice == 0) c = #FF3C86;
      else if (colorDice == 1) c = #FFA400;
      else if (colorDice == 2) c = #FF6F00;
      else c = #1C00FF;
    }
    //Disorder
    else if (colorPattern == 4) {
      if (colorDice == 0) c = #6DFFD0;
      else if (colorDice == 1) c = #0036FF;
      else if (colorDice == 2) c = #000000;
      else c = #FFFF00;
    }
    //Scary
    else if (colorPattern == 5) {
      if (colorDice == 0) c = #586298;
      else if (colorDice == 1) c = #44248E;
      else if (colorDice == 2) c = #E32272;
      else c = #006774;
    }
    //Bloody
    else if (colorPattern == 6) {
      if (colorDice == 0) c = #FF0000;
      else if (colorDice == 1) c = #FF4863;
      else if (colorDice == 2) c = #CC0937;
      else c = #9E0000;
    }
    //Bareen and sad
    else if (colorPattern == 7) {
      if (colorDice == 0) c = #786F2E;
      else if (colorDice == 1) c = #894A00;
      else if (colorDice == 2) c = #EDE8A9;
      else c = #CBCBCB;
    }
    //Calm
    else if (colorPattern == 8) {
      if (colorDice == 0) c = #5D8CED;
      else if (colorDice == 1) c = #12A7D7;
      else if (colorDice == 2) c = #B7DDF0;
      else c = #00044C;
    }
    //Over Nutrition
    else if (colorPattern == 9) {
      if (colorDice == 0) c = #223FDB;
      else if (colorDice == 1) c = #307239;
      else if (colorDice == 2) c = #00F2FF;
      else c = #7C213F;
    }
    //Waste and dirty
    else if (colorPattern == 10) {
      if (colorDice == 0) c = #96A971;
      else if (colorDice == 1) c = #BFA47D;
      else if (colorDice == 2) c = #956AA0;
      else c = #000000;
    }
    //Pollution
    else if (colorPattern == 11) {
      if (colorDice == 0) c = #667880;
      else if (colorDice == 1) c = #666666;
      else if (colorDice == 2) c = #828282;
      else c = #000000;
    }
    //Pesticide
    else if (colorPattern == 12) {
      if (colorDice == 0) c = #52AF56;
      else if (colorDice == 1) c = #B6E349;
      else if (colorDice == 2) c = #BABBFF;
      else c = #B050C5;
    }
  }



  //---------------------------
  //3.Boids Flocking behavior algorithm
  //---------------------------

  //I use this algorithm to set the behaviour of each object(mover).
  //Find more information on: https://www.lalena.com/AI/Flock/

  void flock (ArrayList <Mover> boids) {

    PVector other;
    float otherSize ;

    PVector cohesionSum = new PVector (0, 0);
    float cohesionCount = 0;

    PVector seperationSum = new PVector (0, 0);
    float seperationCount = 0;

    PVector alignSum = new PVector (0, 0);
    float speedSum = 0;
    float alignCount = 0;

    for (int i = 0; i < boids.size(); i++) {

      other = boids.get(i).location;
      otherSize = boids.get(i).ellipseSize;

      float distance = PVector.dist (other, location);

      if (distance > 0 && distance <70) { 
        cohesionSum.add (other);
        cohesionCount++;

        alignSum.add (boids.get(i).direction);
        speedSum += boids.get(i).speed;
        alignCount++;
      }

      if (distance > 0 && distance < (ellipseSize+otherSize)*dispersionMultiplier) { 

        float angle = atan2 (location.y-other.y, location.x-other.x);

        seperationSum.add (cos (angle), sin (angle), 0);
        seperationCount++;
      }

      if (alignCount > 8 && seperationCount > 12) break;
    }

    if (cohesionCount > 0) {
      cohesionSum.div (cohesionCount);
      cohesion (cohesionSum, 0.8);
      speed = SPEED * 0.7;
    }

    if (alignCount > 0) {
      speedSum /= alignCount;
      alignSum.div (alignCount);
      align (alignSum, speedSum, 1.3);
      speed = SPEED * 0.7;
    }

    if (seperationCount > 0) {
      seperationSum.div (seperationCount);
      seperation (seperationSum, 2);
      speed = SPEED * 0.7;
    }
  }

  void cohesion (PVector force, float strength) {
    steer (force.x, force.y, strength);
  }

  void seperation (PVector force, float strength) {
    force.limit (strength*forceStrength);

    direction.add (force);
    direction.normalize();

    speed *= 1.1;
    speed = constrain (speed, 0, SPEED * 1.5);
  }

  void align (PVector force, float forceSpeed, float strength) {
    speed = lerp (speed, forceSpeed, strength*forceStrength);

    force.normalize();
    force.mult (strength*forceStrength);

    direction.add (force);
    direction.normalize();
  }



  //---------------------------
  //4.The move strategies
  //---------------------------

  void move () {
    PVector velocity = direction.get();
    velocity.mult (speed);
    location.add (velocity);
  }

  //4.1 Steer
  //Change direction to (x,y)
  //Steer will let all objects fly to the certain point

  void steer (float x, float y) {
    steer (x, y, 1);
  }

  void steer (float x, float y, float strength) {

    // reset the direction
    float angle = atan2 (y-location.y, x-location.x);

    PVector force = new PVector (cos (angle), sin (angle));
    force.mult (forceStrength * strength);

    direction.add (force);
    direction.normalize();

    // reset the speed
    float currentDistance = dist (x, y, location.x, location.y);
    if (currentDistance < 70) {
      speed = map (currentDistance, 0, 70, 0, SPEED);
    } else speed = SPEED;
  }


  //4.2 Seek
  //Change direction to (x,y)
  //Seek will let all objects fly to the direction of certain point

  void seek (float x, float y) {
    seek (x, y, 1);
  }

  void seek (float x, float y, float strength) {

    float angle = atan2 (y-location.y, x -location.x);

    PVector force = new PVector (cos (angle), sin (angle));
    force.mult (forceStrength * strength);

    direction.add (force);
    direction.normalize();
  }



  //---------------------------
  //5. CHECK the Position
  //---------------------------

  // 5.1 Random relocating the objects if they go outside the boundary
  void checkEdgesAndRelocate () {
    float diameter = ellipseSize;

    if (location.x < -diameter/2) {
      location.x = random (-diameter/2, width+diameter/2);
      location.y = random (-diameter/2, height+diameter/2);
    } else if (location.x > width+diameter/2) {
      location.x = random (-diameter/2, width+diameter/2);
      location.y = random (-diameter/2, height+diameter/2);
    }

    if (location.y < -diameter/2) {
      location.x = random (-diameter/2, width+diameter/2);
      location.y = random (-diameter/2, height+diameter/2);
    } else if (location.y > height + diameter/2) {
      location.x = random (-diameter/2, width+diameter/2);
      location.y = random (-diameter/2, height+diameter/2);
    }
  }


  //5.2 Cycling relocating the objects if they go outside the boundary
  void checkEdges () {
    float diameter = ellipseSize;

    if (location.x < -diameter / 2) {
      location.x = width+diameter /2;
    } else if (location.x > width+diameter /2) {
      location.x = -diameter /2;
    }

    if (location.y < -diameter /2) {
      location.y = height+diameter /2;
    } else if (location.y > height+diameter /2) {
      location.y = -diameter /2;
    }
  }


  // 5.3 Bounce back if they go outside the boundary

  void checkEdgesAndBounce () {
    float radius = ellipseSize / 2;

    if (location.x < radius ) {
      location.x = radius ;
      direction.x = direction.x * -1;
    } else if (location.x > width-radius ) {
      location.x = width-radius ;
      direction.x *= -1;
    }

    if (location.y < radius ) {
      location.y = radius ;
      direction.y *= -1;
    } else if (location.y > height-radius ) {
      location.y = height-radius ;
      direction.y *= -1;
    }
  }


  // 5.4  Defult: Turn back to the mouse position (Tangible position) if they go outside of the boundary

  void checkEdgesInArea () {
    float radius = ellipseSize / 2;
    float range = 150+random(-30, 30);

    if (location.x < mouseX-range-radius ) {
      seek(mouseX, mouseY);
    } else if (location.x > mouseX+range-radius ) {
      seek(mouseX, mouseY);
    }

    if (location.y < mouseY-range-radius ) {
      seek(mouseX, mouseY);
    } else if (location.y > mouseY+range-radius ) {
      seek(mouseX, mouseY);
    }
  }


// Confused reposition
  void confusion () {
    float radius = ellipseSize / 2;
    float range = 150+random(-30, 30);

    if (location.x < mouseX-range-radius ) {
      seek(random (width), random (height));
    } else if (location.x > mouseX+range-radius ) {
      seek(random (width), random (height));
    }

    if (location.y < mouseY-range-radius ) {
      seek(random (width), random (height));
    } else if (location.y > mouseY+range-radius ) {
      seek(random (width), random (height));
    }
  }


//reposition to tangible location
  void checkEdgesInAreaToTangible () {
    float radius = ellipseSize / 2;
    float range = 150+random(-30, 30);

    if (location.x < vt.x-range-radius ) {
      seek(vt.x, vt.y);
    } else if (location.x > vt.x+range-radius ) {
      seek(vt.x, vt.y);
    }

    if (location.y < vt.y-range-radius ) {
      seek(vt.x, vt.y);
    } else if (location.y > vt.y+range-radius ) {
      seek(vt.x, vt.y);
    }
  }

  //---------------------------
  //5.Display the objects(movers)
  //---------------------------

  void display () {
    noStroke();
    fill (c);
    ellipse (location.x, location.y, ellipseSize, ellipseSize);
  }
  
}
