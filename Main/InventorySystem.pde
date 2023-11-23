class InventorySystem
{
  PVector position;
  PImage sprite;
  boolean isOccupied = false;
  
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
    inventoryItems[itemIndex] = item;
    item.position = pPos;
  }
  
}
