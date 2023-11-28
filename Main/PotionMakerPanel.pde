class PotionMakerPanel
{
  PVector position;
  PImage sprite;
  String type; //Can be Background, Ingredient, Result, Cross, Brew
  boolean isOccupied = false;
  int currentIndex;
  PotionMakerPanel(PVector pPos, String spriteName, String pType, int pIndex)
  {
    position = pPos;
    type = pType;
    sprite = loadImage(spriteName + ".png");
    if (type == "Ingredient")
    {
      currentIndex = pIndex;
    }
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
    handleItemDrop();
  }
  void handleItemDrop()
  {
    if (!isOccupied && type == "Ingredient" && !isHoldingItem && currentlyHeldItem != null)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {
        handleItemParameters();
      }
      else 
      {
        currentlyHeldItem = null;
      }
    }
  }
  void handleItemParameters()
  {
    addItem(new PVector(position.x, position.y), currentlyHeldItem);
    inventoryItems[currentlyHeldItem.inventorySystemIndex] = null;
    /*if (currentlyHeldItem.currentInventoryPanel != null)
    {
      currentlyHeldItem.currentInventoryPanel.removeItem();
    } else if (currentlyHeldItem.currentPotionPanel != null)
    {
      currentlyHeldItem.currentPotionPanel.removeItem();
    }
    currentlyHeldItem.currentPotionPanel = this;
    currentlyHeldItem.currentInventoryPanel = null;*/
    currentlyHeldItem = null;
  }
  void addItem(PVector pPos, Item item)
  {
    isOccupied = true;
    cauldron.itemsHeld++;
    cauldronItems[currentIndex] = item;
    item.position = pPos;
  }
  void removeItem()
  {
    isOccupied = false;
    cauldron.itemsHeld--;
    cauldronItems[currentIndex] = null;
  }
}
