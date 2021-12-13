
public class Ship extends ActorGravitable
{
  private final int RIGHT = 1;
  private final int LEFT = -1;
  private final float ROTATION_SPEED = 160;
  public final float ACCELERATION = 300;
  private final float MAX_SPEED = 15;
  private ArrayList<PVector> forcesApplied;
  public int Rotation = 0;
  private final int SHIP_WIDTH = 50;
  private final int SHIP_HIEGHT = 50;
  private float reactorw;
  private float reactorh;
  private Triangle shipTriagle;
  private Rectangle leftPropulsor;
  private Rectangle rightPropulsor;
  private color c =  color(255);
  private ShipShootingPoint ShootingPoint;
  private float worldWidth;
  private float worldHeight;
  public int landing = 0;
  private PVector testAngleBetweenShipAndPlanet = new PVector();
  private boolean hasAlreadyLanded = false;
  private ArrayList<ExplodingParticles> particleGenerators = new ArrayList<ExplodingParticles>();
  private float timeBeforeNextExplosion = 0;
  private int nbOfExplosions = 10;
  private States State;

    //debug attributes
  private Label fpsLabel;

  public Ship(float worldWidth, float worldHeight, States state)
  {
    super(width/2,height/2);
    //super(width/2,height-1);
    this.State = state;
    println(State);

    this.worldWidth = worldWidth;
    this.worldHeight = worldHeight;

    angleAcc = (radians(0));
    angle = (radians(0));
    acceleration = new PVector();
    forcesApplied = new ArrayList<PVector>()
    {
      {
        add(acceleration);
        add(gravity);
      }
    };
    ShootingPoint = new ShipShootingPoint(position.x,position.y);
    maxSpeed = MAX_SPEED;
    InitShip();

    //debug initialise
    fpsLabel = new Label(width-150, height-70, color(0,0,255,100), color(0,0,0), 25, "fps : " + (int)(1/delta), 10);
  }
  @Override
  public void Update(float delta)
  {
    if(acceleration.mag() > 0)
    {
      if(!soundManager.ReactorOn.isPlaying())
      {
        soundManager.ReactorOn.play();
      }
    }
    else
      soundManager.ReactorOn.stop();
      
  
    Rotate(delta);
    if(gravitables != null && gravitables.size() > 0)
      CalculateGravity(delta);
    
    CalculateSumForces(delta, forcesApplied);
    ManageScreenBonndary();
    ShootingPoint.Update(delta,this);

    if(particleGenerators.size()>0)
    {
      for(int i=0;i<particleGenerators.size();i++)
      {
        if(particleGenerators.get(i).particles.size() > 0)
          particleGenerators.get(i).Update(delta);
        else
          particleGenerators.remove(particleGenerators.get(i));
      }
    }
    

  }
  private void ManageScreenBonndary()
  {
    if(position.x + (w/2) < 0)
    {
       position.x = worldWidth;
       cam.setNewOffsets(worldWidth - (width/2),cam.yOff);
    }
    if(position.x - (w/2) > worldWidth)
    {
      position.x = 0 - (w/2);
      cam.setNewOffsets(0 - width/2,cam.yOff);
    }
    if(position.y + (h/2) < 0)
    {
      position.y = worldHeight + (h/2);
      cam.setNewOffsets(cam.xOff,worldHeight - (height/2));
    }
    if(position.y - (h/2) > worldHeight)
    {
      position.y = 0 + (h/2);
      cam.setNewOffsets(cam.xOff,0 - height/2);
    }
  }

  @Override
  public void Display(float x, float y)
  { 
    fill(c);
    pushMatrix();
      noStroke();
      translate(x,y);
      rotate(angle);
      shipTriagle.Display(-1,-1);
      DradPropulsors();
      stroke(255,0,0);
    popMatrix();
    stroke(0,255,0);
    strokeWeight(4);
    strokeWeight(1);
    if(particleGenerators.size()>0)
    {
      for(int i=0;i<particleGenerators.size();i++)
      {
        particleGenerators.get(i).Display(-1,-1);
      }
    }

    if(((ConfigurationState)State.ConfigurationState).isGeekActivated)
    {
      noStroke();
      fill(255,0,0,100);
      ellipse(x, y, radius*2, radius*2);
    }
     
  }

