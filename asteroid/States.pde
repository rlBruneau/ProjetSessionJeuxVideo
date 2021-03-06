public class States
{
  //attribut
  private StateEnum StateType;
  private States CurrentState;
  private States GameState;
  private States PauseState;
  private States StartGameState;
  private States ControlState;
  private States ConfigurationState;
  private States GameOverState;
  private InputManager inputManager;
  protected HashMap<KeyMap,Boolean> keyMap;
  //setters et getters
  public void StateType(StateEnum stateType){StateType = stateType;}
  public StateEnum StateType(){return StateType;}
  public InputManager inputManager(){return inputManager;}
  
  public States(InputManager inputManager)
  {
    this.inputManager = inputManager;
    this.keyMap = inputManager.keyMap();
  }
  
  public void CurrentState(StateEnum state)
  {
    StateType = state;
    switch(state)
    {
      case GAME:
        CurrentState = GameState();
        break;
      case START:
        CurrentState = StartGameState;
        break;
      case PAUSE:
        CurrentState = PauseState;
        break;
      case CONTROLS:
        CurrentState = ControlState;
        break;
      case CONFIGURATION:
        CurrentState = ConfigurationState;
        println(CurrentState);
        break;
        case GAMEOVER:
      CurrentState = GameOverState;
        println(CurrentState);
        break;
        
    }
    
  }
  public States CurrentState(){return CurrentState;}
  
  public void GameState(States state){CurrentState = state;}
  public States GameState(){return GameState;}
  
  public void PauseState(States state){CurrentState = state;}
  public States PauseState(){return PauseState;}
  
  public void StartGameState(States state){CurrentState = state;}
  public States StartGameState(){return StartGameState;}

  public void ControlState(States state){CurrentState = state;}
  public States ControlState(){return ControlState;}

  public void ConfigurationState(States state){CurrentState = state;}
  public States ConfigurationState(){return ConfigurationState;}

  public void GameOverState(States state){CurrentState = state;}
  public States GameOverState(){return ConfigurationState;}

  //fin attribut et getters/setters
  
  public  void Update(float delta)
  {
    println("fonction Update non overrite dans le state" + CurrentState.toString());
  }
  public  void Display()
  {
    println("fonction Update non overrite dans le state" + CurrentState.toString());
  }  
}
