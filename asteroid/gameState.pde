public class GameState extends States
{
  private States State;
  private Planet p1;
  private Planet p2;
  private Ship ship;
  private ArrayList<Actor> gravitables;
  private Camera camForMiniMap;
  private float worldWidth;
  private float worldHeight;
  private HUD hud;

  public GameState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;

    worldWidth = 5120*2;
    worldHeight = 3840*2;
    p1 = new Planet(worldWidth/2,worldHeight/2,125,color(255,0,0),100000000000000000L);
    p1.isGravitable = false;
    p2 = new Planet(worldWidth/2, worldHeight/4,50,color(255,0,0),511111111111111L);
    p2.velocity.x = 4;
    gravitables = new ArrayList<Actor>();
    ship = new Ship(worldWidth,worldHeight);
    gravitables.add(p1);
    gravitables.add(p2);
    gravitables.add(ship);
    p1.SetGravitables(gravitables);
    p2.SetGravitables(gravitables);
    ship.mass = 100;
    ship.SetGravitables(gravitables);
    cam.init(ship,width,height);
    camForMiniMap = new Camera();
    camForMiniMap.init(ship,worldWidth,worldHeight);

    hud = new HUD(ship);
  }

  @Override
  public void Update(float delta)
  {
    if(keyMap.get(KeyMap.ESCAPE))
    {
      State.CurrentState(StateEnum.START);
    }
    background(175);
    cam.setOffsets();
    hud.Update(delta);
    ship.Update(delta);
    p1.Update(delta);
    p2.Update(delta);
    TestMovements();
  }
  @Override
  public void Display()
  { 
    p1.Display(p1.position.x - cam.xOff, p1.position.y - cam.yOff);
    ship.Display(ship.position.x - cam.xOff, ship.position.y - cam.yOff);
    //p1.Display();
    p2.Display(p2.position.x - cam.xOff, p2.position.y - cam.yOff);

    hud.Display(ship.position.x -cam.xOff, ship.position.y-cam.yOff);

    fill(0,255,0,80);
    rect(0,0,width/4,height/4);
    scale(width/worldWidth,height/worldHeight);
    p1.Display(p1.position.x/4, p1.position.y/4);
    p2.Display(p2.position.x/4, p2.position.y/4);
    ship.Display(ship.position.x/4, ship.position.y/4);
    scale(width*worldWidth,height*worldHeight);
    
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