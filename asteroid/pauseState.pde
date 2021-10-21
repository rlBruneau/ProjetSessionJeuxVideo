public class PauseState extends States
{
  private States State;
  private String pauseString;
  
  public PauseState(States state, InputManager inputManager)
  {
    super(inputManager);
    this.State = state;
  }
  @Override
  public void Update(float delta)
  {
    
  }
  @Override
  public void Display()
  {
    State.GameState.Display();
    fill(255,255,255,160);
    rect(0,0,width,height);
    textSize(128);
    fill(255,0,0);
    pauseString = "Pause";
    text(pauseString,width/2 - (textWidth(pauseString) / 2),height/2);
  }
}
