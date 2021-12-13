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
    String landingPointLabel ="";
    Rectangle speedLabelRect = new Rectangle(0,10,0,15);
    Rectangle landingPointLabelRect = new Rectangle(0,30,0,15);
    Ship ship;
    Arrow arrow;
    float fpsAccumulator=0;

    public HUD(Ship ship)
    {
        this.ship = ship;
        arrow = new Arrow(ship);
    }

    public void Display(float x, float y)
    {
        fill(0,255,0);
        speedLabelRect.Display(-1,-1);
        fill(255,0,0);
        text(speedLable,speedLabelRect.position.x,speedLabelRect.rectangleH + 10);
        fill(0,255,0);
        landingPointLabelRect.Display(-1,-1);
        fill(255,0,0);
        text(landingPointLabel,landingPointLabelRect.position.x,landingPointLabelRect.position.y + 12);
        arrow.Display(x,y);
        
        noStroke();
        if(((ConfigurationState)ship.State.ConfigurationState).isGeekActivated)
        ship.fpsLabel.Display();
    }
    public void Update(float delta)
    {
        arrow.Update(delta);
        speedLable = "Speed : " + String.format("%.02f",ship.velocity.mag()); 
        landingPointLabel = "Landings : " + ship.landing; 
        speedLabelRect.position.x = width/2 - textWidth(speedLable)/2;
        speedLabelRect.rectangleW = textWidth(speedLable);

        landingPointLabelRect.position.x = width/2 - textWidth(speedLable)/2;
        landingPointLabelRect.rectangleW = textWidth(speedLable);

        fpsAccumulator += delta;
        if(fpsAccumulator > 1)
        {
            ship.fpsLabel.text ="fps : " + (int)(1/delta);
            fpsAccumulator = 0;
        }
    }
}