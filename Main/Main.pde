//Interactables
ArrayList<Arrow> arrows = new ArrayList<Arrow>();
ArrayList<Text> textBoxes = new ArrayList<Text>();
ArrayList<Item> basementItems = new ArrayList<Item>();
ArrayList<PotionMakerPanel> potionMakerPanels = new ArrayList<PotionMakerPanel>();
Item[] cauldronItems = new Item[2];
Item[] inventoryItems = new Item[4];
InventorySystem[] inventoryPanels = new InventorySystem[4]; //The item count and the panel count should be equal

SceneManager sceneManager;
PotionMakerPanel potionMakerBackground;
Cauldron cauldron;
Cursor cursor;

int itemsHeld = 0;

boolean hasBeenClicked = false;
boolean hasChangedScene = false;
boolean hasClickedTextBox = false;
boolean isHoldingItem = false;
boolean potionMakerUIActive = false;

void setup()
{
  size(1280, 720);
  frameRate(60);
  noCursor();
  cursor = new Cursor(new PVector(mouseX, mouseY), "Cursor");
  sceneManager = new SceneManager();
  sceneManager.ChangeScene("Main Menu");
  spawnPotionMakerUI();
}
void draw()
{
  background(0);
  sceneManager.update(); //This method has to be at the top of draw()
  drawInteractables();
}
void drawInteractables()
{
  for (int i = 0; i < inventoryPanels.length; i++)
  {
    if (inventoryPanels[i] != null)
    {
      inventoryPanels[i].update();
    }
  }
  if (sceneManager.currentScene == "Cauldron Room")
  {
    cauldron.update();
    if (potionMakerUIActive)
    {
      if (potionMakerBackground != null)
      {
        potionMakerBackground.update();
      }
      for (int i = potionMakerPanels.size() - 1; i >= 0; i--)
      {
        potionMakerPanels.get(i).update();
      }
      for (int i = 0; i < cauldronItems.length; i++)
      {
        Item item = cauldronItems[i];
        if (item != null)
        {
          print(1);
          item.update();
        }
      }
    }
  }
  for (int i = arrows.size() - 1; i >= 0; i--)
  {
    arrows.get(i).update();
  }
  for (int i = textBoxes.size() - 1; i >= 0; i--)
  {
    textBoxes.get(i).update();
  }
  for (int i = basementItems.size() - 1; i >= 0; i--)
  {
    basementItems.get(i).update();
  }
  for (int i = 0; i < inventoryItems.length; i++)
  {
    if (inventoryItems[i] != null)
    {
      inventoryItems[i].update();
    }
  }
  if (basementItems.size() > 0 && basementItems.get(0) != null)
  {
    text(basementItems.get(0) + "", 50, 50);
  }
  cursor.update();
}
void spawnInteractables()
{
  shapeMode(CENTER);
  arrows.clear();
  textBoxes.clear();
  basementItems.clear();
  potionMakerUIActive = false;
  if (sceneManager.currentScene == "Main Menu")
  {
    textBoxes.add(new Text(new PVector(200, 250), 30, "Start Game", true));
    textBoxes.add(new Text(new PVector(200, 350), 30, "Quit Game", true));
  } else if (sceneManager.currentScene == "Store")
  {
    arrows.add(new Arrow(new PVector(-20, height / 2), "arrowLeft", "Basement"));
    arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Cauldron Room"));
  } else if (sceneManager.currentScene == "Basement")
  {
    arrows.add(new Arrow(new PVector(140, height / 3), "arrowUp", "Cauldron Room"));
    arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Store"));
    basementItems.add(new Item(new PVector(650, 50), "Crimson Fern", "Ingredient"));
    basementItems.add(new Item(new PVector(750, 50), "Bat Ears", "Ingredient"));
    basementItems.add(new Item(new PVector(850, 50), "Devil Shroom", "Ingredient"));
    basementItems.add(new Item(new PVector(950, 50), "Fairy Wings", "Ingredient"));
  } else if (sceneManager.currentScene == "Cauldron Room")
  {
    arrows.add(new Arrow(new PVector(-20, height / 2), "arrowLeft", "Store"));
    arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Basement"));
    cauldron = new Cauldron(new PVector(width / 2 - 150, height / 2), "Cauldron");
  }
}
void mousePressed()
{
  if (!hasBeenClicked && mouseButton == LEFT)
  {
    hasBeenClicked = true;
    handlePotionMaker();
  }
}
void mouseReleased()
{
  hasBeenClicked = false;
  hasChangedScene = false;
  hasClickedTextBox = false;
  isHoldingItem = false;
  handleBasementItemsDragNDrop();
  handlePotionMakerDragNDrop();
  for (int i = 0; i < inventoryItems.length; i++)
  {
    Item item = inventoryItems[i];
    if (item != null)
    {
      item.isBeingHeld = false;
    }
  }
}
void handleBasementItemsDragNDrop()
{
  if (sceneManager.currentScene == "Basement")
  {
    for (int i = basementItems.size() - 1; i >= 0; i--)
    {
      Item item = basementItems.get(i);
      if (item.isBeingHeld && itemsHeld < inventoryPanels.length)
      {
        for (int j = 0; j < inventoryPanels.length; j++)
        {
          InventorySystem panel = inventoryPanels[j];
          boolean withinBox =
            mouseX > panel.position.x &&
            mouseX < panel.position.x + panel.sprite.width &&
            mouseY > panel.position.y &&
            mouseY < panel.position.y + panel.sprite.height;
          if (!inventoryPanels[j].isOccupied && withinBox)
          {
            panel.addItem(new PVector(panel.position.x, panel.position.y), item, j);
            item.currentInventoryPanel = panel;
            break;
          } else
          {
            item.position = item.startingPosition;
          }
        }
      }
      item.isBeingHeld = false;
    }
  }
}
void handlePotionMakerDragNDrop()
{
  if (sceneManager.currentScene == "Cauldron Room")
  {
    for (int i = 0; i < inventoryItems.length; i++)
    {
      Item item = inventoryItems[i];
      if (item != null)
      {
        if (potionMakerUIActive)
        {
          print(1);
          for (int j = 0; j < potionMakerPanels.size(); j++)
          {
            PotionMakerPanel panel = potionMakerPanels.get(j);
            boolean withinBox =
              mouseX > panel.position.x &&
              mouseX < panel.position.x + panel.sprite.width &&
              mouseY > panel.position.y &&
              mouseY < panel.position.y + panel.sprite.height;
            if (item.isBeingHeld && withinBox && cauldron.itemsHeld < 2 && !panel.isOccupied && panel.type == "Ingredient" && item.type == "Ingredient")
            {
              panel.addItem(new PVector(panel.position.x, panel.position.y), item);
              item.currentPotionPanel = panel;
              inventoryItems[i] = null;
              break;
            }
          }
        }
        item.isBeingHeld = false;
      }
    }
  }
}
void handlePotionMaker()
{
  if (sceneManager.currentScene == "Cauldron Room")
  {
    if (!potionMakerUIActive)
    {
      boolean withinCauldronBox =
        mouseX > cauldron.position.x &&
        mouseX < cauldron.position.x + cauldron.sprite.width &&
        mouseY > cauldron.position.y &&
        mouseY < cauldron.position.y + cauldron.sprite.height;
      if (withinCauldronBox)
      {
        potionMakerUIActive = true;
      }
    } else
    {
      for (int i = potionMakerPanels.size() - 1; i >= 0; i--)
      {
        if (potionMakerPanels.get(i).type == "Cross")
        {
          PotionMakerPanel crossButton;
          crossButton = potionMakerPanels.get(i);
          boolean withinCrossBox =
            mouseX > crossButton.position.x &&
            mouseX < crossButton.position.x + crossButton.sprite.width &&
            mouseY > crossButton.position.y &&
            mouseY < crossButton.position.y + crossButton.sprite.height;
          if (withinCrossBox)
          {
            potionMakerUIActive = false;
            break;
          }
        }
      }
    }
  }
}
void spawnPotionMakerUI()
{
  potionMakerUIActive = true;
  potionMakerBackground = new PotionMakerPanel(new PVector(width / 2 - 200, height / 2 - 150), "PotionMakerBackground", "Background");
  potionMakerPanels.add(new PotionMakerPanel(new PVector(potionMakerBackground.position.x + 45, potionMakerBackground.position.y + 20), "Panel", "Ingredient"));
  potionMakerPanels.add(new PotionMakerPanel(new PVector(potionMakerBackground.position.x + 250, potionMakerBackground.position.y + 20), "Panel", "Ingredient"));
  potionMakerPanels.add(new PotionMakerPanel(new PVector(potionMakerBackground.position.x + 150, potionMakerBackground.position.y + 165), "Panel", "Result"));
  potionMakerPanels.add(new PotionMakerPanel(new PVector(potionMakerBackground.position.x + potionMakerBackground.sprite.width - 30, potionMakerBackground.position.y + 10), "Cross", "Cross"));
}
