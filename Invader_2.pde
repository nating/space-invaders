class Invader2 {
  float xpos; float ypos;
  color invaderColor = color(255);
  float speed; float lastPosition;
  PImage invaderImage;
  PImage explosionImage;
  int bounce;
  int timeOfExplosion;
  boolean killed;
  int SPACES_TO_BE_MOVED_DOWN;
  int spacesMovedDown;
  float dx;
  float dy;
  int spacesMoved;
  float  SPACES_TO_BE_MOVED_VERTICALLY;
  boolean exploded;
  
  Invader2(float startingPosX, float startingPosY){
    xpos = startingPosX;
    ypos = startingPosY;
    invaderImage= loadImage("invader.GIF");
    explosionImage= loadImage("exploding.GIF");
    bounce = 2;
    SPACES_TO_BE_MOVED_DOWN = INVADER1_HEIGHT/2;
    spacesMovedDown = 0;
    dx = 2;
    dy = 2;
    timeOfExplosion =-1;
    spacesMoved = 0;
    exploded = false;
  }
  
  //Move the space invader
  void move(){
    if(killed == false){
      if(exploded == false){

        if(xpos-INVADER2_WIDTH/2-SCREEN_BORDER <= 0){
          movingDownwards = true;
        }
      
        if(spacesMovedDown >= SPACES_TO_BE_MOVED_DOWN){
          movingDownwards = false;
          spacesMovedDown = 0;
          dx = -dx;
          xpos += dx;
        }
      
        if(movingDownwards == true){
          spacesMovedDown++;
          ypos += dy;
        }
        else{
          xpos += dx;
        }
      
        if(xpos+INVADER2_WIDTH/2+SCREEN_BORDER >= SCREENX){
          movingDownwards = true;
        }
        
        if(ypos+INVADER2_HEIGHT/2>=SCREENY-2*MARGIN){
          gameSetup = true;
          bottomHit = true;
        }
      } 
    }
  }

  //Method for invaders to dance on the Main Menu
  void dance(){
    ypos++;
    if(ypos>=SCREENY+INVADER2_HEIGHT/2){
      ypos = 0 - INVADER2_HEIGHT/2;}
  }
  
  //Draw invader with his specific invader_2 configuration
  void draw() {
    if(killed==false){
      if(timeOfExplosion < 0){
       fill(255);
       noStroke();
       
       rect(xpos-0.344*INVADER2_WIDTH,ypos,0.729*INVADER2_WIDTH,0.5833*INVADER2_HEIGHT);
       rect(xpos-0.3958*INVADER2_WIDTH,ypos+0.2166*INVADER2_HEIGHT,0.833*INVADER2_WIDTH,0.25*INVADER2_HEIGHT);
       rect(xpos-0.2396*INVADER2_WIDTH,ypos-0.0833*INVADER2_HEIGHT,0.5208*INVADER2_WIDTH,0.2166*INVADER2_HEIGHT);
      
       rect(xpos-0.135*INVADER2_WIDTH,ypos-0.166*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       rect(xpos+0.073*INVADER2_WIDTH,ypos-0.166*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       rect(xpos-0.2396*INVADER2_WIDTH,ypos-0.25*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       rect(xpos+0.177*INVADER2_WIDTH,ypos-0.25*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       
       rect(xpos-0.1875*INVADER2_WIDTH,ypos+0.5833*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       rect(xpos+0.125*INVADER2_WIDTH,ypos+0.5833*INVADER2_HEIGHT,0.1042*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       
       if(frameCount%10 <= 5){
         rect(xpos-0.4792*INVADER2_WIDTH,ypos-0.0833*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.4166*INVADER2_HEIGHT);
         rect(xpos+0.4375*INVADER2_WIDTH,ypos-0.0833*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.4166*INVADER2_HEIGHT);
         rect(xpos-0.271*INVADER2_WIDTH,ypos+0.6666*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
         rect(xpos+0.229*INVADER2_WIDTH,ypos+0.6666*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       }
       else{
         rect(xpos-0.4792*INVADER2_WIDTH,ypos+0.25*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.4166*INVADER2_HEIGHT);
         rect(xpos+0.4375*INVADER2_WIDTH,ypos+0.25*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.4166*INVADER2_HEIGHT);
         rect(xpos-0.0833*INVADER2_WIDTH,ypos+0.6666*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
         rect(xpos+0.0417*INVADER2_WIDTH,ypos+0.6666*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.0833*INVADER2_HEIGHT);
       }
       fill(255,0,0);
       rect(xpos-0.2396*INVADER2_WIDTH,ypos+0.166*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.1333*INVADER2_HEIGHT);
       rect(xpos+0.198*INVADER2_WIDTH,ypos+0.166*INVADER2_HEIGHT,0.0833*INVADER2_WIDTH,0.1333*INVADER2_HEIGHT);  
      }
      else{
        image(invaderImage, xpos-INVADER2_WIDTH/2, ypos-INVADER2_HEIGHT/2);
      }
    }
  }

  //Test to see if a projectile kills the invader. If so, make him explode.
  void explode(Projectile projectile){
    if(projectile.xpos <= xpos+INVADER1_WIDTH/2 && projectile.xpos >= xpos-INVADER1_WIDTH/2 && projectile.ypos >= ypos-INVADER1_HEIGHT/2 && projectile.ypos <= ypos+INVADER1_HEIGHT/2){
      exploded = true;
      invaderDeath.play();
      invaderDeath.rewind();
      invaderImage = explosionImage;
      timeOfExplosion = frameCount;
      if(currentPowerUp!=4){
        projectile.xpos = bulletGraveyard;
      }
      score+= 40;
    }
  }
  
  //Get rid of an invader who has just exploded
  void disappear(){
  if(frameCount - timeOfExplosion == EXPLOSION_TIME && frameCount > EXPLOSION_TIME){
      killed = true;
      killCount++;
      xpos = invaderGraveyard;
      ypos = invaderGraveyard;}}
}
