

public class GameState extends States
{
  private final int MAX_BULLET_NUMBER = 10;
  private final int TIME_BETWEEN_BULLET = 250;
  private int bulletTimer = 0;
  private States State;
  private Ship ship;
  ArrayList<Actor> Bullets = new ArrayList<Actor>();
  ArrayList<Actor> AllActorsExceptBullets = new ArrayList<Actor>();
  ArrayList<Boid> flock;
  int flockSize = 10;
  public GameState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;
    InitialiseObj();
    println(ship.position);
  }
  
  private void InitialiseObj()
  {
    ship =  new Ship();
    AllActorsExceptBullets.add(ship);
    flock = new ArrayList<Boid>();
    for (int i = 0; i < flockSize; i++) {
      Boid b = new Boid(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
      b.fillColor = color(random(255), random(255), random(255));
      flock.add(b);
      AllActorsExceptBullets.add(b);
      b.setShip(ship);
    }
  }

  @Override
  public void Update(float delta)
  {
    if(keyMap.get(KeyMap.ESCAPE))
    {
      State.CurrentState(StateEnum.START);
    }
    TestBulletShooting(delta);
    TestMovements();
    UpdateActors(delta);
    for (Boid b : flock) 
    {
      if(b.isAlive)
      {
        b.flock(flock);
        b.Update(delta);
      }
      
    }
  }
  @Override
  public void Display()
  {
    background(0);

    TestIfObjectIsAlive(Bullets);
    TestIfObjectIsAlive(AllActorsExceptBullets);
  }

  private void TestIfObjectIsAlive(ArrayList<Actor> objectList)
  {
    if(objectList.size()>0)
    {
      for(int i = 0; i < objectList.size(); i++)
      {
        if(!objectList.get(i).isAlive)
        {
          objectList.remove(i);
        }
        else
        {
          objectList.get(i).Display();
          if(objectList.get(i) == ship)
          {
          }
        }
      }
    }
  }

  private void TestBulletShooting(float delta)
  {
    if(ship!=null)
    {
      bulletTimer += delta * 1000;
      if(bulletTimer > TIME_BETWEEN_BULLET)
        bulletTimer = TIME_BETWEEN_BULLET;
      if(keyMap.get(KeyMap.SELECT))
      {
        
        if(bulletTimer >= TIME_BETWEEN_BULLET && Bullets.size() < MAX_BULLET_NUMBER)
        {
          Bullet bul = new Bullet(ship.ShootingPoint.point.x,ship.ShootingPoint.point.y, ship.angle + HALF_PI, ship.velocity.mag(),delta);
          Bullets.add(bul);
          bulletTimer = 0;
          for(Actor a : AllActorsExceptBullets)
          {
            bul.AddCollidable(a);
          }
        }
      }
    }
  }

  private void TestMovements()
  {
    if(ship.isAlive)
    {
      //rotation
      if(keyMap.get(KeyMap.ROTATE_LEFT) || keyMap.get(KeyMap.ROTATE_RIGHT))
      {
        if(keyMap.get(KeyMap.ROTATE_LEFT))
        {
          ship.Rotation = ship.LEFT;
        }
        if(keyMap.get(KeyMap.ROTATE_RIGHT))
        {
          ship.Rotation = ship.RIGHT;
        }
      }
      else
      {
        ship.Rotation = 0;
      }
      //acceleration
      if(keyMap.get(KeyMap.SPEED_UP))
      {
        ship.SpeedUp();
      }
      else
      {
        ship.acceleration.mult(0);
      }
    }
  }

  private void UpdateActors(float delta)
  {
    UpdateActorsGeneral(delta,Bullets);
    ship.Update(delta);
  }
  private void UpdateActorsGeneral(float delta, ArrayList<Actor> objList)
  {
    if(objList.size() > 0)
    {
      for(Actor obj : objList)
      {
        obj.Update(delta);
      }
    }
  }
}
