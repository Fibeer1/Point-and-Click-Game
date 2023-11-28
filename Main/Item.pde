class Item
{
  PVector position;
  PVector startingPosition;
  String name; //For ingredients it can be Crimson fern, Bat ears, Devil shroom, Fairy wings
  //For potions it can be Death, Cure, Explosive, Love, Poison, Invisibility, Resurrection
  String type; //Can be Ingredient/Potion
  PImage sprite;
  int inventorySystemIndex;
  ItemPanel currentPanel;
  boolean isBeingHeld = false;
  Item(PVector pPos, String pName, String pType)
  {
    currentPanel = null;
    position = pPos;
    startingPosition = pPos;
    name = pName;
    type = pType;
    if (type == "Ingredient")
    {
      sprite = loadImage(pName + ".png");
    } else
    {
      sprite = loadImage(pName + "Potion" + ".png");
    }
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
    if (isHoldingItem && isBeingHeld)
    {
      position.x = mouseX - sprite.width / 2;
      position.y = mouseY - sprite.height / 2;
    }
    handleDragNDrop();
  }
  void handleDragNDrop()
  {
    if (hasBeenClicked && !isHoldingItem && currentlyHeldItem == null && !isBookOpen)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {                
        isHoldingItem = true;
        isBeingHeld = true;
        currentlyHeldItem = this;
      }
    }
  }
}
