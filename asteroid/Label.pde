public class Label extends GraphicObject{
    private float x,y;
    private color backgroundColor;
    private color textColor;
    private float textsize;
    private String text;
    private float padding;
    float scalar = 0.8; // Different for each font

    public Label(int x, int y, color backgroundColor, color textColor, int textSize, String text, int padding)
    {
        this.x = x;
        this.y = y;
        this.backgroundColor = backgroundColor;
        this.textColor = textColor;
        this.textsize = textSize;
        this.text = text;
        this.padding = padding;
    }
    public Label(color backgroundColor, color textColor, int textSize, String text, int padding)
    {
        textSize(textSize);
        this.x = width/2 - ((textWidth(text)/2) + padding);
        this.y = height/2 - ((textAscent() * scalar)/2 + padding);
        this.backgroundColor = backgroundColor;
        this.textColor = textColor;
        this.textsize = textSize;
        this.text = text;
        this.padding = padding;
    }

    @Override
    public void Update(float delta)
    {

    }

    @Override
    public void Display(float x, float y)
    {

    }

    public void Display()
    {
        textSize(textsize);
        fill(backgroundColor);
        rect(x,y,textWidth(text) + (2 * padding),(textAscent() * scalar) + (2 * padding));
        fill(textColor);
        text(text,x + padding, y + padding + textAscent() * scalar);
    }
}