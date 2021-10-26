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

    p1 = new Planet(width/2,0,125,color(255,0,0),1222222222222222L);
    //p1.isGravitable = false;
    //p2 = new Planet(width/2, 100,50,color(255,0,0),31111111111111L);
    //p2.velocity.x = 1;
    gravitables = new ArrayList<Actor>();
    ship = new Ship();
    gravitables.add(p1);
    //gravitables.add(p2);
    gravitables.add(ship);
    p1.SetGravitables(gravitables);
    //p2.SetGravitables(gravitables);
    ship.mass = 100;
    ship.SetGravitables(gravitables);
    cam.setActorFolloed(ship);
  }

  @Override
  public void Update(float delta)
  {
    background(175);
    cam.setOffsets();
    ship.Update(delta);
    
    p1.Update(delta);
    //p2.Update(delta);
    TestMovements();
    
    cam.resetOffset();
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