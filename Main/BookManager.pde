class BookManager
{
  PImage [] tab1= new PImage[7];
  PImage [] tab2= new PImage[4];
  PImage [] tab3= new PImage[7];
  int currentTab = 1;
  int currentPage = 1;
  int maxPage;
  int [] x = new int[6];
  int [] y = new int[6];
  int [] buttonWidth = new int[6];
  int [] buttonHeight = new int[6];
  PImage bookButton;
  PImage tab1Button;
  PImage tab2Button;
  PImage tab3Button;
  PImage nextButton;
  PImage pevButton;

  //Courtesy of Johnny
  public void SetupBook()
  {
    for (int i=0; i< tab1.length; i++)
    {
      tab1[i]= loadImage("Page"+i+".png");
    }
    
    for (int i=0; i< tab2.length; i++)
    {
      tab2[i]= loadImage("Page1"+i+".png");
    }
    
    for (int i=0; i< tab3.length; i++)
    {
      tab3[i]= loadImage("Page2"+i+".png");
    }

    bookButton = loadImage("book.png");
    x[0] = 0;
    y[0] = 0;
    buttonWidth[0] = 150;
    buttonHeight[0] = 150;
    
    tab1Button = loadImage("tab1.png");
    x[1] = 95;
    y[1] = 135;
    buttonWidth[1] = 136;
    buttonHeight[1] = 76;
    
    tab2Button = loadImage("tab2.png");
    x[2] = 95;
    y[2] = 235;
    buttonWidth[2] = 136;
    buttonHeight[2] = 76;
    
    tab3Button = loadImage("tab3.png");
    x[3] = 95;
    y[3] = 335;
    buttonWidth[3] = 136;
    buttonHeight[3] = 76;
    
    nextButton = loadImage("nextPage.png");
    x[4] = 1140;
    y[4] = 300;
    buttonWidth[4] = 150;
    buttonHeight[4] = 150;
    
    pevButton = loadImage("pevPage.png");
    x[5] = 0;
    y[5] = 300;
    buttonWidth[5] = 150;
    buttonHeight[5] = 150;
    
  }

  public void update()
  {
    if (sceneManager.currentScene != "Main Menu")
    {
      image(bookButton, x[0], y[0], buttonWidth[0], buttonHeight[0]);
    }    
    
    if (isBookOpen == true)
    {
      if (currentTab == 1)
      {
        maxPage = tab1.length;
        image(tab1[currentPage -1], 0, 0);
      } 
      else if (currentTab == 2)
      {
        maxPage = tab2.length;
        image(tab2[currentPage -1], 0, 0);
      } 
      else if (currentTab == 3)
      {
        maxPage = tab3.length;
        image(tab3[currentPage -1], 0, 0);
      }
      image(tab1Button, x[1], y[1], buttonWidth[1], buttonHeight[1]);
      image(tab2Button, x[2], y[2], buttonWidth[2], buttonHeight[2]);
      image(tab3Button, x[3], y[3], buttonWidth[3], buttonHeight[3]);
      image(nextButton, x[4], y[4], buttonWidth[4], buttonHeight[4]);
      image(pevButton, x[5], y[5], buttonWidth[5], buttonHeight[5]);
    }
  }

  public void openBook()
  {
    if (isBookOpen == false)
    {
      isBookOpen = true;
    } else if (isBookOpen == true)
    {
      isBookOpen = false;
    }
  }

  public void tabSelect(String nextTab)
  {
    if (nextTab == "tab1")
    {
      currentPage = 1;
      currentTab = 1;
    } else if (nextTab == "tab2")
    {
      currentPage = 1;
      currentTab = 2;
    } else if (nextTab == "tab3")
    {
      currentPage = 1;
      currentTab = 3;
    }
  }

  public void nextPage()
  {
    if (currentPage == maxPage)
    {
      currentPage = 1;
    } 
    else
    {
      currentPage++;
    }
  }

  public void pevPage()
  {
    if (currentPage == 1)
    {
      currentPage = maxPage;
    } 
    else 
    {
      currentPage--;
    }
  }

  public void handleBook()
  {
    if (mouseX >= x[0] && mouseX <= x[0] + buttonWidth[0] &&
      mouseY >= y[0] && mouseY <= y[0] + buttonHeight[0])
    {
      openBook();
    } 
    else if (mouseX >= x[1] && mouseX <= x[1] + buttonWidth[1] &&
      mouseY >= y[1] && mouseY <= y[1] + buttonHeight[1])
    {
      tabSelect("tab1");
    } 
    else if (mouseX >= x[2] && mouseX <= x[2] + buttonWidth[2] &&
      mouseY >= y[2] && mouseY <= y[2] + buttonHeight[2])
    {
      tabSelect("tab2");
    } 
    else if (mouseX >= x[3] && mouseX <= x[3] + buttonWidth[3] &&
      mouseY >= y[3] && mouseY <= y[3] + buttonHeight[3])
    {
      tabSelect("tab3");
    } 
    else if (mouseX >= x[4] && mouseX <= x[4] + buttonWidth[4] &&
      mouseY >= y[4] && mouseY <= y[4] + buttonHeight[4])
    {
      nextPage();
    } 
    else if (mouseX >= x[5] && mouseX <= x[5] + buttonWidth[5] &&
      mouseY >= y[5] && mouseY <= y[5] + buttonHeight[5])
    {
      pevPage();
    }
  }
}
