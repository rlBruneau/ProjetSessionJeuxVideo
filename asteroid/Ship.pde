
public class Ship extends ActorGravitable
{
  private final int RIGHT = 1;
  private final int LEFT = -1;
  private final float ROTATION_SPEED = 160;
  public final float ACCELERATION = 120;
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

  public Ship()
  {
    //super(width/2,height/2);
    super(width/2,height-1);
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
    CalculateGravity(delta);
    CalculateSumForces(delta, forcesApplied);
    ManageScreenBonndary();
    ShootingPoint.Update(delta,this);
  }
  private void ManageScreenBonndary()
  {
    if(position.x + (w/2) < 0)  position.x = width + (w/2);
    if(position.x - (w/2) > width)  position.x = 0 - (w/2);
    if(position.y + (h/2) < 0)  position.y = height + (h/2);
    if(position.y - (h/2) > height)  position.y = 0 + (h/2);
  }

  @Override
  public void Display()
  { 
    fill(c);
    pushMatrix();
      noStroke();
      translate(position.x,position.y);
      rotate(angle);
      shipTriagle.Display();
      DradPropulsors();
      //fill(255,0,0,150);
      //ellipse(0,0,radius*2,radius*2);
      //fill(255);
      stroke(255,0,0);
    popMatrix();
    stroke(0,255,0);
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
    leftPropulsor.Display();
    rightPropulsor.Display();
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
    if(sender.getClass().getSimpleName().equals("Bullet"))
      isAlive = false;
    else if(sender.getClass().getSimpleName().equals("Planet"))
    {
      // calculer la position relative au bord du cercle pour arreter le vaisseau
    }
  }
}