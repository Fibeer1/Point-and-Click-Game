class Cauldron
{
  PVector position;
  PImage sprite;
  int itemsHeld;
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
}
