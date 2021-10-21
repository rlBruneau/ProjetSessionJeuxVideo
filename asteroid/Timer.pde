public class Timer
{
  private double timerLength;
  private float ellapsedTime;
  private boolean isTicking;
  public Timer(double lengthMillis)
  {
    ellapsedTime = 0;
    timerLength = lengthMillis;
    isTicking = true;
  }
  public Timer()
  {
    ellapsedTime = 0;
    timerLength = 0;
    isTicking = false;
  }
  public void startT(double lengthMillis)
  {
    ellapsedTime = 0;
    timerLength = lengthMillis;
    isTicking = true;
  }
  public boolean hasFinished(float delta)
  {
    if(isTicking)
    {
      ellapsedTime += delta * 1000;
      if(ellapsedTime >= timerLength)
      {
        isTicking = false;
        return false;
      }
    }
    else
      return true;
    return false;
  }
}
