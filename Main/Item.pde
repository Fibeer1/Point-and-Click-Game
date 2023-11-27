class Item
{
  PVector position;
  PVector startingPosition;
  String name; //For ingredients it can be Crimson fern, Bat ears, Devil shroom, Fairy wings
  //For potions it can be Death, Cure, Explosive, Love, Poison, Invisibility, Resurrection
  String type; //Can be Ingredient/Potion
  PImage sprite;
  boolean isBeingHeld = false;
  InventorySystem currentInventoryPanel;
  PotionMakerPanel currentPotionPanel;
  Item(PVector pPos, String pName, String pType)
  {
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
    if (hasBeenClicked && !isHoldingItem)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {
        if (currentInventoryPanel != null)
        {
          currentInventoryPanel.removeItem();
        }
        if (currentPotionPanel != null)
        {
          currentPotionPanel.removeItem();
        }
        isHoldingItem = true;
        isBeingHeld = true;
      }
    }
  }
}
