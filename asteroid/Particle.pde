public class Particle extends GraphicObject
{
    private float direction;
    private float duration;
    private float speed;
    private Color col;
    private float al = 0;
    private float ellapsedTime = 0;
    private boolean isAlive = true;
    private float radius;

    public Particle(float direction, float duration, float speed, PVector position, float radius, Color col)
    {
        this.position = position;
        this.direction = direction;
        this.duration = duration;
        this.speed = speed;
        this.radius = radius;
        this.col = col;
    }

    @Override
    public void Display(float x, float y)
    {
        noStroke();
        fill(col.red,col.green,col.blue,col.alpha);
        ellipse(position.x, position.y, radius*2, radius*2);
    }
    public void Update(float delta)
    {
        ellapsedTime += delta;
        if(ellapsedTime > duration)
            isAlive = false;

        float persent = ellapsedTime * 100 / duration;
        persent = 100 - persent;
        col.alpha = persent * 255 / 100;
        position.add(PVector.fromAngle(direction).mult(speed));
    }
}