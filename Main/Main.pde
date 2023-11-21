ArrayList<Arrow> arrows = new ArrayList<Arrow>();
PotionMaker potionMaker;
InventorySystem inventorySystem;
SceneManager sceneManager;

boolean hasBeenClicked = false;

void setup()
{
  size(1280, 720);
  potionMaker = new PotionMaker();
  inventorySystem = new InventorySystem();
  sceneManager = new SceneManager();
  sceneManager.ChangeScene("Store");
}
void draw()
{
  background(0);
  sceneManager.update(); //This method has to be at the top of draw()
  drawArrows();
}
void drawArrows()
  {
    for (int i = arrows.size() - 1; i >= 0; i--)
    {
      arrows.get(i).update();
    }
  }
void spawnArrows()
{
    shapeMode(CENTER);
    arrows.clear();
    if (sceneManager.currentScene == "Store")
    {
      arrows.add(new Arrow(new PVector(10, height / 2), "arrowLeft", "Basement"));
      arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Cauldron Room"));
    }
    else if (sceneManager.currentScene == "Basement")
    {
      arrows.add(new Arrow(new PVector(140, height / 3), "arrowUp", "Cauldron Room"));
      arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Store"));
    }
    else if (sceneManager.currentScene == "Cauldron Room")
    {
      arrows.add(new Arrow(new PVector(10, height / 2), "arrowLeft", "Store"));
      arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Basement"));
    }
}
void mousePressed()
{
  if (!hasBeenClicked)
  {
    hasBeenClicked = true;
    for (int i = arrows.size() - 1; i >= 0; i--)
    {
      float distance = dist(arrows.get(i).position.x, arrows.get(i).position.y, mouseX, mouseY);
      if (distance <= arrows.get(i).sprite.width && distance <= arrows.get(i).sprite.height)
      {
        sceneManager.ChangeScene(arrows.get(i).sceneToGo);
      }
    }
  }
}
void mouseReleased()
{
  hasBeenClicked = false;
}
