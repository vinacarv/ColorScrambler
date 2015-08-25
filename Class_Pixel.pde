class Pixel {
  //CLASS VARIABLES
  int posX;
  int posY;
  int sizeX;
  int sizeY;
  //float cR;
  //  float cG;
  //float cB;
  float sF;
  int bb;

  //CONSTRUCTOR
  Pixel(int posX_, int posY_, int sizeX_, int sizeY_, int cR_, int cG_, int cB_, float sF_) {
    posX = posX_;
    posY = posY_;
    sizeX = sizeX_;
    sizeY = sizeY_;
    cR = cR_;
    cG = cG_;
    cB = cB_;
    sF = sF_; //SCRAMBLE FACTOR = RANDOMNESS OF COLOR CHANGE
  }

  //RANDOMIZE THE R, G OR B OF NEXT PIXEL WHEN R, G OR B ARE TOO LOW.
  //ENSURES THAT IT NEVER GOES BLACK OR STOP SCRAMBLING

  //############### VARIABLE LENGTH PIXEL DRAWER    
  void scrambleVary() {
    if (cR<15) {
      cR+=int(random(redComponent.sliderValue));
    } 
    else if (cG<15) {
      cG+=int(random(greenComponent.sliderValue));
    } 
    else if (cB<15) {
      cB+=int(random(blueComponent.sliderValue));
    }  
    else {
      cR*=0.5 + int(random(sF));
      cG*=0.5 + int(random(sF));
      cB*=0.5 + int(random(sF));
    }
  }
    //############### LINE DRAWER
    void scrambleLine() {
      cR =int(random(constrain(redComponent.sliderValue, 0, 255)));
      cG = int(random(constrain(greenComponent.sliderValue, 0, 255)));
      cB = int(random(constrain(blueComponent.sliderValue, 0, 255)));
    }

    //################ POINT DRAWER
    void scramblePoint() {  
      cR = int(random(redComponent.sliderValue));
      cG = int(random(greenComponent.sliderValue));
      cB = int(random(blueComponent.sliderValue)); 
    }

      // MAKES A PIXEL GO WHITE WHEN RANDOM HITS A BINGO
      void bigBang() {
        bb = int(random(200));
        if (bb > 199) {
          cR = 255;
          cG = 255;
          cB = 255;
          println("KABOOOOM");
        }
      }

      void debugPixel() {
        println("cR = " + cR);
        println("cG = " + cG);
        println("cB = " + cB);
      }

      void display() {
          if (frameCount%3 == 1) { //REFRESHES DISPLAY EVERY 10 FRAMES
          noStroke();
          // fill(bgColor);
          //rect(posX, posY, sizeX, sizeY);
          fill(cR, cG, cB);
          rectMode(CENTER);
          rect(posX+sizeX/2, posY+sizeY/2, sizeX, sizeY); //THE ADDITION OF SIZE/2 IS FOR USING RECTMODE = CENTER
        }   

        /* } else if (cR > 100 ){
         noStroke();
         fill(bgColor);
         rect(posX, posY, sizeX, sizeY);
         fill(cR, cG, cB,100);
         rectMode(CENTER);
         rect(posX+sizeX/2, posY+sizeY/2,sizeX, sizeY);
         }*/
      }
    }

