class InventorySystem
{
  PVector position;
  PImage sprite;
  boolean isOccupied = false;
  int currentIndex;
  InventorySystem(PVector pPos, String spriteName, int pIndex)
  {
    position = pPos;
    sprite = loadImage(spriteName + ".png");
    currentIndex = pIndex;
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
    handleItemDrop();
  }
  void handleItemDrop()
  {
    if (!isOccupied && !isHoldingItem && currentlyHeldItem != null)
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
    currentlyHeldItem.inventorySystemIndex = currentIndex;
    /*if (currentlyHeldItem.currentInventoryPanel != null)
    {
      currentlyHeldItem.currentInventoryPanel.removeItem();
    } else if (currentlyHeldItem.currentPotionPanel != null)
    {
      currentlyHeldItem.currentPotionPanel.removeItem();
    }
    currentlyHeldItem.currentInventoryPanel = this;
    currentlyHeldItem.currentPotionPanel = null;*/
    currentlyHeldItem = null;
  }
  void addItem(PVector pPos, Item item)
  {
    isOccupied = true;
    itemsHeld++;
    inventoryItems[currentIndex] = item;
    item.position = pPos;
  }
  void removeItem()
  {
    isOccupied = false;
    itemsHeld--;
    inventoryItems[currentIndex] = null;
  }
}
