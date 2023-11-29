class TrashCan
{
  PVector position;
  PImage sprite;
  Item currentItem;
  TrashCan(PVector pPos, String spriteName)
  {
    position = pPos;
    sprite = loadImage(spriteName + ".png");
  }
  void update()
  {
    if (sceneManager.currentScene == "Cauldron Room")
    {
      imageMode(CORNER);
      image(sprite, position.x, position.y);
    }
  }
  void handleItemDrop(Item item)
  {
    if (!isHoldingItem && item != null)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {
        removeItem(item);
      }
    }
  }
  void removeItem(Item item)
  {
    item.currentPanel.removeItem();
    currentlyHeldItem = null;
  }
}
