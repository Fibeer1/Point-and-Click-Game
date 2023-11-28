class Text
{
  PVector position;
  float textSize;
  float textWidth;
  float textHeight;
  float rectWidth;
  String text;
  boolean isButton;
  boolean displayText = true;
  Text(PVector pPos, float pTextSize, String pText, boolean pIsButton)
  {
    position = pPos;
    textSize = pTextSize;
    text = pText;
    isButton = pIsButton;
    calculateTextArea();
  }
  void update()
  {
    if (displayText)
    {
      fill(50);
      rect(position.x, position.y, rectWidth, textHeight, 8);
      fill(255);
      textAlign(LEFT);
      textSize(textSize);
      text(text, position.x + 10, position.y + textSize + 5);
      handleTextInteraction();
    }
  }
  void handleTextInteraction()
  {
    if (!hasClickedTextBox && hasBeenClicked)
    {
      boolean withinBox =
        mouseX > position.x &&
        mouseX < position.x + rectWidth &&
        mouseY > position.y &&
        mouseY < position.y + textHeight;
      if (withinBox)
      {
        hasClickedTextBox = true;
        if (isButton)
        {
          if (text == "Start Game")
          {
            sceneManager.ChangeScene("Store");
            inventoryUIActive = true;
            for (int j = 0; j < inventoryPanels.length; j++)
            {
              if (j == 0)
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 207 + j * 100, height - 100), "PanelRight", "Ingredient", j);
              }
              else if (j == inventoryPanels.length - 1)
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 200 + j * 100, height - 100), "PanelLeft", "Ingredient", j);
              }
              else
              {
                inventoryPanels[j] = new ItemPanel(new PVector(width / 2 - 200 + j * 100, height - 100), "Panel", "Ingredient", j);
              }              
            }
          } else if (text == "Quit Game")
          {
            exit();
          } else
          {
            displayText = false;
          }
        }
      }
    }
  }
  void calculateTextArea() {
    textWidth = textWidth(text);
    textHeight = textSize + 25;
    rectWidth = textWidth + textSize * 3.6f;
  }
}
