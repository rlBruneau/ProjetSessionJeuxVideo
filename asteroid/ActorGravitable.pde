public abstract class ActorGravitable extends Actor
{
    protected ArrayList<Actor> gravitables;
    public ActorGravitable(int x, int y){super(x,y);}
    public ActorGravitable(){super();}
    protected void CalculateGravity(float delta)
    {
        gravity.x=0;
        gravity.y=0;
        for(Actor a : gravitables)
        {
            if(a != this)
            {
                double FNorm = ((6.67430 * Math.pow(10,-11)) * mass * a.mass)/(Math.pow(PVector.dist(a.position,position),2));
                PVector newPvector = new PVector();
                //set x component

                newPvector.x = a.position.x - position.x;
                newPvector.y = a.position.y - position.y;
                newPvector.normalize();
                newPvector.mult((float)FNorm).div(delta);///TODO: comprendre pourquoi div par delta
                gravity.add(newPvector);
            }
        }
    }

    public void SetGravitables(ArrayList<Actor> gravitables)
    {
        this.gravitables = gravitables;
    }
}