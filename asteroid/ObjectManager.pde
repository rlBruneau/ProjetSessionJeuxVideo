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
    State.GameTestState = new GameTestState(State,inputManager);
    State.CurrentState = State.GameTestState;
    State.StateType(StateEnum.START);
  }
}
