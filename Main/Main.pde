//Interactables
ArrayList<Arrow> arrows = new ArrayList<Arrow>();
ArrayList<Text> textBoxes = new ArrayList<Text>();
ArrayList<Item> basementItems = new ArrayList<Item>();
ArrayList<Item> cauldronItems = new ArrayList<Item>();
ArrayList<PotionMakerPanel> potionMakerPanels = new ArrayList<PotionMakerPanel>();
Item[] inventoryItems = new Item[7];
InventorySystem[] inventoryPanels = new InventorySystem[7]; //The item count and the panel count should be equal

SceneManager sceneManager;
PotionMakerPanel potionMakerBackground;
Cauldron cauldron;

int itemsHeld = 0;

boolean hasBeenClicked = false;
boolean potionMakerUIActive = false;

void setup()
{
  size(1280, 720);
  frameRate(60);
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
      for (int i = cauldronItems.size() - 1; i >= 0; i--)
    {
      cauldronItems.get(i).update();
    }
    }   
  }
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
    arrows.add(new Arrow(new PVector(10, height / 2), "arrowLeft", "Basement"));
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
    arrows.add(new Arrow(new PVector(10, height / 2), "arrowLeft", "Store"));
    arrows.add(new Arrow(new PVector(width - 80, height / 2), "arrowRight", "Basement"));
    cauldron = new Cauldron(new PVector(width / 2 - 150, height / 2), "Cauldron");
  }
}
void mousePressed()
{
  if (!hasBeenClicked && mouseButton == LEFT)
  {
    hasBeenClicked = true;
    handleArrowInteraction();
    handleTextboxInteraction();
    handleBasementItems();
    handlePotionMaker();
  }
}
void mouseReleased()
{
  hasBeenClicked = false;
}
void handleArrowInteraction()
{
  for (int i = arrows.size() - 1; i >= 0; i--)
  {
    Arrow arrow = arrows.get(i);
    boolean withinBox =
      mouseX > arrow.position.x &&
      mouseX < arrow.position.x + arrow.sprite.width &&
      mouseY > arrow.position.y &&
      mouseY < arrow.position.y + arrow.sprite.height;
    if (withinBox)
    {
      sceneManager.ChangeScene(arrow.sceneToGo);
      break;
    }
  }
}
void handleTextboxInteraction()
{
  for (int i = textBoxes.size() - 1; i >= 0; i--)
  {
    Text textBox = textBoxes.get(i);
    boolean withinBox =
      mouseX > textBox.position.x &&
      mouseX < textBox.position.x + textBox.rectWidth &&
      mouseY > textBox.position.y &&
      mouseY < textBox.position.y + textBox.textHeight;
    if (withinBox)
    {
      if (textBox.isButton)
      {
        if (textBox.text == "Start Game")
        {
          sceneManager.ChangeScene("Store");
          for (int j = 0; j < inventoryPanels.length; j++)
          {
            inventoryPanels[j] = new InventorySystem(new PVector(width / 2 - 350 + j * 100, height - 100), "Panel");
          }
        } else if (textBox.text == "Quit Game")
        {
          exit();
        } else
        {
          textBox.displayText = false;
        }
      }
      break;
    }
  }
}
void handleBasementItems()
{
  for (int i = basementItems.size() - 1; i >= 0; i--)
  {
    Item item = basementItems.get(i);
    boolean withinBox =
      mouseX > item.position.x &&
      mouseX < item.position.x + item.sprite.width &&
      mouseY > item.position.y &&
      mouseY < item.position.y + item.sprite.height;
    if (itemsHeld < inventoryPanels.length && withinBox)
    {
      for (int j = 0; j < inventoryPanels.length; j++)
      {
        if (!inventoryPanels[j].isOccupied)
        {
          inventoryPanels[j].addItem(new PVector(inventoryPanels[j].position.x, inventoryPanels[j].position.y), item, j);
          break;
        }
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
      for (int i = 0; i < inventoryItems.length; i++)
      {
        if (inventoryItems[i] != null)
        {
          Item item = inventoryItems[i];
          boolean withinItemBox =
            mouseX > item.position.x &&
            mouseX < item.position.x + item.sprite.width &&
            mouseY > item.position.y &&
            mouseY < item.position.y + item.sprite.height;
          if (withinItemBox && cauldron.itemsHeld < 2)
          {
            for (int j = 0; j <= potionMakerPanels.size() - 1; j++)
            {
              PotionMakerPanel panel = potionMakerPanels.get(j);
              if (panel.type == "Ingredient" && !panel.isOccupied)
              {               
                panel.addItem(new PVector(panel.position.x, panel.position.y), item);
                panel.isOccupied = true;
                inventoryItems[i] = null;
                inventoryPanels[i].isOccupied = false;
                itemsHeld--;
                break;
              }
            }            
            break;
          }
        }
      }
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
