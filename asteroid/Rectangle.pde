public class Rectangle extends GraphicObject
{
  public float roundCorner;
  public float rectangleW;
  public float rectangleH;

  public Rectangle(float x,float y,float w,float h)
  {
    super(x,y);
    rectangleH = h;
    rectangleW = w;
  }

  public void Update(float delta)
  {

  }
  public void Display(float x, float y)
  {
    rect(position.x, position.y, rectangleW, rectangleH);
  }
  public boolean Check = true;
}
