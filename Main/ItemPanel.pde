class ItemPanel
{
  PVector position;
  PImage sprite;
  boolean isOccupied;
  int currentIndex;
  Item currentItem;
  String type; //Can be Ingredient, Potion or Result
  ItemPanel(PVector pPos, String spriteName, String pType, int pIndex)
  {
    isOccupied = false;
    position = pPos;
    sprite = loadImage(spriteName + ".png");
    type = pType;
    currentIndex = pIndex;
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
  }
  void handleItemDrop(Item item)
  {
    if (!isHoldingItem && item != null)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {
        placeItem(new PVector(position.x, position.y), item);
      }
    }
  }
  void addItem(PVector pPos, Item item)
  {
    isOccupied = true;
    currentlyHeldItem = null;
    currentItem = item;
    currentItem.currentPanel = this;
    currentItem.position = pPos;
    cauldron.itemsHeld++;
    cauldronItems[currentIndex] = currentItem;
  }
  void placeItem(PVector pPos, Item item)
  {
    item.isBeingHeld = false;
    if (isOccupied)
    {
      if (item.currentPanel != null)
      {
        ItemPanel otherItemPanel = item.currentPanel;
        item.position = new PVector(otherItemPanel.position.x, otherItemPanel.position.y);
        currentlyHeldItem = null;
        return;
      } else
      {
        item.position = new PVector(position.x, position.y - 100);
        currentlyHeldItem = null;
        return;
      }
    } else if (item.currentPanel != null && item.currentPanel != this)
    {
      item.currentPanel.removeItem();
    }
    isOccupied = true;
    currentlyHeldItem = null;
    currentItem = item;
    currentItem.currentPanel = this;
    currentItem.position = pPos;
    if (type == "Ingredient")
    {
      itemsHeld++;
      inventoryItems[currentIndex] = currentItem;
      currentItem.inventorySystemIndex = currentIndex;
    } else if (type == "Potion")
    {
      cauldron.itemsHeld++;
      inventoryItems[currentItem.inventorySystemIndex] = null;
      cauldronItems[currentIndex] = currentItem;
    }
  }
  void removeItem()
  {
    isOccupied = false;
    currentItem = null;
    if (type == "Ingredient")
    {
      if (itemsHeld > 0)
      {
        itemsHeld--;
      }
      inventoryItems[currentIndex] = null;
    } else if (type == "Potion")
    {
      if (cauldron.itemsHeld > 0)
      {
        cauldron.itemsHeld--;
      }
      cauldronItems[currentIndex] = null;
    }
  }
}
