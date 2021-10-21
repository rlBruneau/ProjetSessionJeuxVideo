class Boid extends Actor {
  float topSpeed = 5;
  float topSteer = 0.05;
  
  float mass = 1;
  
  float theta = 0;
  float r = 10; // Rayon du boid
  
  float radiusSeparation = 10 * r;
  float radiusAlignment = 20 * r;
  float radiusCohesion = 30 * r;

  float weightSeparation = 2;
  float weightAlignment = 1;
  float weightCohesion = 1;
  
  PVector steer;
  PVector sumAlignment;
  PVector sumCohesion;

  PVector zeroVector = new PVector(0, 0);
  

  boolean debug = false;
  int msgCount = 0;
  String debugMessage = "";
  
  Boid () {
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    radius = r;
  }
  
  Boid (PVector loc, PVector vel) {
    this.position = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    radius = r;
  }
  
  void checkEdges() {
    if (position.x < 0) {
      position.x = width - r;
    } else if (position.x + r> width) {
      position.x = 0;
    }
    
    if (position.y < 0) {
      position.y = height - r;
    } else if (position.y + r> height) {
      position.y = 0;
    }
  }
  
  void flock (ArrayList<Boid> boids) {
    PVector separation = separate(boids);
    PVector alignment = align(boids);
    PVector cohesion = cohesion(boids);
    
    separation.mult(weightSeparation);
    alignment.mult(weightSeparation);
    cohesion.mult(weightCohesion);

    applyForce(separation);
    applyForce(alignment);
    applyForce(cohesion);
  }
  
  
  public void Update(float deltaTime) {
    
    checkEdges();

    velocity.add (acceleration);
    velocity.limit(topSpeed);

    theta = velocity.heading() + radians(90);

    position.add (velocity);

    acceleration.mult (0);  
    CallCollisionMethods();    
  }
  
  public void Display() {
    noStroke();
    fill (fillColor);
    
    pushMatrix();
    translate(position.x, position.y);
    rotate (theta);
    
    beginShape(TRIANGLES);
      vertex(0, -r * 2);
      vertex(-r, r * 2);
      vertex(r, r * 2);
    
    endShape();
    
    popMatrix();
    
    if (debug || this.debug) {
      renderDebug();
    }
  }
  
  PVector separate (ArrayList<Boid> boids) {
    if (steer == null) {
      steer = new PVector(0, 0, 0);
    }
    else {
      steer.setMag(0);
    }
    
    int count = 0;
    
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      
      if (d > 0 && d < radiusSeparation) {
        PVector diff = PVector.sub(position, other.position);
        
        diff.normalize();
        diff.div(d);
        
        steer.add(diff);
        
        count++;
      }
    }
    
    if (count > 0) {
      steer.div(count);
    }
    
    if (steer.mag() > 0) {
      steer.setMag(topSpeed);
      steer.sub(velocity);
      steer.limit(topSteer);
    }
    
    return steer;
  }

  PVector align (ArrayList<Boid> boids) {

    if (sumAlignment == null) {
      sumAlignment = new PVector();      
    } else {
      sumAlignment.mult(0);
    }

    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(this.position, other.position);

      if (d > 0 && d < radiusAlignment) {
        sumAlignment.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      sumAlignment.div((float)count);
      sumAlignment.setMag(topSpeed);

      PVector steer = PVector.sub(sumAlignment, this.velocity);
      steer.limit(topSteer);

      return steer;
    } else {
      return zeroVector;
    }
  }

   // Méthode qui calcule et applique une force de braquage vers une cible
  // STEER = CIBLE moins VITESSE
  PVector seek (PVector target) {
    // Vecteur différentiel vers la cible
    PVector desired = PVector.sub (target, this.position);
    
    // VITESSE MAXIMALE VERS LA CIBLE
    desired.setMag(topSpeed);
    
    // Braquage
    PVector steer = PVector.sub (desired, velocity);
    steer.limit(topSteer);
    
    return steer;    
  }

  PVector cohesion (ArrayList<Boid> boids) {
    if (sumCohesion == null) {
      sumCohesion = new PVector();      
    } else {
      sumCohesion.mult(0);
    }

    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);

      if (d > 0 && d < radiusCohesion) {
        sumCohesion.add(other.position);
        count++;
      }
    }

    if (count > 0) {
      sumCohesion.div(count);

      return seek(sumCohesion);
    } else {
      return zeroVector;
    }
    
  }
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);    
  }
  
  void renderDebug() {
    pushMatrix();
      noFill();
      translate(position.x, position.y);
      
      strokeWeight(1);
      stroke (100, 0, 0);
      ellipse (0, 0, radiusSeparation, radiusSeparation);

      stroke (0, 100, 0);
      ellipse (0, 0, radiusAlignment, radiusAlignment);

      stroke (0, 0, 200);
      ellipse (0, 0, radiusCohesion, radiusCohesion);
      
    popMatrix();

    if (msgCount % 60 == 0) {
      msgCount = 0;

      if (debugMessage != "") {
        println(debugMessage);
        debugMessage = "";
      }
    }

    msgCount++;
  }


    //*******************************************************
    //**********Get Collisions With Observer Patterns********
    //*******************************************************

    private Actor ship;

    public void setShip(Actor obj)
    {
        ship = obj;
    }

    private void CallCollisionMethods()
    {
        if(ship!=null)
        {
            TestCollision(ship);
        }
    }

    private void TestCollision(Actor obj)
    {
        if(radius + obj.radius > dist(obj.position.x,obj.position.y,position.x,position.y))
        {
            obj.GotCollided(this);
            ship=null;
            isAlive = false;
            println("TEWAT");
        }
    }


  //*************************************************************
  //************INTERFACES METHODS*******************************
  //*************************************************************
  
  @Override
  void GotCollided(Actor sender)
  {
    isAlive = false;
  }
}