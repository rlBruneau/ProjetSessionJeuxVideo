public abstract class GraphicObject
{
  protected PVector position;
  protected float angle;

  color fillColor = color (255);
  color strokeColor = color (255);
  float strokeWeight = 1;

  
  public GraphicObject(float x, float y)
  {
    angle = 0;
    position = new PVector(x,y);
  }
  public GraphicObject()
  {
    angle = 0;
  }
  public abstract void Update(float delta);
  public abstract void Display(float x, float y);
  
  protected PVector getDisplayPosition()
  {
    return new PVector(position.x - cam.xOff, position.y - cam.yOff);
  }
}
