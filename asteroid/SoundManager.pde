import processing.sound.*;
public class SoundManager
{
    public SoundFile ReactorOn;
    Sound sound;
    public SoundManager(PApplet p)
    {
        sound = new Sound(p);
        sound.volume(1);

        ReactorOn = new SoundFile(p,"RocketSound.mp3");
    }
}