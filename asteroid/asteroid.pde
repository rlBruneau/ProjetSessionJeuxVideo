float delta;
long nowTick;
long lastTick;


InputManager inputManager;
ObjectManager objectManager;

public void setup()
{
  lastTick = 0;
  size(1200,920);
  inputManager = new InputManager();
  objectManager = new ObjectManager(inputManager);
}

public void Update(float delta)
{
  objectManager.State.CurrentState.Update(delta);
}
public void Display()
{
  objectManager.State.CurrentState.Display();
}

public void keyPressed()
{
  inputManager.keyPressed();
}
public void keyReleased()
{
  inputManager.keyReleased();
}

public void draw()
{
  CalculateDelta();
  Update(delta);
  Display();
}

public void CalculateDelta()
{
  nowTick = millis();
  delta = nowTick - lastTick;
  delta /= 1000;
  lastTick = nowTick;
}
