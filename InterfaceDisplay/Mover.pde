class Mover {

  PVector direction;
  PVector location;

  float speed;
  float SPEED;

  float noiseScale;
  float noiseStrength;
  float forceStrength;

  float ellipseSize;

  color c;

  //---------------------------
  //1.Constructor 
  //---------------------------

  Mover () {
    setRandomValues();
  }



  //---------------------------
  //2.Set the defult value
  //---------------------------

  void setRandomValues () {
    location = new PVector (random (width), random (height));
    ellipseSize = random (4, 15);

    float angle = random (TWO_PI);
    direction = new PVector (cos (angle), sin (angle));

    speed = random (5, 10);
    SPEED = speed;
    noiseScale = 80;
    noiseStrength = 1;
    forceStrength = random (0.1, 0.2);

    setRandomColor();
  }

  void setRandomColor () {
    int colorDice = (int) random (4);

    if (colorDice == 0) c = #ffedbc;
    else if (colorDice == 1) c = #A75265;
    else if (colorDice == 2) c = #ec7263;
    else c = #febe7e;
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

      if (distance > 0 && distance < (ellipseSize+otherSize)*1.2) { 

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
    } 
    else if (location.x > mouseX+range-radius ) {
      seek(mouseX, mouseY);
    }

    if (location.y < mouseY-range-radius ) {
      seek(mouseX, mouseY);
    } 
    else if (location.y > mouseY+range-radius ) {
      seek(mouseX, mouseY);
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