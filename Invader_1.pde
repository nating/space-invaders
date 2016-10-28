class Invader1 {
  float xpos; float ypos;
  color invaderColor = color(255,255,255);
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
  boolean exploded;
  
  Invader1(float startingPosX, float startingPosY){
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
    exploded = false;
  }
  
  //Move the space invader
  void move(){
    if(exploded == false){
      if(xpos-INVADER1_WIDTH/2-SCREEN_BORDER <= 0){
        movingDownwards = true;}
        
      if(spacesMovedDown >= SPACES_TO_BE_MOVED_DOWN){
        movingDownwards = false;
        spacesMovedDown = 0;
        dx = -dx;
        xpos += dx;}
      
      if(movingDownwards == true){
        spacesMovedDown++;
        ypos += dy;
        if(frameCount%10==0){
          ypos += bounce;
          bounce = - bounce;}
      }
    
      else{
        xpos += dx;
        if(frameCount%10==0){
          ypos += bounce;
          bounce = - bounce;}
      }
      
      if(xpos+INVADER1_WIDTH/2+SCREEN_BORDER >= SCREENX){
        movingDownwards = true;}
        
      if(ypos+INVADER1_HEIGHT/2>=SCREENY-2*MARGIN){
        gameSetup = true;
        bottomHit = true;}
    } 
  }
  
  //Method for invaders to dance on the Main Menu
  void dance(){
    ypos++;
    if(ypos>=SCREENY+INVADER1_HEIGHT/2){
      ypos = 0 - INVADER1_HEIGHT/2;
    }
  }
     
  //Draw invader with his specific invader_1 configuration
  void draw() {
    if(killed==false){
     if(timeOfExplosion < 0){
       fill(invaderColor);
       noStroke();
       rect(xpos-.5*INVADER1_WIDTH,ypos-.1*INVADER1_HEIGHT,1*INVADER1_WIDTH,.2*INVADER1_HEIGHT);
       rect(xpos-.4*INVADER1_WIDTH,ypos-.2*INVADER1_HEIGHT,.8*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos-.3*INVADER1_WIDTH,ypos-.3*INVADER1_HEIGHT,.6*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos-.2*INVADER1_WIDTH,ypos-.4*INVADER1_HEIGHT,.4*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos-.1*INVADER1_WIDTH,ypos-.5*INVADER1_HEIGHT,.2*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       fill(255,0,0);
       rect(xpos-.2*INVADER1_WIDTH,ypos-.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos+.1*INVADER1_WIDTH,ypos-.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       fill(invaderColor);
       if(frameCount%10 <= 5){
       rect(xpos-.3*INVADER1_WIDTH,ypos+.1*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos+.15*INVADER1_WIDTH,ypos+.1*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
     
       rect(xpos-.4*INVADER1_WIDTH,ypos+.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos-.15*INVADER1_WIDTH,ypos+.2*INVADER1_HEIGHT,.3*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
       rect(xpos+.3*INVADER1_WIDTH,ypos+.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
   
       rect(xpos-.5*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.2*INVADER1_HEIGHT);
       rect(xpos-.3*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.2*INVADER1_HEIGHT);
       rect(xpos+.15*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.2*INVADER1_HEIGHT);
       rect(xpos+.4*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.2*INVADER1_HEIGHT);}
   else{
     rect(xpos-.4*INVADER1_WIDTH,ypos+.1*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
     rect(xpos-.15*INVADER1_WIDTH,ypos+.1*INVADER1_HEIGHT,.3*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
     rect(xpos+.25*INVADER1_WIDTH,ypos+.1*INVADER1_HEIGHT,.15*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
     
     rect(xpos-.5*INVADER1_WIDTH,ypos+.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
   
     rect(xpos+.4*INVADER1_WIDTH,ypos+.2*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
   
     rect(xpos-.4*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);
     rect(xpos+.3*INVADER1_WIDTH,ypos+.3*INVADER1_HEIGHT,.1*INVADER1_WIDTH,.1*INVADER1_HEIGHT);} 
   }
      else{
        image(invaderImage, xpos-INVADER1_WIDTH/2, ypos-INVADER1_HEIGHT/2);
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
      //If player does not have power-up 4, then get rid of the projectile 
      if(currentPowerUp!=4){
        projectile.xpos = bulletGraveyard;
      }
      score += 30;
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
