public class GameTestState extends States
{
  private States State;
  private Planet p1;
  private Planet p2;
  private Ship ship;
  private ArrayList<Actor> gravitables;
  public GameTestState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;

    p1 = new Planet(width/2,height/2,125,color(255,0,0),1000000000000L);
    p1.isGravitable = false;
    //p2 = new Planet(width/2, height/2 - 200,50,color(255,0,0),1000);
    //p2.velocity.x = 0.88;
    gravitables = new ArrayList<Actor>();
    ship = new Ship();
    gravitables.add(p1);
    //gravitables.add(p2);
    gravitables.add(ship);
    p1.SetGravitables(gravitables);
    //p2.SetGravitables(gravitables);
    ship.mass = 10;
    ship.SetGravitables(gravitables);
    
  }

  @Override
  public void Update(float delta)
  {
    background(175);
    p1.Update(delta);
    //p2.Update(delta);
    TestMovements();
    ship.Update(delta);
    //println(ship.gravity);
    //println(p2.gravity);
  }
  @Override
  public void Display()
  {
    p1.Display();
    //p2.Display();
    ship.Display();
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
}