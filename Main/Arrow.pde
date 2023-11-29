class SceneChanger
{
  PVector position;
  PImage spriteOff;
  PImage spriteOn;
  String sceneToGo; //Can be Main Menu, Store, Cauldron Room, Basement or Quit
  boolean hover;
  SceneChanger(PVector pPos, String spriteRotation, String pSceneToGo)
  {
    position = pPos;
    spriteOff = loadImage(spriteRotation + "Off" + ".png");
    spriteOn = loadImage(spriteRotation + "On" + ".png");
    sceneToGo = pSceneToGo;
  }
  void update()
  {
    imageMode(CORNER);
    handleMouseHover();
    handleMouseClick();
  }
  void handleMouseClick()
  {
    if (!hasChangedScene && hasBeenClicked && !isHoldingItem && !isBookOpen)
    {     
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + spriteOff.width &&
        mouseY > position.y &&
        mouseY < position.y + spriteOff.height;
      if (withinBox)
      {
        hasChangedScene = true;
        if (sceneToGo == "Play")
        {
          sceneManager.ChangeScene("Store");
            bookManager.SetupBook();
            inventoryUIActive = true;
            for (int j = 0; j < inventoryPanels.length; j++)
            {
              if (j == 0)
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 207 + j * 100, height - 100), "PanelRight", "Ingredient", j);
              }
              else if (j == inventoryPanels.length - 1)
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 200 + j * 100, height - 100), "PanelLeft", "Ingredient", j);
              }
              else
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 200 + j * 100, height - 100), "Panel", "Ingredient", j);
              }              
            }
        }
        else if (sceneToGo == "Quit")
        {
          exit();
        }
        else
        {
          sceneManager.ChangeScene(sceneToGo);
        }        
      }
    }
  }
  void handleMouseHover()
  {
    boolean withinBox =
      mouseX > position.x &&
      mouseX < position.x + spriteOff.width &&
      mouseY > position.y &&
      mouseY < position.y + spriteOff.height;
    if (withinBox)
    {
      image(spriteOn, position.x, position.y);
    } else
    {
      image(spriteOff, position.x, position.y);
    }
  }
}