  private void InitShip()
  {
    w = SHIP_WIDTH;
    h = SHIP_HIEGHT;
    reactorw = w/4;
    reactorh = h/4;
    shipTriagle = new Triangle((float)(0-w/2),(float)(0-h/2+reactorh),(float)(0+w/2),(float)(0-h/2+reactorh),0,(float)(0+h/2));
    leftPropulsor = new Rectangle(0-w/2f,0-h/2f,h/4f,h/4f);
    rightPropulsor = new Rectangle(0+w/4f,0-h/2f,h/4f,h/4f);
    radius = w/2;
  }

  private void DradPropulsors()
  {
    if(acceleration.mag() > 0)
    {
      fill(255,0,0);
    }
    leftPropulsor.Display(leftPropulsor.position.x - cam.xOff, leftPropulsor.position.y - cam.yOff);
    rightPropulsor.Display(rightPropulsor.position.x - cam.xOff, rightPropulsor.position.y - cam.yOff);
    fill(255);
  }

  private void Rotate(float delta)
  {
    if(Rotation == LEFT)
      angleAcc = radians(-ROTATION_SPEED) * delta;
    else if(Rotation == RIGHT)
      angleAcc = radians(ROTATION_SPEED) * delta;
    else angleAcc = 0;
    angle += angleAcc;
  }
  public void SpeedUp()
  {
    hasAlreadyLanded = false;
    if(velocity.mag() < maxSpeed)
    {
      acceleration.x = PVector.fromAngle(angle + HALF_PI).mult(ACCELERATION).x;
      acceleration.y = PVector.fromAngle(angle + HALF_PI).mult(ACCELERATION).y;
    }
    else
    {
      velocity.normalize().mult(maxSpeed);
    }
  }

  public boolean Death(float delta)
  {
    timeBeforeNextExplosion -= delta;
    if(timeBeforeNextExplosion <= 0)
    {
      nbOfExplosions -= 1;
      if(nbOfExplosions==0)
      {
        return true;
      }
      Random random = new Random();
      timeBeforeNextExplosion = (float)((random.nextDouble() + 0.1) * 0.5);
      float xoff = (float)(random.nextDouble() * 15 -7);
      float yoff = (float)(random.nextDouble() * 15 -7);
      particleGenerators.add(new ExplodingParticles(xoff + position.x - cam.xOff, yoff + position.y - cam.yOff,2,new Color(random.nextInt(130) + 125,0,0,255),20));
    }
    return false;
  }

  //*************************************************************
  //************INTERFACES METHODS*******************************
  //*************************************************************
  
  @Override
  void GotCollided(Actor sender)
  {
    if(sender.getClass().getSimpleName().equals("Bullet")){}
      //isAlive = false;
    else if(sender.getClass().getSimpleName().equals("Planet"))
    {
      if(velocity.copy().sub(sender.velocity).mag() < 1)
      {
        testAngleBetweenShipAndPlanet.set(position.x-sender.position.x,position.y-sender.position.y);
        if(PVector.angleBetween(testAngleBetweenShipAndPlanet,PVector.fromAngle(angle)) - HALF_PI > radians(25) || PVector.angleBetween(testAngleBetweenShipAndPlanet,PVector.fromAngle(angle)) - HALF_PI < radians(-25))
        {
          println("dead due to angle");
          println(PVector.angleBetween(testAngleBetweenShipAndPlanet,PVector.fromAngle(angle))-HALF_PI);
          isAlive = false;
          onPlanetSurface(sender);
        }
        else
        {
          onPlanetSurface(sender);
          if(!hasAlreadyLanded)
          {
            landing += ((Planet)sender).landingPoints;
            hasAlreadyLanded = true;
          }
        }
      }
      else
      {
        println("dead due to speed");
        onPlanetSurface(sender);
        isAlive = false;
      }
    }
  }
  private void onPlanetSurface(Actor sender)
  {
    float dist = radius + sender.radius;
    PVector between = new PVector(position.x-sender.position.x,position.y-sender.position.y);
    position.x = sender.position.x + (dist * cos(between.heading()));
    position.y = sender.position.y + (dist * sin(between.heading()));
    
    velocity.set(sender.velocity.x, sender.velocity.y);
  }
}