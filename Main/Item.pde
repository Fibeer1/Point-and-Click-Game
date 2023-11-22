class Item
{
  PVector position;
  String name; //Can be Crimson fern, Bat ears, Devil shroom, Fairy wings
  String type; //Can be Ingredient/Potion
  PImage sprite;
  Item(PVector pPos, String pName, String pType)
  {
    position = pPos;
    name = pName;
    type = pType;
    sprite = loadImage(pName + ".png");
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
  }
}
