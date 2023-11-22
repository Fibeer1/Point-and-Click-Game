class Cauldron
{
  PVector position;
  PImage sprite;
  int itemsHeld;
  float itemPosMultiplier;
  Cauldron(PVector pPos, String spriteName)
  {
    position = pPos;
    sprite = loadImage(spriteName + ".png");
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
  }
  void addItem(PVector pPos, Item item)
  {    
    cauldronItems.add(item);
    item.position = pPos;
    item.position.x = pPos.x + itemsHeld * 100 + itemPosMultiplier;
    itemsHeld++;    
  }
}
