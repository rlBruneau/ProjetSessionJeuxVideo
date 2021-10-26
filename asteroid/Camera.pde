public class Camera
{
    private Actor actorFolloed;
    float xOff = 0;
    float yOff = 0;

    public void setActorFolloed(Actor actor)
    {
        actorFolloed = actor;
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

}