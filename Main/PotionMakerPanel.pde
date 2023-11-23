class PotionMakerPanel
{
  PVector position;
  PImage sprite;
  String type; //Can be Background, Ingredient, Result, Cross
  boolean isOccupied = false;
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
    cauldronItems.add(item);
    item.position = pPos;
  }
}
