public abstract class Actor extends GraphicObject implements ICollidable
{
  public boolean isAlive = true;
  protected ArrayList<PVector> forces;
  protected PVector acceleration;
  protected PVector friction;
  protected PVector gravity;
  protected float mass = 1;
  private PVector resultant;
  public int w;
  public int h;
  public float radius;
  float angleAcc;
  protected float maxSpeed;
  //direction vector
  protected PVector velocity = new PVector();
  
  //object constant
  protected float gravityAccel = 0;
  protected float frictioncoefficient;
  public Actor(float x, float y)
  {
    super(x,y);
    resultant = new PVector();
    gravity = new PVector();
    forces = new ArrayList<PVector>(){
      {
        add(acceleration);
        add(friction);
        add(gravity);
      }
    };
  }
  public Actor()
  {
    resultant = new PVector();
    gravity = null;//new PVector(0,gravityAccel);
    forces = new ArrayList<PVector>(){
      {
        add(acceleration);
        add(friction);
        add(gravity);
      }
    };
  }

  public void CalculateSumForces(float delta, ArrayList<PVector> forces)
  {
    resultant.mult(0);
    for(PVector f : forces)
    {
      if(f != null)
      {
        AddForce(delta, f);
      }
        
    }
    //f = ma  a = f/m
    double a;
    double f = resultant.mag();
    a = f/mass;
    resultant.normalize();
    resultant.mult((float)a);
    velocity.add(resultant.mult(delta));
    
      position.add(velocity);
  }

  private void AddForce(float delta, PVector force)
  {
    resultant.add(force.copy());
  }

  protected void ApplyCamOffset()
  {
    position.x -= cam.xOff;
    position.y -= cam.yOff;
  }


  //**********************************************************************************
  //*************ICollidable method empty to override in child class******************
  //**********************************************************************************

  void GotCollided(Actor sender)
  {
    println(this + "didn't override the method GotCollided!");
  }
}