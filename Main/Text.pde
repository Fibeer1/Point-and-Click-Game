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
    }    
  }
  void calculateTextArea() {
    textWidth = textWidth(text);
    textHeight = textSize + 25;   
    rectWidth = textWidth + textSize * 3.6f;
  }
}
