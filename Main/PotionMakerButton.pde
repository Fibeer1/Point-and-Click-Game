class PotionMakerButton
{
  PVector position;
  PImage sprite;
  String type; //Cross or Brew

  ItemPanel resultPanel;
  PotionMakerButton(PVector pPos, String spriteName, String pType)
  {
    resultPanel = potionMakerPanels[2];
    position = pPos;
    type = pType;
    sprite = loadImage(spriteName + ".png");
  }
  void update()
  {
    imageMode(CORNER);
    image(sprite, position.x, position.y);
    handleInput();
  }
  void handleInput()
  {
    if (hasBeenClicked && !isHoldingItem && !isBookOpen)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + sprite.width &&
        mouseY > position.y &&
        mouseY < position.y + sprite.height;
      if (withinBox)
      {
        if (type == "Cross")
        {
          potionMakerUIActive = false;
        } else if (type == "Brew" && !resultPanel.isOccupied && cauldron.itemsHeld == 2)
        {
          Item item1 = cauldronItems[0];
          Item item2 = cauldronItems[1];
          ItemPanel item1Panel = item1.currentPanel;          
          ItemPanel item2Panel = item2.currentPanel;
          if (item1.type == "Potion" || item2.type == "Potion")
          {
            return;
          }
          String potionName = "";
          if (item1.name == item2.name)
          {
            potionName = "Death";
          }
          else if (item1.name == "Crimson Fern" && item2.name == "Bat Ears" || item1.name == "Bat Ears" && item2.name == "Crimson Fern")
          {
            potionName = "Cure";
          }
          else if (item1.name == "Crimson Fern" && item2.name == "Devil Shroom" || item1.name == "Devil Shroom" && item2.name == "Crimson Fern")
          {
            potionName = "Explosive";
          }
          else if (item1.name == "Crimson Fern" && item2.name == "Fairy Wings" || item1.name == "Fairy Wings" && item2.name == "Crimson Fern")
          {
            potionName = "Love";
          }
          else if (item1.name == "Bat Ears" && item2.name == "Devil Shroom" || item1.name == "Devil Shroom" && item2.name == "Bat Ears")
          {
            potionName = "Poison";
          }
          else if (item1.name == "Bat Ears" && item2.name == "Fairy Wings" || item1.name == "Fairy Wings" && item2.name == "Bat Ears")
          {
            potionName = "Invisibility";
          }
          else if (item1.name == "Fairy Wings" && item2.name == "Devil Shroom" || item1.name == "Devil Shroom" && item2.name == "Fairy Wings")
          {
            potionName = "Resurrection";
          }
          item1Panel.removeItem();
          item2Panel.removeItem();
          cauldronItems[0] = null;
          cauldronItems[1] = null;
          cauldron.itemsHeld = 0;
          Item potion = new Item(new PVector(resultPanel.position.x, resultPanel.position.y), potionName, "Potion");
          resultPanel.addItem(new PVector(resultPanel.position.x, resultPanel.position.y), potion);
        }
      }
    }
  }
}
