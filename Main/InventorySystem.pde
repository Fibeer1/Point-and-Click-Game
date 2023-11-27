class InventorySystem
{
  PVector position;
  PImage sprite;
  boolean isOccupied = false;
  int currentIndex;
  InventorySystem(PVector pPos, String spriteName)
  {
    position = pPos;
    sprite = loadImage(spriteName + ".png");
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
  }
  void addItem(PVector pPos, Item item, int itemIndex)
  {    
    isOccupied = true;
    itemsHeld++;
    currentIndex = itemIndex;
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
