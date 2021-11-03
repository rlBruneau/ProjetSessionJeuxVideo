public enum MenuItemsSize
{
    BIG,
    MEDIUM,
    SMALL
}

public class MenuItem extends GraphicObject
{
    private float x,y,w,h;
    private String message;
    private color selectedRectColor;
    private color selectedTextColor;
    private color textColor;
    private float textX;
    private float textY;
    private float messageSize;
    private MenuCursor selector;
    Enum enumValue;

    public MenuItem(Enum menuItem, MenuItemsSize size, int sequenceNumber, MenuCursor selector)
    {
        enumValue = menuItem;
        this.selector = selector;
        MenuMesures mm = new MenuMesures();
        this.x = mm.rectX;
        this.y = mm.rectY + (sequenceNumber * mm.cursorDistanceBetweenJump);
        this.h = mm.rectH;
        switch(size)
        {
            case BIG:
                    this.w = mm.bigRectW;
                break;
            case MEDIUM:
                    this.w = mm.mediumRectW;
                break;
            case SMALL:
                    this.w = mm.smallRectW;
                break;
        }
        messageSize = mm.messageSize;
        message = menuItem.toString();
        fillColor = color(255,0,0);
        textColor = color(0,0,255);
        selectedTextColor = color(255,0,0);
        selectedRectColor = color(0,0,255);
        textSize(messageSize);
        float rest = w - textWidth(message);
        textX = (x + (rest/2));

        float a = textAscent() * 0.8;
        float d = textDescent() * 0.8;
        float textH = d-a;
        rest = h-textH;
        textY = y + (rest/2);
    }

    @Override
    public void Update(float delta)
    {

    }

    @Override
    public void Display(float x,float y)
    {
        textSize(messageSize);
        if(selector.SelectedOption == enumValue)
        {
            fill(selectedRectColor);
            rect(this.x, this.y, w, h);
            fill(selectedTextColor);
            text(message,textX,textY);
        }
        else
        {
            fill(fillColor);
            rect(this.x,this.y,w,h);
            fill(textColor);
            text(message,textX,textY);
        }
    }
}