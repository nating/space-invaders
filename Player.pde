class Player {
  float xpos; float ypos;
  color playerColor = color(255);
  
  Player(){
    xpos = SCREENX/2;
    ypos = SCREENY - MARGIN;
  }
  
  //Move the player
  void move() {
      if(movingLeft1 == true && xpos>=PLAYER_WIDTH/2+SCREEN_BORDER){
        if(currentPowerUp == 1){ 
          xpos-= 6;
        }
        else{
          xpos-=3;
        }
      }
      if(movingRight1 == true && xpos<= SCREENX-PLAYER_WIDTH/2-SCREEN_BORDER){
        if(currentPowerUp == 1){
          xpos+= 6;
        }
        else{
          xpos+=3;
        }
      }
  }
  
  //Draw the player
  void draw(){
    fill(playerColor);
    noStroke();
    ellipse(xpos,SCREENY-MARGIN,PLAYER_WIDTH/2,PLAYER_HEIGHT/2);
    rect(xpos-PLAYER_WIDTH/2,ypos,PLAYER_WIDTH,PLAYER_HEIGHT/2);
    rect(xpos-PLAYER_WIDTH/8,ypos-PLAYER_WIDTH/2,PLAYER_WIDTH/4,PLAYER_HEIGHT);
  }
  
  //See if the player has been shot
  void explode(Projectile invaderProjectile){
    if(invaderProjectile.xpos <= xpos+PLAYER_WIDTH/2 && invaderProjectile.xpos >= xpos-PLAYER_WIDTH/2 && invaderProjectile.ypos>= ypos-PLAYER_HEIGHT  && invaderProjectile.ypos <= ypos+PLAYER_HEIGHT){
    bottomHit = true;
    gameSetup = true;}
  }
}
