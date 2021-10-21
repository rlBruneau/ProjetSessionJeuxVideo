public class MenuMesures
{
  //================================================================================================================
  //|=====Main Window Mesures======================================================================================|
  //|==============================================================================================================|
  private float mainWindowTopMargin = 15;
  private float mainWindowWidthFactor = 8;
  private PVector mainWindowPos = new PVector(width/mainWindowWidthFactor,mainWindowTopMargin);
  private float mainWindowW = width-(width/(mainWindowWidthFactor/2));
  private float mainWindowH = height - (mainWindowTopMargin*2);
  private float mainWindowRound = 75;
  
  public float mainWindowTopMargin(){return mainWindowTopMargin;}
  public float mainWindowWidthFactor(){return mainWindowWidthFactor;}
  public float mainWindowW(){return mainWindowW;}
  public float mainWindowH(){return mainWindowH;}
  public float mainWindowRound(){return mainWindowRound;} 
  
  //================================================================================================================
  //|=====Menu Selector Mesures====================================================================================|
  //|==============================================================================================================|
  public float cursorX = width/3;
  public float cursorY = width/5;
  public float cursorH =  30;
  public float cursorW =  30;
  public float cursorDistanceBetweenJump = 45;

  //===============================================================================================================
  //=====Rectangle selection Mesures===============================================================================
  //===============================================================================================================
  public float rectX = cursorX + cursorW + 10;
  public float rectY = cursorY;
  public float rectH = cursorH;
  public float messageSize = 18;

  public float bigRectW = width/4;

  public float mediumRectW = width/5;

  public float smallRectW = width/6;

}
