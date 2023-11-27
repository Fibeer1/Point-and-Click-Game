class Arrow
{
  PVector position;
  PImage spriteOff;
  PImage spriteOn;
  String sceneToGo; //Can be Main Menu, Store, Cauldron Room, Basement
  boolean hover;
  Arrow(PVector pPos, String spriteRotation, String pSceneToGo)
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
    if (!hasChangedScene && hasBeenClicked && !isHoldingItem)
    {     
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + spriteOff.width &&
        mouseY > position.y &&
        mouseY < position.y + spriteOff.height;
      if (withinBox)
      {
        hasChangedScene = true;
        sceneManager.ChangeScene(sceneToGo);
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
