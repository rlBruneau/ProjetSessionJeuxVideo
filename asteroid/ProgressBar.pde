public class ProgressBar extends GraphicObject
{
    private float x,y,w,h;
    private float percent = 100;
    private color backgroundRectColor; 
    private color backgroundRectBorderColor; 
    private color foregroundRectColor;
    private float borderSize;
    private color borderColor;

    public void SetPersent(float minValue, float maxValue, float actualValue)
    {
        percent = actualValue * 100 / (maxValue-minValue);
    }

    public ProgressBar(float x, float y, float w, float h, color backgroundColor,
        color foregroundRectColor,float borderSize, color borderColor)
    {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.backgroundRectColor = backgroundColor;
        this.backgroundRectBorderColor = backgroundRectBorderColor;
        this.foregroundRectColor = foregroundRectColor;
        this.borderSize = borderSize;
        this.borderColor = borderColor;
    }

    public void Display(float x, float y){}
    public void Display()
    {
        noStroke();
        fill(backgroundRectColor);
        rect(x,y,w,h);
        fill(foregroundRectColor);
        rect(x,y,w*percent/100,h);
        noFill();
        strokeWeight(borderSize);
        stroke(borderColor);
        rect(x-(borderSize/2),y-(borderSize/2),w+(borderSize),h+(borderSize));
        noStroke();
    }
    public void Update(float delta){}
}