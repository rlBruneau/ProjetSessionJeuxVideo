public class ShipShootingPoint
{
    PVector point;
    public ShipShootingPoint(float x, float y)
    {
        point = new PVector(x,y);
    }

    public void Update(float delta, Ship ship)
    {
        float Vlength = PVector.dist(point,ship.position);
        float px = (cos(ship.angle + HALF_PI) * ship.w/1.80) + ship.position.x;
        float py = (sin(ship.angle + HALF_PI) * ship.h/1.80) + ship.position.y;
        //float py = Vlength * sin(ship.angle);
        point.x = px;
        point.y = py;
    }
}