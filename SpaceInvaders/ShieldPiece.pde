class ShieldPiece{
  float xpos; float ypos;
  color shieldColor = color(255,0,0);
  boolean hit;
  
  ShieldPiece(float placeX, float placeY){
    xpos = placeX;
    ypos = placeY;
    hit = false;
  }
  
  //Draw a shield piece
  void draw(){
    if(hit == false){
      fill(shieldColor);
      stroke(255,0,0);
      rect(xpos-SHIELD_PIECE_WIDTH/2,ypos-SHIELD_PIECE_HEIGHT/2,SHIELD_PIECE_WIDTH,SHIELD_PIECE_HEIGHT);
    }
  }
  
  //See if a projectile has hit a shield piece, and remove it
  void explode(Projectile projectile){
    if(projectile.xpos <= xpos+SHIELD_PIECE_WIDTH && projectile.xpos >= xpos && projectile.ypos >= ypos && projectile.ypos <= ypos+SHIELD_PIECE_HEIGHT){
      hit = true;
      xpos = 0-50;
      ypos = 0-50;
      projectile.xpos = bulletGraveyard;
      projectile.ypos = bulletGraveyard;
    }
  }
  
}


