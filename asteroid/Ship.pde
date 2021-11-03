
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
  private boolean isOnPlanet = false;
  private Actor planetLanded = null;


  public Ship(float worldWidth, float worldHeight)
  {
    super(width/2,height/2);
    //super(width/2,height-1);

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
  }
  @Override
  public void Update(float delta)
  {
    Rotate(delta);
    if(isOnPlanet)
    {
      //TODO: ajouter la force normal a l'équation pour permettre à la cam de bien fonctionné.
      velocity.set(planetLanded.velocity.x, planetLanded.velocity.y);
    }
    if(gravitables != null && gravitables.size() > 0)
      CalculateGravity(delta);
    
    CalculateSumForces(delta, forcesApplied);
    ManageScreenBonndary();
    ShootingPoint.Update(delta,this);
    
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
    isOnPlanet = false;
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
      float dist = radius + sender.radius;
          PVector between = new PVector(position.x-sender.position.x,position.y-sender.position.y);
          position.x = sender.position.x + (dist * cos(between.heading()));
          position.y = sender.position.y + (dist * sin(between.heading()));

          isOnPlanet = true;  
          planetLanded = sender;

          
          
          //isGravitable = false;
      /*if(velocity.mag() < 1)
      {
        if(PVector.angleBetween(gravity,PVector.fromAngle(angle)) - PI > radians(25) || PVector.angleBetween(gravity,PVector.fromAngle(angle)) - PI < radians(-25))
        {
          isAlive = false;
        }
        else
        {
          float dist = radius + sender.radius;
          PVector between = new PVector(position.x-sender.position.x,position.y-sender.position.y);
          position.x = dist * cos(between.heading());
          position.y = dist * sin(between.heading());

        }
      }
      else
      {
        isAlive = false;
      }*/
    }
  }
}