
public class MenuCursor<T extends Enum<T>> extends Actor
{
  public boolean canMove = true;
  private float h;
  private float w;
  private float distanceBetweenJump;
  public Enum SelectedOption;
  public Command selectedOption;
  private Stack<Enum> menuUp;
  private Stack<Enum> menuDown;
  private HashMap<Enum,Command> CursorCommands;
  private PVector trianglePoint1 = new PVector();
  private PVector trianglePoint2 = new PVector();
  private PVector trianglePoint3 = new PVector();

  public PVector trianglePoint1(){return trianglePoint1;}
  public PVector trianglePoint2(){return trianglePoint2;}
  public PVector trianglePoint3(){return trianglePoint3;}

  public MenuCursor(Class<T> MenuType, HashMap<Enum,Command> CursorCommands)
  {
    MenuMesures mesure = new MenuMesures();
    position = new PVector(mesure.cursorX, mesure.cursorY);
    this.h = mesure.cursorH;
    this.w = mesure.cursorW;
    this.distanceBetweenJump = mesure.cursorDistanceBetweenJump;
    //trouver commnet confirmer que c'est bien l'une ou l'autre des bon type d'enum (MenuSections ou pauseMenu)
    Object[] list = MenuType.getEnumConstants();
    menuUp = new Stack<Enum>();
    menuDown = new Stack<Enum>();
    SelectedOption =(Enum)list[0];
    for(int i=list.length - 1; i > 0; i--)
    {
      menuDown.push((Enum)list[i]);
    }
    selectedOption = CursorCommands.get(MenuSections.START_GAME);

    this.CursorCommands = CursorCommands;
    fillColor = color(0,255,0);
  }
  @Override
  public void Update(float delta)
  {
    trianglePoint1 = position.copy();
    trianglePoint2.x = position.copy().x + w;
    trianglePoint2.y = position.copy().y + h/2;
    trianglePoint3.x = position.copy().x;
    trianglePoint3.y = position.copy().y + h;
  }
  
  @Override
  public void Display(float x, float y)
  {
    fill(fillColor);
    triangle(position.x,position.y,position.x + w, position.y + (h/2), position.x, position.y+h);
  }

  private void SelectingCursorDown()
  {
    if(!menuDown.empty() && canMove)
    {
      menuUp.push(SelectedOption);
      SelectedOption = menuDown.pop();
      selectedOption = CursorCommands.get(SelectedOption);
      position.y += distanceBetweenJump;
      println(SelectedOption);
    }
  }
  private void SelectingCursorUp()
  {
    if(!menuUp.empty() && canMove)
    {
      menuDown.push(SelectedOption);
      SelectedOption = menuUp.pop();
      selectedOption = CursorCommands.get(SelectedOption);
      position.y -= distanceBetweenJump;
      println(SelectedOption);
    }
  }
}
