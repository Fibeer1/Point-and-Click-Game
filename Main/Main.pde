//Interactables
ArrayList<Arrow> arrows = new ArrayList<Arrow>();
ArrayList<Text> textBoxes = new ArrayList<Text>();
ArrayList<Item> basementItems = new ArrayList<Item>();
ItemPanel[] potionMakerPanels = new ItemPanel[3];
Item[] cauldronItems = new Item[3];
Item[] inventoryItems = new Item[4];
ItemPanel[] inventoryPanels = new ItemPanel[4]; //The item count and the panel count should be equal

BookManager bookManager = new BookManager();
SceneManager sceneManager;
PotionMakerButton brewButton;
PotionMakerButton crossButton;
Item currentlyHeldItem;
Cauldron cauldron;
Cursor cursor;

int itemsHeld = 0;

float potionMakerBackgroundX;
float potionMakerBackgroundY;

PImage inventoryBackground;
PImage potionMakerBackground;

boolean hasBeenClicked = false;
boolean hasChangedScene = false;
boolean hasClickedTextBox = false;
boolean isHoldingItem = false;
boolean potionMakerUIActive = false;
boolean inventoryUIActive = false;
boolean isBookOpen = false;

void setup()
{
  size(1280, 720);
  frameRate(60);
  noCursor();
  potionMakerBackgroundX = width / 2 - 200;
  potionMakerBackgroundY = height / 2 - 150;
  cauldron = new Cauldron(new PVector(width / 2 - 150, height / 2), "Cauldron");
  inventoryBackground = loadImage("InventoryBackground.png");
  cursor = new Cursor(new PVector(mouseX, mouseY), "Cursor");
  sceneManager = new SceneManager();
  sceneManager.ChangeScene("Main Menu");
  spawnPotionMakerUI();
  bookManager.SetupBook();
}
void draw()
{
  background(0);
  sceneManager.update(); //This method has to be at the top of draw()
  drawInteractables();
}
void drawInteractables()
{
  if (inventoryUIActive)
  {
    image(inventoryBackground, width / 2 - 55, height - 130);
    for (int i = 0; i < inventoryPanels.length; i++)
    {
      if (inventoryPanels[i] != null)
      {
        inventoryPanels[i].update();
      }
    }
  }
  if (sceneManager.currentScene == "Cauldron Room")
  {
    cauldron.update();
    if (potionMakerUIActive)
    {
      if (potionMakerBackground != null)
      {
        image(potionMakerBackground, potionMakerBackgroundX, potionMakerBackgroundY);
      }      
      for (int i = 0; i < potionMakerPanels.length; i++)
      {
        if (potionMakerPanels[i] != null)
        {
          potionMakerPanels[i].update();
          if (potionMakerPanels[2] != null)
          {
            text(potionMakerPanels[2].currentItem + "", width - 100, height - 100);
          }
        }       
      }
      brewButton.update();
      crossButton.update();
      for (int i = 0; i < cauldronItems.length; i++)
      {
        Item item = cauldronItems[i];
        if (item != null)
        {
          text(item.name, width - 60, 60 + i * 100);
          item.update();
        }
      }
    }
  }
  text(itemsHeld, 110, 500);
  if (cauldron != null)
  {
    text(cauldron.itemsHeld, width - 110, 500);
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
      text(inventoryItems[i].name, 60, 60 + i * 100);
    }
  }
  bookManager.update();
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
  }
}
void mousePressed()
{
  if (!hasBeenClicked && mouseButton == LEFT)
  {
    hasBeenClicked = true;
    bookManager.handleBook();
    handlePotionMaker();
  }
}
void mouseReleased()
{
  hasBeenClicked = false;
  hasChangedScene = false;
  hasClickedTextBox = false;
  isHoldingItem = false;
  handleInventorySystemDragNDrop();
  handleBasementItemsDragNDrop();
  handleItemPanelsDragNDrop();
}
void handleItemPanelsDragNDrop()
{
  for (int i = 0; i < potionMakerPanels.length; i++)
  {
    if (potionMakerPanels[i] != null)
    {
      potionMakerPanels[i].handleItemDrop(currentlyHeldItem);
    }  
  }
  for (int i = 0; i < inventoryPanels.length; i++)
  {
    if (inventoryPanels[i] != null)
    {
      inventoryPanels[i].handleItemDrop(currentlyHeldItem);      
    }  
  }
  currentlyHeldItem = null;
}
void handleInventorySystemDragNDrop()
{
  for (int i = 0; i < inventoryItems.length; i++)
  {
    Item item = inventoryItems[i];
    if (item != null && item.isBeingHeld && itemsHeld < inventoryPanels.length)
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
    }
  }
}
void spawnPotionMakerUI()
{
  potionMakerUIActive = true;
  potionMakerBackground = loadImage("PotionMakerBackground.png");
  potionMakerPanels[0] = new ItemPanel(new PVector(potionMakerBackgroundX + 45, potionMakerBackgroundY + 20), "Panel", "Potion", 0);
  potionMakerPanels[1] = new ItemPanel(new PVector(potionMakerBackgroundX + 250, potionMakerBackgroundY + 20), "Panel", "Potion", 1);
  potionMakerPanels[2] = new ItemPanel(new PVector(potionMakerBackgroundX + 150, potionMakerBackgroundY + 165), "Panel", "Potion", 2);
  crossButton = new PotionMakerButton(new PVector(potionMakerBackgroundX + potionMakerBackground.width - 30, potionMakerBackgroundY + 10), "Cross", "Cross");
  brewButton = new PotionMakerButton(new PVector(potionMakerBackgroundX + 30, potionMakerBackgroundY + 165), "Brew", "Brew");
}
