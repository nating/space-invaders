class Invader3 {
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
  
  Invader3(float startingPosX, float startingPosY){
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
 
        if(xpos-INVADER1_WIDTH/2-SCREEN_BORDER <= 0){
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
      
        if(xpos+INVADER1_WIDTH/2+SCREEN_BORDER >= SCREENX){
          movingDownwards = true;
        }
        
        if(ypos+INVADER3_HEIGHT/2>=SCREENY-2*MARGIN){
          gameSetup = true;
          bottomHit = true;
        }
      } 
    }
  }
  
  //Draw invader with his specific invader_2 configuration
  void draw() {
    if(killed==false){
      if(timeOfExplosion < 0){
        noStroke();
        fill(255);
        if(frameCount%10<=5){
          rect(xpos-.15*INVADER3_WIDTH,ypos-.45*INVADER3_HEIGHT,.3*INVADER3_WIDTH,.15*INVADER3_HEIGHT);
          rect(xpos-.10*INVADER3_WIDTH,ypos-.50*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
          rect(xpos+.05*INVADER3_WIDTH,ypos-.50*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
          rect(xpos-.25*INVADER3_WIDTH,ypos-.30*INVADER3_HEIGHT,.5*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos-.20*INVADER3_HEIGHT,.3*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.05*INVADER3_WIDTH,ypos-.10*INVADER3_HEIGHT,.1*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos,.30*INVADER3_HEIGHT,.1*INVADER3_HEIGHT);
          rect(xpos-.25*INVADER3_WIDTH,ypos+.10*INVADER3_HEIGHT,.5*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos+.20*INVADER3_HEIGHT,.3*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.2*INVADER3_HEIGHT);
          rect(xpos-.02*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.2*INVADER3_HEIGHT);
          rect(xpos+.10*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.2*INVADER3_HEIGHT);
        }
        else{
          rect(xpos-.15*INVADER3_WIDTH,ypos-.45*INVADER3_HEIGHT,.3*INVADER3_WIDTH,.15*INVADER3_HEIGHT);
          rect(xpos-.20*INVADER3_WIDTH,ypos-.42*INVADER3_HEIGHT,.4*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
          rect(xpos-.25*INVADER3_WIDTH,ypos-.30*INVADER3_HEIGHT,.5*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.35*INVADER3_WIDTH,ypos-.20*INVADER3_HEIGHT,.7*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.45*INVADER3_WIDTH,ypos-.10*INVADER3_HEIGHT,.9*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.35*INVADER3_WIDTH,ypos,.7*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.25*INVADER3_WIDTH,ypos+.10*INVADER3_HEIGHT,.5*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos+.20*INVADER3_HEIGHT,.3*INVADER3_WIDTH,.1*INVADER3_HEIGHT);
          rect(xpos-.15*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
          rect(xpos-.02*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
          rect(xpos+.10*INVADER3_WIDTH,ypos+.30*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
        }
        fill(255,0,0);
        rect(xpos-.10*INVADER3_WIDTH,ypos-.42*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
        rect(xpos+.05*INVADER3_WIDTH,ypos-.42*INVADER3_HEIGHT,.05*INVADER3_WIDTH,.05*INVADER3_HEIGHT);
      }
      else{
        image(invaderImage, xpos-INVADER3_WIDTH/2, ypos-INVADER3_HEIGHT/2);
      }
    }
  }

  //Test to see if a projectile kills the invader. If so, make him explode.
  void explode(Projectile projectile){
    if(projectile.xpos <= xpos+INVADER3_WIDTH/2 && projectile.xpos >= xpos-INVADER3_WIDTH/2 && projectile.ypos >= ypos-INVADER3_HEIGHT/2 && projectile.ypos <= ypos+INVADER3_HEIGHT/2){
    exploded = true;
    invaderDeath.play();
    invaderDeath.rewind();
    invaderImage = explosionImage;
    timeOfExplosion = frameCount;
    if(currentPowerUp!=4){
    projectile.xpos = bulletGraveyard;}
    score+= 50;}
  }
  
  //Get rid of an invader who has just exploded
  void disappear(){
  if(frameCount - timeOfExplosion == EXPLOSION_TIME && frameCount > EXPLOSION_TIME){
      killed = true;
      killCount++;
      xpos = invaderGraveyard;
      ypos = invaderGraveyard;}}
}
