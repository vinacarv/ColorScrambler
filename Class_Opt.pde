class Opt {

  //VARIABLES 
  int padL = 15; //PADDING LEFT
  int padR = 15; //PADDING RIGHT
  int idBar = 10; //IDENTIFIER COLOR BAR THICKNESS
  int optY = 60; //Y SIZE OF EACH OPT
  color idBarColor; //OPT IDBAR COLOR - DEFAULT = color(255,255,0);
  color optBg = 80; //OPT BG COLOR
  int optSpacer = 4; //SPACER BETWEEN EACH OPT
  int optPosY = pixelPad + nOpt*(optSpacer+optY); // NUMBER OF OPTS * (THEIR HEIGHT + SPACER) = POSY OF THE NEXT OPT
  String type;// = "-"; //TYPE OF OPT (SLIDER, BUTTON, BALANCE)
  String label;// = "-"; //OPT LABEL
  int initialValue ;
  float sliderValue; // VALUE OF THE SLIDER
  Slider optSlider = new Slider();


  ///////////////////////////////////////////INNER CLASSES - OPT TYPES

  class Slider {

    int sliderPosX = idBar+padL; //SLIDER "ZERO" POSITION 
    int sliderPosY = optPosY+optY/3; //SLIDER CENTERED WITHIN THE OPT
    float sliderPosXF;  //POSITION X FINAL = SLIDER VALUE
    int sliderPosYF = sliderPosY+optY/3;
    float sliderPitch = 0.07;

    //SLIDER CONSTRUCTOR
    Slider () {
    }

    //SLIDER FUNCTIONS - HOW TO SLIDE, ETC
    void sliderInstall() {
      sliderValue = initialValue;
      sliderPosXF = sliderPosX+sliderValue;
      noFill();
      stroke(idBarColor); //BAR AND CONTOUR ARE THE SAME COLOR OF IDBAR 
      strokeWeight(1);
      rectMode(CORNERS);
      rect (sliderPosX, sliderPosY, menuX-25, sliderPosYF); //CONTOUR
      fill(idBarColor);
      rect (sliderPosX, sliderPosY, sliderPosXF, sliderPosYF);//FILLED BAR
      rectMode(CORNER);
      fill(180); //LABEL TEXT COLOR
      textAlign(RIGHT, BOTTOM); //LABEL TEXT PLACEMENT
      text(label, menuX-25, optPosY+optY/3-3); //LABEL TEXT PLACEMENT+SIZE
      textAlign(LEFT, BOTTOM); //CURRENT VALUE TEXT PLACEMENT
      text(int(sliderValue), idBar+padL, optPosY+optY/3-3); //CURRENT VALUE TEXT PLACEMENT+SIZE
    }

    void sliderUpdate() {
      if (mousePressed && mouseY>sliderPosY && mouseY<sliderPosYF
        && mouseX>sliderPosX && mouseX<menuX-25 && mouseX>pmouseX) {
        sliderValue = constrain(sliderValue + sliderPitch, 0, 255);
        sliderPosXF = sliderPosX+sliderValue;
      } 
      else if (mousePressed && mouseY>sliderPosY && mouseY<sliderPosYF
        && mouseX>sliderPosX && mouseX<menuX-25 && mouseX<pmouseX) {
        sliderValue = constrain(sliderValue - sliderPitch, 0, 255);
        sliderPosXF = sliderPosX+sliderValue;
      }

      rectMode(CORNERS);
      fill(optBg);//REFRESHING BAR SO IT CAN "ERASE" WHEN CHANGING VALUES
      noStroke();
      rect(sliderPosX, optPosY, sliderPosX+100, sliderPosY);//ERASES CURRENT VALUE FOR UP-TO-DATE REDRAW
      stroke(idBarColor); 
      strokeWeight(1);
      rect (sliderPosX, sliderPosY, menuX-25, sliderPosYF); //REDRAWN BOX = ERASES PREVIOUS BAR VALUE
      fill(180);//TEXT COLOR
      textAlign(LEFT, BOTTOM); //CURRENT VALUE TEXT PLACEMENT
      text(int(sliderValue), idBar+padL, optPosY+optY/3-4); //CURRENT VALUE TEXT PLACEMENT+SIZE
      fill(idBarColor);//FILLED BAR BEING DRAWN WITH REFRESHED VALUE
      rect (sliderPosX, sliderPosY, sliderPosXF, sliderPosYF);


      /* //MONITORING
       println("sliderPosXF = "+sliderPosXF);
       println("sliderValue = "+sliderValue);
       */
    }
  }

  /////////////////////////////////////////////////////////////////////////

  //MAIN OPT CONSTRUCTOR
  Opt(String type_, String label_, color idBarColor_, int initialValue_) {
    type = type_;
    label = label_;
    //sliderColor = sliderColor_;
    idBarColor = idBarColor_;
    initialValue = constrain(initialValue_, 0, 255);
  }

  //FUNCTIONALITY
  void install() {//INSTALLING THE OPT

    rectMode(CORNER);
    fill(optBg);  //BG OPT COLOR
    noStroke();
    if (nOpt == 0) {
      rect(0, optPosY, menuX, optY); //DRAWS FIRST OPT BASE BLOCK
      fill(idBarColor);//IDBAR COLOR 
      rect(0, optPosY, idBar, optY);//IDBAR FIRST POS
    } 
    else if (nOpt >0) {
      rect(0, optPosY, menuX, optY); //DRAWS NEXT OPTS BASE BLOCK
      fill(idBarColor);//IDBAR COLOR    
      rect(0, optPosY, idBar, optY);//IDBAR NEXT POS
    }


    if (type == "slider") {
      optSlider.sliderInstall();
    }

    nOpt++;
  }

  void update() {
    if (type == "slider") {
      optSlider.sliderUpdate();
    }/* else if (type == "button") {
     rect(10, 400, 50, 50);
     }
     */
  }
} //CLOSES CLASS



/*strokeCap(SQUARE);
 stroke(0); //DIVISORY LINE
 strokeWeight(2);
 line(0, optY*nOpt, menuX, optY*nOpt );
 */


/*   switch (type) {  
 case "slider":
 fill(idBarColor);
 stroke(idBarColor);
 strokeWeight(2);
 rect (sliderPosX, sliderPosY, sliderPosXF, sliderY);
 break;
 default:
 fill(0);
 rect (0+3, optY*nOpt+3, mainMenu01.menuX-30, optY-3);
 
 } */
