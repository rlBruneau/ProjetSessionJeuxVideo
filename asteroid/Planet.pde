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
    position = new PVector();
  }

  public void Update(float delta)
  {

  }
  public void Display(float x, float y)
  {
    noStroke();
    fill(c);
    PVector pos = getDisplayPosition();
    ellipse(x,y,r*2,r*2);
  }
}


public class Planet extends ActorGravitable implements IObserverer
{
  private Circle outline;
  private Circle crater;
  private ArrayList<PVector> forcesApplied;
  public int landingPoints;
  public Planet(float x, float y, float r, color c, float mass, int landingPoints)
  {
    this.landingPoints = landingPoints;
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
    if(isGravitable)
      CalculateGravity(delta);
    CalculateSumForces(delta,forcesApplied);
    CallCollisionMethods();
  }
  public void Display(float x, float y)
  {
    outline.Display(x,y);
    crater.Display(x,y);
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
  {
    if(radius + obj.radius > dist(obj.position.x,obj.position.y,position.x,position.y) && obj != this)
    {
      obj.GotCollided(this);
    }
  }
}