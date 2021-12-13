import processing.sound.*;
float delta;
long nowTick;
long lastTick;

SoundFile ReactorOn;


InputManager inputManager;
ObjectManager objectManager;
public Camera cam = new Camera();
public SoundManager soundManager;


public void setup()
{
  
  soundManager = new SoundManager(this);
  lastTick = 0;
  //fullScreen();
  size(1200,920,P2D);
  inputManager = new InputManager();
  objectManager = new ObjectManager(inputManager);
  soundManager = new SoundManager(this);
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
