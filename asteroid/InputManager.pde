import java.util.*;

public class InputManager
{
  private HashMap<KeyMap,Boolean> keyMap;
  public HashMap<KeyMap,Boolean>keyMap(){return keyMap;}
  private boolean enterInput = false;
  private Enum keyToMap;
  private MenuCursor selector;
  public InputManager()
  {
    keyMap = new HashMap<KeyMap,Boolean>();
    InitKeyMap();
    initKeys();
  }

  private HashMap<KeyMap,Integer> Keys = new HashMap<KeyMap,Integer>();

  private void initKeys()
  {
    Keys.put(KeyMap.SPEED_UP,(int)'w');
    Keys.put(KeyMap.ROTATE_LEFT,(int)'a');
    Keys.put(KeyMap.ROTATE_RIGHT,(int)'d');
    Keys.put(KeyMap.TRANSLATE_LEFT,(int)'q');
    Keys.put(KeyMap.TRANSLATE_RIGHT,(int)'e');
    Keys.put(KeyMap.ESCAPE,(int)ESC);
    Keys.put(KeyMap.ARROW_UP,(int)UP);
    Keys.put(KeyMap.ARROW_DOWN,(int)DOWN);
    Keys.put(KeyMap.SELECT,(int)ENTER);
    Keys.put(KeyMap.BACK,(int)BACKSPACE);
  }
  

  
  public void keyPressed()
  { //<>//
    if(!enterInput)
    {
      //if(key != CODED)
      {
        if(key == Keys.get(KeyMap.ESCAPE) || keyCode == Keys.get(KeyMap.ESCAPE))
        {
          if( !keyMap.get(KeyMap.ESCAPE))
            {
              key = 0;
              keyMap.replace(KeyMap.ESCAPE,true);
            }
            else
              key = Character.MAX_VALUE;
        }
        else if(key == Keys.get(KeyMap.SELECT) || keyCode == Keys.get(KeyMap.SELECT))
        {
          if(!keyMap.get(KeyMap.SELECT))
            keyMap.replace(KeyMap.SELECT,true);
        }
        else if(key == Keys.get(KeyMap.TRANSLATE_LEFT) || keyCode == Keys.get(KeyMap.TRANSLATE_LEFT))
        {
          keyMap.replace(KeyMap.TRANSLATE_LEFT,true);
        }
        else if(key == Keys.get(KeyMap.TRANSLATE_RIGHT) || keyCode == Keys.get(KeyMap.TRANSLATE_RIGHT))
        {
          keyMap.replace(KeyMap.TRANSLATE_RIGHT,true);
        }
        else if(key == Keys.get(KeyMap.ROTATE_LEFT) || keyCode == Keys.get(KeyMap.ROTATE_LEFT))
        {
          keyMap.replace(KeyMap.ROTATE_LEFT,true);
        }
        else if(key == Keys.get(KeyMap.ROTATE_RIGHT) || keyCode == Keys.get(KeyMap.ROTATE_RIGHT))
        {
          keyMap.replace(KeyMap.ROTATE_RIGHT,true);
        }
        else if(key == Keys.get(KeyMap.SPEED_UP) || keyCode == Keys.get(KeyMap.SPEED_UP))
        {
          keyMap.replace(KeyMap.SPEED_UP,true);
        }
        else if(key == Keys.get(KeyMap.BACK) || keyCode == Keys.get(KeyMap.BACK))
        {
          if(!keyMap.get(KeyMap.SELECT))
            keyMap.replace(KeyMap.BACK,true);
        }
        else if(keyCode == Keys.get(KeyMap.ARROW_UP) || key == Keys.get(KeyMap.ARROW_UP))
        {      
          keyMap.replace(KeyMap.ARROW_UP,true);
        }
        else if(keyCode == Keys.get(KeyMap.ARROW_DOWN) || key == Keys.get(KeyMap.ARROW_DOWN))
        {
          if(!keyMap.get(KeyMap.SELECT))
            keyMap.replace(KeyMap.ARROW_DOWN,true);
        }
      }

    }
    else
    {
      boolean canSetNewKey = true;
      for(int i = 0; i < KeyMap.values().length; i++)
      {
        if(Keys.get(KeyMap.values()[i]) == key || Keys.get(KeyMap.values()[i]) == keyCode)
        {
          canSetNewKey = false;
        }
      }
      if(canSetNewKey)
      {
        
        Integer k;
        if(key != CODED)
        {
          k = (int)key;
          if(key == ESC)
          {
            key=0;
          }
        }
        else
        {
          k = (int)keyCode;
        }
        Keys.replace((KeyMap)keyToMap,k);
        enterInput = false;
        selector.canMove = true;
      }
      else
      {
        // dire qu'on ne peux pas setter le key
      }
    }
  }
  
  public void keyReleased()
  {
    int release = -1;
    // pour m'assurer que peux importe ou j'appuis sur esc dans la jeux, ça ne fermera pas le programme etster key == 0 pour escape.
    if(key != CODED)
    {
      release = (int)key;
    }
    else
    {
      release = (int)keyCode;
    }
     
    if(release == Keys.get(KeyMap.ESCAPE))
      keyMap.replace(KeyMap.ESCAPE,false);
    else if(release == Keys.get(KeyMap.SELECT))
      keyMap.replace(KeyMap.SELECT,false);
    else if(release == Keys.get(KeyMap.TRANSLATE_LEFT))
      keyMap.replace(KeyMap.TRANSLATE_LEFT,false);
    else if(release == Keys.get(KeyMap.TRANSLATE_RIGHT))
      keyMap.replace(KeyMap.TRANSLATE_RIGHT,false);
    else if(release == Keys.get(KeyMap.ROTATE_LEFT))
      keyMap.replace(KeyMap.ROTATE_LEFT,false);
    else if(release == Keys.get(KeyMap.ROTATE_RIGHT))
      keyMap.replace(KeyMap.ROTATE_RIGHT,false);
    else if(release == Keys.get(KeyMap.SPEED_UP))
      keyMap.replace(KeyMap.SPEED_UP,false);
    else if(release == Keys.get(KeyMap.BACK))
      keyMap.replace(KeyMap.BACK,false);
    else if(release == Keys.get(KeyMap.ARROW_UP))
      keyMap.replace(KeyMap.ARROW_UP,false);
    else if(release == Keys.get(KeyMap.ARROW_DOWN))
      keyMap.replace(KeyMap.ARROW_DOWN,false);
  }
  
  private void InitKeyMap()
  {
    for(KeyMap _key : KeyMap.values())
    {
      keyMap.put(_key,false);
    }
  }

  public void SetInput(Enum key, MenuCursor selector)
  { 
    InitKeyMap();
    //SetKeyValue(key);
    this.selector = selector;
    enterInput = true;
    keyToMap = key;
    selector.canMove = false;
  }
}
