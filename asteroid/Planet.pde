public class Circle extends GraphicObject
{
  float r;
  color c;
  Planet body;
  public Circle( float r, color c, Planet body)
  {
    this.r = r;
    this.body = body;
    this.c = c;
  }

  public void Update(float delta)
  {

  }
  public void Display()
  {
    noStroke();
    fill(c);
    ellipse(body.position.x,body.position.y,r*2,r*2);
  }
}


public class Planet extends ActorGravitable implements IObserverer
{
  public boolean isGravitable = true;
  private Circle outline;
  private Circle crater;
  private ArrayList<PVector> forcesApplied;
  public Planet(float x, float y, float r, color c, float mass)
  {
    position = new PVector(x,y);
    this.radius = r;
    outline = new Circle(r,c,this);
    crater = new Circle( r/3,color(255,100,100),this);
    this.mass = mass;
    gravity = new PVector();
    forcesApplied = new ArrayList<PVector>()
    {
      {
        add(gravity);
      }
    };
  }

  public void Update(float delta)
  {
    ApplyCamOffset();
    if(isGravitable)
      CalculateGravity(delta);
    CalculateSumForces(delta,forcesApplied);
    CallCollisionMethods();
  }
  public void Display()
  {
    outline.Display();
    crater.Display();
  }

  //=================================
  //=====Colision====================
  //=================================

  public void AddCollidable(Actor obj){}

  private void CallCollisionMethods()
  {
    if(gravitables.size() > 0)
    {
      for(Actor obj : gravitables)
      {
        TestCollision(obj);
      }
    }
  }

  private void TestCollision(Actor obj)
  {//println("Collided");
    if(radius + obj.radius > dist(obj.position.x,obj.position.y,position.x,position.y) && obj != this)
    {
      obj.GotCollided(this);
    }
  }
}