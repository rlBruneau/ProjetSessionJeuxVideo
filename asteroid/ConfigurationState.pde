public enum configEnum
{
    SOUND,
    GEEK_DATA
}

public class ConfigurationState extends States
{
  private States State;
  private MenuCursor Selector;
  private HashMap<Enum,Command> CursorCommandsMap = new HashMap<Enum,Command>();
  private Command goBackCommand = new GoBackInput();
  private double TimeBetweenKeyType = 60;
  private Timer canTypeKey;
  private MenuItem[] menuItems;
  private boolean isSettingSound = false;
  private Label soundLabel;
  private ProgressBar volumeBar;
  private final float volumeBarW = width/3;
  private final float volumeBarh = 40;

  private PVector pos = new PVector((width/2)-width/6,height/8);
  private PVector dimentions = new PVector(width/3,height - (height/4));
  public ConfigurationState(States state, InputManager inputManager)
  {
      super(inputManager);
      State = state;
      InitCommands();
      InitSelector();
      canTypeKey = new Timer();
      InititMenuItems();

      soundLabel = new Label(color(255),color(0),16,"Volume",5);
      volumeBar = new ProgressBar(width/2 - (volumeBarW/2), height/2 + volumeBarh, 
        volumeBarW, volumeBarh, color(0,255,0),
        color(255,0,0), 4, color(0));
  }
  @Override
  public void Display()
  {
    background(175);
    Selector.Display(-1,-1);
    DisplayMenuItems();
    DisplaySoundBar();
    soundLabel.Display();
    volumeBar.Display();
  }
  @Override
  public void Update(float delta)
  {
    Selector.Update(delta);
    KeyManagement(delta);
  }

  private void DisplaySoundBar()
  {
    
  }

  private void InititMenuItems()
  {
    MenuMesures mm = new MenuMesures();
    menuItems = new MenuItem[configEnum.values().length];
    float y = mm.rectY;
    for(int i = 0; i < configEnum.values().length; i++)
    {
      menuItems[i] = new MenuItem(configEnum.values()[i],MenuItemsSize.BIG, i, Selector);
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
        if(!isSettingSound)
          Selector.SelectingCursorUp();
        else
          soundManager.SoundUp(volumeBar);
      }
      else if(keyMap.get(KeyMap.ARROW_DOWN))
      {
        manageTimeKeyPress(KeyMap.ARROW_DOWN);
        if(!isSettingSound)
          Selector.SelectingCursorDown();
        else
          soundManager.SoundDown(volumeBar);
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
    Enum SendMenuType = configEnum.SOUND;
    Selector = new MenuCursor(SendMenuType.getDeclaringClass(),CursorCommandsMap); 
  }
  private void InitCommands()
  {
    CursorCommandsMap.put(configEnum.SOUND,new SetSoundCommand(this));
    CursorCommandsMap.put(configEnum.GEEK_DATA,new ToggleGeekCommand());
  }

  //--------------------------------------------------
  //------------COMMANDS------------------------------
  //--------------------------------------------------
  private class SetSoundCommand extends Command
  {
    private ConfigurationState config;
    public SetSoundCommand(ConfigurationState config)
    {
      this.config = config;
    }
    @Override
    public void Execute()
    {
      config.isSettingSound = !config.isSettingSound;
    }
    @Override
    public void Execute(Enum key)
    {
    }
  }

  private class ToggleGeekCommand extends Command
  {
    @Override
    public void Execute()
    {
      ((GameState)State.GameState).isGeekActivated = !((GameState)State.GameState).isGeekActivated;
      println(((GameState)State.GameState).isGeekActivated);
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