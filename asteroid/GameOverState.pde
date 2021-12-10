public enum GameOverEnum
{
  MENU,
  NEW_GAME,
  QUIT
}

public class GameOverState extends States
{
  private States State;
  private MenuCursor Selector;
  private HashMap<Enum,Command> CursorCommandsMap = new HashMap<Enum,Command>();
  private double TimeBetweenKeyType = 60;
  private Timer canTypeKey;
  private MenuItem[] menuItems;
  private Label gameOverLabel;
  private String gameOverString = "Game Over...";
  private int h1 = 24;

  public GameOverState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;

    InitCommands();
    InitSelector();
    canTypeKey = new Timer();
    InitMenuItems();

    gameOverLabel = new Label(color(0), color(255), h1, gameOverString, 0);
  }

  @Override
  public void Update(float delta)
  {
    Selector.Update(delta);
    KeyManagement(delta);
  }
  @Override
  public void Display()
  { 
    background(0);
    Selector.Display(-1,-1);
    DisplayMenuItems();
    gameOverLabel.Display();
  }

  private void InitMenuItems()
  {
    MenuMesures mm = new MenuMesures();
    menuItems = new MenuItem[GameOverEnum.values().length];
    float y = mm.rectY;
    for(int i = 0; i < GameOverEnum.values().length; i++)
    {
      menuItems[i] = new MenuItem(GameOverEnum.values()[i],MenuItemsSize.BIG, i, Selector);
    }
  }

  private void DisplayMenuItems()
  {
    for(MenuItem mi : menuItems)
    {
      mi.Display(-1,-1);
    }
  }

  private void KeyManagement(float delta)
  {
    if(canTypeKey.hasFinished(delta))
    {
      if(keyMap.get(KeyMap.ARROW_UP))
      {
        manageTimeKeyPress(KeyMap.ARROW_UP);
        Selector.SelectingCursorUp();
      }
      else if(keyMap.get(KeyMap.ARROW_DOWN))
      {
        manageTimeKeyPress(KeyMap.ARROW_DOWN);
        Selector.SelectingCursorDown();
      }
      else if(keyMap.get(KeyMap.SELECT))
      {
        manageTimeKeyPress(KeyMap.SELECT);
        Selector.selectedOption.Execute();
      }
    }
  }

  private void manageTimeKeyPress(KeyMap _key)
  {
    keyMap.replace(_key,false);
    canTypeKey.startT(TimeBetweenKeyType);
  }

  private void InitSelector()
  {
    Enum SendMenuType = GameOverEnum.MENU;
    Selector = new MenuCursor(SendMenuType.getDeclaringClass(),CursorCommandsMap); 
  }
  private void InitCommands()
  {
    CursorCommandsMap.put(GameOverEnum.MENU,new MenuCommand());
    CursorCommandsMap.put(GameOverEnum.QUIT,new QuitCommand());
    CursorCommandsMap.put(GameOverEnum.NEW_GAME,new NewGameCommand());
  }

  //=============Commands===============

  private class MenuCommand extends Command
  {
    @Override
    public void Execute()
    {
      State.GameState = new GameState(State,inputManager);
      State.CurrentState(StateEnum.START);
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }
  
  private class NewGameCommand extends Command
  {
    @Override
    public void Execute()
    {
      State.GameState = new GameState(State,inputManager);
      State.CurrentState(StateEnum.GAME);
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }
  
  private class QuitCommand extends Command
  {
    @Override
    public void Execute()
    {
      exit();
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }
}