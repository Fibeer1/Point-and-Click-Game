class PotionMakerPanel
{
  PVector position;
  PImage sprite;
  String type; //Can be Background, Ingredient, Result, Cross
  boolean isOccupied = false;
  int currentIndex;
  PotionMakerPanel(PVector pPos, String spriteName, String pType)
  {
    position = pPos;
    type = pType;
    sprite = loadImage(spriteName + ".png");
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
  }
  void addItem(PVector pPos, Item item)
  {    
    isOccupied = true;
    currentIndex = cauldron.itemsHeld;
    cauldron.itemsHeld++;
    cauldronItems[currentIndex] = item;
    item.position = pPos;
  }
  void removeItem()
  {
    isOccupied = false;
    currentIndex = itemsHeld--;
    cauldronItems[currentIndex] = null;
    itemsHeld--;
  }
}
