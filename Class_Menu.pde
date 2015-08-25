class Menu {  
  //int menuX = 300;
  //int menuY;
  //color menuFill;

  //CONSTRUCTOR - ENTER NEW VALUES TO OVERRIDE
  Menu(int menuX_, int menuY_, color menuFill_) {
    menuX = menuX_;
    menuY = menuY_;
    menuFill = menuFill_;
  }

  void display() {
    noStroke();
    fill(menuFill);
    rect(0, 0, menuX, menuY);
  }
}

