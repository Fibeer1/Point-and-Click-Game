class SceneManager
{
  String currentScene; //Can be Main Menu, Store, Cauldron Room, Basement
  PImage background; //Same names as the scene's name
  public void ChangeScene(String sceneName)
  {
    currentScene = sceneName;
    background = loadImage(sceneName + ".png");
    spawnInteractables();
  }
  void update()
  {
    background(0);
    imageMode(CORNER);
    image(background, 0, 0);
  }  
}
