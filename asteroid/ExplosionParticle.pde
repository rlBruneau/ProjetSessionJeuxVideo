public class ExplodingParticles extends ParticleGenerator
{
    public ExplodingParticles(float x, float y, float duration, Color startColor, int nbParticleProducted)
    {
        position = new PVector(x,y);
        aliveTime = duration;
        this.startColor = startColor;
        this.nbParticleProducted = nbParticleProducted;
        particleDrawing();
    } 

    @Override
    protected void particleDrawing()
    {
        Random random = new Random();
        float startAngle = radians(random.nextInt(360));
        for(int i = 0; i < nbParticleProducted; i++)
        {
            float particleRadius = (float)(random.nextDouble() * 3  + 2);
            float particleSpeed = (float)(random.nextDouble() * 2);
            
            particles.add(new Particle(startAngle,aliveTime,particleSpeed,position.copy(),particleRadius,startColor));
            
            startAngle = startAngle + 0.2f;//(float)(radians(particleSpeed = (float)(10 + Math.random() * (20 - 10))));
        }
    }

    @Override
    public void Display(float x, float y)
    {
        for(Particle p : particles)
        {
            p.Display(-1,-1);
        }
    }

    @Override
    public void Update(float delta)
    {
        if(particles.size() > 0)
        {
            for(int i=0; i<particles.size();i++)
            {
                particles.get(i).Update(delta);
                if(particles.get(i).ellapsedTime > aliveTime)
                    particles.remove(particles.get(i));
            }
        }
    }

}