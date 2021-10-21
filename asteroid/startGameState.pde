public enum MenuSections
{
  START_GAME,
  CONFIGURATION,
  CONTROLS,
  QUIT,
}

public class StartGameState extends States
{
  private double TimeBetweenKeyType = 60;
  private Timer canTypeKey;
  private States State;
  private MenuCursor Selector;

  private MenuItem[] menuItems;

  private HashMap<Enum,Command> CursorCommandsMap = new HashMap<Enum,Command>();
  
  public StartGameState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;
    InitCommands();
    InitSelector();
    canTypeKey = new Timer();
    InititMenuItems();
  }
  
  @Override
  public void Update(float delta)
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
      else if(keyMap.get(KeyMap.ESCAPE))
      {
        manageTimeKeyPress(KeyMap.ESCAPE);
      }
    }
  }
  @Override
  public void Display()
  {
    background(175);
    MainWindow();
    Selector.Display();
    DisplayMenuItems();
  }

  private void InititMenuItems()
  {
    MenuMesures mm = new MenuMesures();
    menuItems = new MenuItem[MenuSections.values().length];
    float y = mm.rectY;
    for(int i = 0; i < MenuSections.values().length; i++)
    {
      menuItems[i] = new MenuItem(MenuSections.values()[i],MenuItemsSize.BIG, i, Selector);
    }
  }

  private void DisplayMenuItems()
  {
    for(MenuItem mi : menuItems)
    {
      mi.Display();
    }
  }
  
  private void MainWindow()
  {
    noStroke();
  }
  
  private void manageTimeKeyPress(KeyMap _key)
  {
    keyMap.replace(_key,false);
    canTypeKey.startT(TimeBetweenKeyType);
  }
  
  private void InitSelector()
  {
    Enum SendMenuType = MenuSections.START_GAME;
    Selector = new MenuCursor(SendMenuType.getDeclaringClass(),CursorCommandsMap); 
  }
  
  private void InitCommands()
  {
    CursorCommandsMap.put(MenuSections.START_GAME,new StartGameCommand());
    CursorCommandsMap.put(MenuSections.CONFIGURATION,new ConfigurationCommand());
    CursorCommandsMap.put(MenuSections.CONTROLS,new ControlCommand());
    CursorCommandsMap.put(MenuSections.QUIT,new QuitCommand());
  }

  //--------------------------------------------------------------------------
  //-------------------COMMANDS-----------------------------------------------
  //--------------------------------------------------------------------------
  private class StartGameCommand extends Command
  {
    @Override
    public void Execute()
    {
      State.CurrentState(StateEnum.GAME);
    }
    @Override
    public void Execute(Enum key){}
  }
  private class QuitCommand extends Command
  {
    @Override
    public void Execute()
    {
      exit();
    }
    @Override
    public void Execute(Enum key){}
  }
  private class ConfigurationCommand extends Command
  {
    @Override
    public void Execute()
    {
      println("Config");
      //State.CurrentState(StateEnum.GAME);
    }
    @Override
    public void Execute(Enum key){}
  }
  private class ControlCommand extends Command
  {
    @Override
    public void Execute()
    {
      State.CurrentState(StateEnum.CONTROLS);
    }
    @Override
    public void Execute(Enum key){}
  }
}
