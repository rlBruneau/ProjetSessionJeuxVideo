import processing.sound.*;
public class SoundManager
{
    public SoundFile ReactorOn;
    public SoundFile BackgroundMusic;
    private SoundFile backgroundSound;
    private Sound sound;
    public float volume = 1;
    private final float soundStep = 0.05;
    public SoundManager(PApplet p)
    {
        sound = new Sound(p);
        sound.volume(volume);

        ReactorOn = new SoundFile(p,"RocketSound.mp3");
        backgroundSound = new SoundFile(p,"backgroundSound.mp3");
        BackgroundMusic = backgroundSound;
        BackgroundMusic.loop();
    }

    public void SoundDown(ProgressBar volumeBar)
    {
        if(volume - soundStep > 0)
        {
            volume -= soundStep;
            sound.volume(volume);
            volumeBar.SetPersent(0,1,volume);
        }
        else
        {
            volume = 0;
            sound.volume(volume);
            volumeBar.SetPersent(0,1,volume);
        }
    }
    public void SoundUp(ProgressBar volumeBar)
    {
        if(volume + soundStep < 1)
        {
            volume += soundStep;
            sound.volume(volume);
            volumeBar.SetPersent(0,1,volume);
        }
        else
        {
            volume = 1;
            sound.volume(volume);
            volumeBar.SetPersent(0,1,volume);
        }
        
    }
}