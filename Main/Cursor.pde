class Cursor
{
  PVector position;
  PImage sprite;
  PImage spriteOff;
  PImage spriteOn;
  Cursor(PVector pPos, String sprite)
  {
    position = pPos;
    spriteOff = loadImage(sprite + "Off" + ".png");
    spriteOn = loadImage(sprite + "On" + ".png");
    spriteOff.resize(30, 41);
    spriteOn.resize(30, 41);
  }
  void update()
  {
    imageMode(CORNER);
    position.x = mouseX;
    position.y = mouseY;
    if (hasBeenClicked)
    {
      image(spriteOn, position.x, position.y);
    }
    else
    {
      image(spriteOff, position.x, position.y);
    }
  }
}
