boolean sketchFullScreen() {
  return true;
}

//GLOBAL VARIABLES
int screenSizeX = 1366;
int screenSizeY = 786;

   
//TEST MENU PARAMETERS! ARE REFERENCED IN MENU CONSTRUCTOR
int menuX = 300;// STD MENU SIZE
int menuY = screenSizeY;
color menuFill = color(200);//Menu BG color


//PIXEL ARRAY AREA PARAMETERS
int bgColor = 100;//PIXEL AREA
//int qtdPixel = 10; //PIXEL QUANTITY
int sPixel = 10; //SIZE OF PIXEL
int pixelPad = 50;// PADDING OF PIXEL AREA (WILL BE EQUAL ON TOP, BOTTOM AND SIDES OF PIXEL ARRAY AREA
int cols = int((screenSizeX-menuX-2*pixelPad)/sPixel); //QTY OF COLS THAT FIT, GIVEN THE PIXEL SIZE
int rows = int((screenSizeY-pixelPad*2)/sPixel);//QTY OF ROWS THAT FIT, GIVEN THE PIXEL SIZE
int pX = int(0.8*screenSizeX)/cols;//X POSITION OF 1ST PIXEL IN ARRAY = COLS*PIXELSIZE
int pY = pixelPad+(screenSizeY/rows);//Y POSITION 1ST PIXEL IN ARRAY = (SCREENSIZE/NUMBER OF ROWS)*PIXELSIZE
int sX = sPixel;//PIXEL SIZE X
int sY = sPixel;//PIXEL SIZE Y
float sF = 0.7; //sF<1 = TENDS TO BLACK, sF>1 = TENDS TO WHITE, sF=1 = CONTRAST++
int nOpt = 0; //INITIAL # OF OPTS

int cR; //RED COMPONENT OF PIXELS
int cG; //GREEN COMPONENT OF PIXELS
int cB; //BLUE COMPONENT OF PIXELS
color zoomC = 128;


int s = second();
int m = minute();
int h = hour();

//VARIABLES FOR INTERFACING MAIN CODE WITH IN-CLASS CODE
Pixel[][] output; //DEFINE PIXEL 2D-ARRAY
Menu mainMenu01; //DEFINE MAIN MENU
Opt[] options; //ARRAY FOR CONTROLLING/UPDATING OPTS IN AUTO MODE
Opt redComponent;
Opt greenComponent;
Opt blueComponent;


///////////////////////////////////////////////////// SETUP
void setup() {
  background(bgColor);
  size(screenSizeX, screenSizeY);
  frameRate(30);

  //DECLARE AN ARRAY OF ITENS THAT HAVE MULTIPLE INSTANCES/COPIES,
  //CONTAINS OBJ OF "PIXEL" CLASS AND HAS cols AMOUNT OF COLUMNS AND rows AMOUNT OF ROWS
  output = new Pixel[cols][rows];


  //INITIALIZE EACH PIXEL  
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {                                                           
      output[i][j] = new Pixel(menuX+pixelPad+i*sX, pixelPad+j*sY, sX, sY, 128, 128, 128, sF);
    }
  }


  //CREATING AND INITIALIZING THE MENU BG
  mainMenu01 = new Menu(menuX, menuY, menuFill); //INITIALIZES SIDE MENU
  mainMenu01.display();//MENU DISPLAY


  //CREATING AND INICIALIZING THE MENU BLOCKS
  redComponent = new Opt("slider", "RED COMPONENT", color(255, 15, 0), 128);
  redComponent.install();
  greenComponent = new Opt("slider", "GREEN COMPONENT", color(15, 255, 0), 128);
  greenComponent.install();
  blueComponent = new Opt("slider", "BLUE COMPONENT", color(0, 30, 255), 128); //OPT CAN BE DECLARED AND INITIALLIZED AT ONCE
  blueComponent.install();
}  

//////// TILE CUTTER
int tileCut = 0;
int cutX = 60;
int cutY = 300;

void mousePressed() {
  if (mouseY>pixelPad && mouseY<height-pixelPad
    && mouseX>menuX+pixelPad && mouseX<width-pixelPad) {
    copy(mouseX, mouseY, 160, 160, cutX, cutY, 32, 32);
    tileCut++;
    if (cutX<menuX-25-32) {
      cutX+=32;
    }else {
      cutX=60;
      cutY+=32;
    }
  }
}


  ///////////////////////////////////////////////////// DRAW
  void draw() {  
    // background(80);

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //output[i][j].scrambleVary();
        //output[i][j].scrambleLine();
        //output[i][j].scramblePoint(); 
        output[i][j].display();
        //output[i][j].debugPixel();
        //output[i][j].bigBang();
        output[i][j].scrambleVary();
      }

      //UPDATES THE SLIDERS
      redComponent.update();
      greenComponent.update();
      blueComponent.update();



      //UPDATES PIXEL COLORS BASED ON SLIDER VALUES
      //cR = int(random(redComponent.sliderValue));
      //cG = int(random(greenComponent.sliderValue));
      //cB = int(random(blueComponent.sliderValue));

      //PIXEL ZOOM ON MOUSE HOVER
     
      zoomC = get(mouseX, mouseY);
      fill(zoomC);
      noStroke();
      rectMode(CENTER);//PIXEL ZOOM MAIN VIEW
      rect(menuX/2, screenSizeY-176, 250, 250);//PIXEL ZOOM - ADD VARIABLES!!!
      //rectMode(CORNER); //OVERLAY FOR LIVE VIEW
      fill(menuFill);
      rect(menuX/2, screenSizeY-176, 180,180);

      //TILE CUTTER LIVE VIEW
      if (mouseY>pixelPad && mouseY<height-pixelPad
        && mouseX>menuX+pixelPad && mouseX<width-pixelPad) {
        cursor(CROSS);
        copy(mouseX, mouseY, 320, 320, menuX/2-64, screenSizeY-176-64, 128, 128); //SHOWS TILE IN 4X ZOOM (FOR 1X1 DIAL MAKE TILE/COPY 32/320PX)
      }


      //MONITORING
      int ml = millis();
      println("pixel size = " + sPixel);  
      println("cols = " + cols);
      println("rows = " + rows);
      println("total pixelx = " + cols*rows);
      println("frame = " + frameCount);
      println("running time = "+ int(ml/1000) +"s");
      println("starting time:" + h + "h:" + m + "m:" + s + "s");
    }
  }

