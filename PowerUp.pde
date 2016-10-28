class PowerUp {
  float xpos; float ypos;
  color powerUpColor = color(255);
  boolean acquired;
  float s;
  int sway;
  int dx; int dy;
  float powerType;
  
  //Constructor for a power-up. Takes an invader that will emit the power-up once killed.
  PowerUp(Invader3 invader){
    xpos = invader.xpos;
    ypos = invader.ypos;
    s = 0;
    dx = 1;
    dy = 1;
    sway = 2;
    acquired = false;
    powerType = 1+int(random(4));
  }
  
  //Move the power-up
  void move(){
    if(acquired==false){
      s+=.05;
      xpos += sway*sin(s);
      ypos += dy;
      if(ypos-POWER_UP_HEIGHT>=SCREENY-2*MARGIN){
        powerUpOnScreen = false;}
      }
  }
  
  //Draw the power-up in its particular configuration
  void draw(){
    if(acquired==false){
      noStroke();
      fill(255);    
      rect(xpos-.5*POWER_UP_WIDTH,ypos-.1*POWER_UP_HEIGHT,POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.3*POWER_UP_WIDTH,ypos-.3*POWER_UP_HEIGHT,.6*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.3*POWER_UP_WIDTH,ypos+.1*POWER_UP_HEIGHT,.6*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.4*POWER_UP_WIDTH,ypos-.2*POWER_UP_HEIGHT,.8*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.4*POWER_UP_WIDTH,ypos,.8*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.2*POWER_UP_WIDTH,ypos-.4*POWER_UP_HEIGHT,.4*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.2*POWER_UP_WIDTH,ypos+.2*POWER_UP_HEIGHT,.4*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
      rect(xpos-.1*POWER_UP_WIDTH,ypos-.5*POWER_UP_HEIGHT,.2*POWER_UP_WIDTH,POWER_UP_HEIGHT);
      fill(255,0,0);
      textAlign(CENTER);
      
      if(powerType==1){
        triangle(xpos,ypos-.3*POWER_UP_HEIGHT,xpos,ypos,xpos-.2*POWER_UP_WIDTH,ypos);
        triangle(xpos,ypos+.3*POWER_UP_HEIGHT,xpos,ypos,xpos+.2*POWER_UP_WIDTH,ypos);}
      else if(powerType==2){
        ellipse(xpos,ypos,.2*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);}
      else if(powerType==3){
        textFont(gameFont,25);
        text("3",xpos,ypos+10);}
      else if(powerType==4){
        rect(xpos-.2*POWER_UP_WIDTH,ypos-.2*POWER_UP_HEIGHT,.4*POWER_UP_WIDTH,.4*POWER_UP_HEIGHT);}
    }
  }
  
  //See if a power-up has been hit by a projectile, and store it for use in the 'stash'
  void store(Projectile projectile){
    if(projectile.xpos <= xpos+POWER_UP_WIDTH/2 && projectile.xpos >= xpos-POWER_UP_WIDTH/2 &&
              projectile.ypos >= ypos-POWER_UP_HEIGHT/2 && projectile.ypos <= ypos+POWER_UP_HEIGHT/2){
    acquired = true;
    stash = powerType;
    projectile.xpos = bulletGraveyard;
    projectile.ypos = bulletGraveyard;
    xpos = powerUpGraveyard;
    ypos = powerUpGraveyard;}
  }
  
  //See if a power up has been hit, and delete it
  void delete(Projectile projectile){
    if(projectile.xpos <= xpos+POWER_UP_WIDTH/2 && projectile.xpos >= xpos-POWER_UP_WIDTH/2 &&
              projectile.ypos >= ypos-POWER_UP_HEIGHT/2 && projectile.ypos <= ypos+POWER_UP_HEIGHT/2){
    acquired = true;
    projectile.xpos = bulletGraveyard;
    projectile.ypos = bulletGraveyard;
    xpos = powerUpGraveyard;
    ypos = powerUpGraveyard;}
  }
  
  //Activate a power up
  void activate(){
    if(keyPressed && (key == 'x' || key == 'X') && stash != 0){
      currentPowerUp = stash;
      stash = 0;
      powerUpTime = 30;
      if(currentPowerUp == 2){
        fireRate = 4;
      } 
    }
  }
  
  //See if a power-up has ran out of time, and deactivate it
  void deActivate(){
    if(powerUpTime == 0){
      powerUpTime = 30;
      currentPowerUp = 0;
      fireRate = 2;
    }  
  }
  
}
