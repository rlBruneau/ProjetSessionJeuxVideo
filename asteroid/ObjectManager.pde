public class ObjectManager
{
  private States State;
  public States State()
  {
    return State;
  }
  
  public ObjectManager(InputManager inputManager)
  {
    State = new States(inputManager);
    State.StartGameState = new StartGameState(State, inputManager);
    State.GameState = new GameState(State, inputManager);
    State.PauseState = new PauseState(State, inputManager);
    State.ControlState = new ControlState(State, inputManager);
    State.ConfigurationState = new ConfigurationState(State,inputManager);
    State.CurrentState = State.StartGameState;
    State.StateType(StateEnum.START);
  }
}
