class Arrow
{
  PVector position;
  PImage sprite;
  String sceneToGo; //Can be Main Menu, Store, Cauldron Room, Basement
  Arrow(PVector pPos, String spriteRotation, String pSceneToGo)
  {
    position = pPos;
    sprite = loadImage(spriteRotation + ".png");
    sceneToGo = pSceneToGo;
  }
  void update()
  {
    image(sprite, position.x, position.y);
  }
  void onClick(String sceneName)
  {
     if (mousePressed && !hasBeenClicked)
     {
       hasBeenClicked = true;       
       sceneManager.ChangeScene(sceneName + ".png");
     }
  }
}
