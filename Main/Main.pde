//Interactables
ArrayList<Arrow> arrows = new ArrayList<Arrow>();
ArrayList<Text> textBoxes = new ArrayList<Text>();
ArrayList<Item> items = new ArrayList<Item>();
ArrayList<Item> cauldronItems = new ArrayList<Item>();
Item[] inventoryItems = new Item[4];

PotionMaker potionMaker;
InventorySystem inventorySystem;
SceneManager sceneManager;
Cauldron cauldron;

boolean hasBeenClicked = false;

void setup()
{
  size(1280, 720);
  frameRate(60);
  potionMaker = new PotionMaker();
  sceneManager = new SceneManager();
  sceneManager.ChangeScene("Main Menu");
}
void draw()
{
  background(0);
  sceneManager.update(); //This method has to be at the top of draw()
  drawInteractables();
  fill(255);
  for (int i = 0; i < inventoryItems.length; i++)
  {
    if (inventoryItems[i] != null)
    {
      text(inventoryItems[i].name + " - " + i, 100, i * 100);
    }    
  }  
}
void drawInteractables()
{
  if (inventorySystem != null)
  {
    inventorySystem.update();
  }
  for (int i = arrows.size() - 1; i >= 0; i--)
  {
    arrows.get(i).update();
  }
  for (int i = textBoxes.size() - 1; i >= 0; i--)
  {
    textBoxes.get(i).update();
  }
  for (int i = items.size() - 1; i >= 0; i--)
  {
    items.get(i).update();
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
    for (int i = cauldronItems.size() - 1; i >= 0; i--)
    {
      cauldronItems.get(i).update();
    }   
  }
}
void spawnInteractables()
{
  shapeMode(CENTER);
  arrows.clear();
  textBoxes.clear();
  items.clear();
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
    items.add(new Item(new PVector(650, 50), "Crimson Fern", "Ingredient"));
    items.add(new Item(new PVector(750, 50), "Bat Ears", "Ingredient"));
    items.add(new Item(new PVector(850, 50), "Devil Shroom", "Ingredient"));
    items.add(new Item(new PVector(950, 50), "Fairy Wings", "Ingredient"));
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
    for (int i = arrows.size() - 1; i >= 0; i--)
    {
      float distance = dist(arrows.get(i).position.x, arrows.get(i).position.y, mouseX, mouseY);
      if (distance <= arrows.get(i).sprite.width && distance <= arrows.get(i).sprite.height)
      {
        sceneManager.ChangeScene(arrows.get(i).sceneToGo);
        break;
      }
    }
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
            inventorySystem = new InventorySystem(new PVector(width / 2 - 200, height - 100), "Inventory");
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
    for (int i = items.size() - 1; i >= 0; i--)
    {
      Item item = items.get(i);
      boolean withinBox =
        mouseX > item.position.x &&
        mouseX < item.position.x + item.sprite.width &&
        mouseY > item.position.y &&
        mouseY < item.position.y + item.sprite.height;
      if (withinBox && inventorySystem.itemsHeld < 4)
      {
        int itemIndex = 0;
        for (int j = 0; j < inventoryItems.length; j++)
        {
          if (inventoryItems[j] == null)
          {
            itemIndex = j;
            break;
          }
        }
        inventorySystem.addItem(new PVector(inventorySystem.position.x, inventorySystem.position.y), item, itemIndex);
        break;
      }
    }
    if (sceneManager.currentScene == "Cauldron Room")
    {
      for (int i = 0; i < inventoryItems.length; i++)
    {
      if (inventoryItems[i] != null)
      {
        Item item = inventoryItems[i];
      boolean withinBox =
        mouseX > item.position.x &&
        mouseX < item.position.x + item.sprite.width &&
        mouseY > item.position.y &&
        mouseY < item.position.y + item.sprite.height;
      if (withinBox && cauldron.itemsHeld < 2)
      {
        cauldron.addItem(new PVector(cauldron.position.x, cauldron.position.y + 50), item);
        inventoryItems[i] = null;
        inventorySystem.itemsHeld--;
        inventorySystem.itemPosMultiplier -= 5;
        break;
      }
      }     
    }
    }
    
  }
}
void mouseReleased()
{
  hasBeenClicked = false;
}
