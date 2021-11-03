public class Arrow extends GraphicObject
{
    Ship ship;
    PVector line1 = new PVector();
    PVector line2 = new PVector();
    float angle = radians(60);
    public Arrow(Ship ship)
    {
        this.ship = ship;
        position = ship.position;
        line1.set(ship.gravity.y,-ship.gravity.x);
        line1.normalize();
        line2.set(ship.gravity.y,-ship.gravity.x);
        line2.normalize().mult(-1);
    }

    public void Display(float x, float y)
    {
        strokeWeight(3);
        stroke(0);
        line(x,y,ship.gravity.x + x, ship.gravity.y + y);
        line1.mult(10);
        line2.mult(10);
        line(ship.gravity.x + x, ship.gravity.y + y, line1.x + ship.gravity.x + x,line1.y + ship.gravity.y + y);
        line(ship.gravity.x + x, ship.gravity.y + y, line2.x + ship.gravity.x + x,line2.y + ship.gravity.y + y);
    }
    public void Update(float delta)
    {
        line1.set(ship.gravity.y,-ship.gravity.x);
        line1.normalize().rotate(-angle);
        line2.set(ship.gravity.y,-ship.gravity.x);
        line2.normalize().mult(-1).rotate(angle);
        //line1 = PVector.fromAngle(PVector.angleBetween(ship.position,ship.gravity)+angle);
        //line2 = PVector.fromAngle(PVector.angleBetween(ship.position,ship.gravity)-angle);
    }
}

public class HUD extends GraphicObject
{
    String speedLable = ""; 
    float rectx;
    float recty = 10;
    float rectw;
    float recth = 15;
    Ship ship;
    Arrow arrow;

    public HUD(Ship ship)
    {
        this.ship = ship;
        println(ship.position);
        arrow = new Arrow(ship);
    }

    public void Display(float x, float y)
    {
        fill(0,255,0);
        rect(rectx,recty,rectw,recth);
        fill(255,0,0);
        text(speedLable,rectx,recth + 10);
    
        arrow.Display(x,y);
        
        noStroke();
    }
    public void Update(float delta)
    {
        arrow.Update(delta);
        speedLable = "Speed : " + String.format("%.02f",ship.velocity.mag()); 
        rectx = width/2 - textWidth(speedLable)/2;
        rectw = textWidth(speedLable);
    }
}