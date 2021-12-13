

public class ControlState extends States
{
  private States State;
  private MenuCursor Selector;
  private HashMap<Enum,Command> CursorCommandsMap = new HashMap<Enum,Command>();
  private Command goBackCommand = new GoBackInput();
  private double TimeBetweenKeyType = 60;
  private Timer canTypeKey;
  private MenuItem[] menuItems;

  private PVector pos = new PVector((width/2)-width/6,height/8);
  private PVector dimentions = new PVector(width/3,height - (height/4));
  public ControlState(States state, InputManager inputManager)
  {
      super(inputManager);
      State = state;
      InitCommands();
      InitSelector();
      canTypeKey = new Timer();
      InitMenuItems();
  }
  @Override
  public void Display()
  {
      background(175);
      Selector.Display(-1,-1);
      DisplayMenuItems();
  }
  @Override
  public void Update(float delta)
  {
      Selector.Update(delta);
      KeyManagement(delta);
  }

  private void InitMenuItems()
  {
    MenuMesures mm = new MenuMesures();
    menuItems = new MenuItem[KeyMap.values().length];
    float y = mm.rectY;
    for(int i = 0; i < KeyMap.values().length; i++)
    {
      menuItems[i] = new MenuItem(KeyMap.values()[i],MenuItemsSize.BIG, i, Selector);
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
      else if(keyMap.get(KeyMap.ESCAPE))
      {
        manageTimeKeyPress(KeyMap.ESCAPE);
        goBackCommand.Execute();
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
    Enum SendMenuType = KeyMap.SPEED_UP;
    Selector = new MenuCursor(SendMenuType.getDeclaringClass(),CursorCommandsMap); 
  }
  private void InitCommands()
  {
    for(KeyMap _key : KeyMap.values())
    {
      CursorCommandsMap.put(_key,new SetInputCommand());
    }
  }

  //--------------------------------------------------
  //------------COMMANDS------------------------------
  //--------------------------------------------------
  private class SetInputCommand extends Command
  {
    @Override
    public void Execute()
    {
      inputManager.SetInput(Selector.SelectedOption,Selector);
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }

  private class GoBackInput extends Command
  {
    @Override
    public void Execute()
    {
      State.CurrentState(StateEnum.START);
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }
}