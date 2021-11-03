public class Camera
{
    private Actor actorFolloed;
    private float xOff = 0;
    private float yOff = 0;
    private float viewPortX;
    private float viewPortY;


    public void init(Actor actor, float viewPortX,float viewPortY)
    {
        actorFolloed = actor;
        this.viewPortX = viewPortX;
        this.viewPortY = viewPortY;
    }

    public void setOffsets()
    {
        xOff += actorFolloed.velocity.x;
        yOff += actorFolloed.velocity.y;
    }

    public void resetOffset()
    {
        xOff = 0;
        yOff = 0;
    }

    public void setNewOffsets(float xOff, float yOff)
    {
        this.xOff = xOff;
        this.yOff = yOff;
    }

}