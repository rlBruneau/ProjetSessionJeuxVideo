public class Triangle extends GraphicObject
{
    public PVector trianglePoint1;
    public PVector trianglePoint2;
    public PVector trianglePoint3;

    public Triangle(float x1,float y1,float x2,float y2,float x3,float y3)
    {
        trianglePoint1 = new PVector(x1,y1);
        trianglePoint2 = new PVector(x2,y2);
        trianglePoint3 = new PVector(x3,y3);
    } 

    public void Update(float delta)
    {
        
    }
    public void Display(float x, float y)
    {
        triangle(trianglePoint1.x,trianglePoint1.y,trianglePoint2.x,trianglePoint2.y,trianglePoint3.x,trianglePoint3.y);
    }
}
