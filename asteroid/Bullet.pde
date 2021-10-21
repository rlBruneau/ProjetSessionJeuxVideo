public class Bullet extends Actor
{
    public final int BULLET_RADIUS = 5;
    public int speed = 200;
    public Bullet(float x, float y, float angle, float shipSpeed, float delta)
    {
        super(x,y);
        velocity = PVector.fromAngle(angle);
        velocity.mult(speed+(shipSpeed/delta));
    }

    @Override
    public void Display()
    {
        pushMatrix();
            translate(position.x,position.y);
            ellipse(0, 0, BULLET_RADIUS*2, BULLET_RADIUS*2);
        popMatrix();
    }

    @Override
    public void Update(float delta)
    {
        position.add(velocity.copy().mult(delta));
        if(position.x > width + (BULLET_RADIUS*2) || position.x < 0 || position.y > height + (BULLET_RADIUS*2) || position.y < 0)
            isAlive = false;
        CallCollisionMethods();
    }


    //*******************************************************
    //**********Get Collisions With Observer Patterns********
    //*******************************************************

    private ArrayList<Actor> collidables = new ArrayList<Actor>();

    public void AddCollidable(Actor obj)
    {
        collidables.add(obj);
    }

    private void CallCollisionMethods()
    {
        if(collidables.size() > 0)
        {
            for(Actor obj : collidables)
            {
                TestCollision(obj);
            }
        }
    }

    private void TestCollision(Actor obj)
    {
        if(BULLET_RADIUS + obj.radius > dist(obj.position.x,obj.position.y,position.x,position.y))
        {
            obj.GotCollided(this);
            isAlive = false;

            println(dist(obj.position.x,obj.position.y,position.x,position.y) + " " + (BULLET_RADIUS + obj.radius) + " " + BULLET_RADIUS + " " + obj.radius);
        }
    }
}