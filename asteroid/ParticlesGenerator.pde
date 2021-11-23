public abstract class ParticleGenerator extends GraphicObject
{
    protected ArrayList<Particle> particles = new ArrayList<Particle>();
    protected boolean isCreatingParticle = false;
    protected float aliveTime;
    protected Color startColor;
    protected int nbParticleProducted;
    protected abstract void particleDrawing();
}