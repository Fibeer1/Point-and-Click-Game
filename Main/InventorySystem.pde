class InventorySystem
{
  PVector position;
  PImage sprite;
  int itemsHeld;
  float itemPosMultiplier;
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
    if (itemsHeld != 1)
    {
      itemPosMultiplier += 5;
    }    
    inventoryItems[itemIndex] = item;
    item.position = pPos;
    item.position.x = pPos.x + itemIndex * 100 + itemPosMultiplier;
    itemsHeld++;    
  }
}
