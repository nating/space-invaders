
//Method for drawing different parts of the screen
void drawLayout(){
  //Draw top bar
  fill(255);
  rect(0,0,SCREENX,30);
  textFont(gameFont,25);
  textAlign(CENTER);
  fill(0);
  text("Space Invaders Baby",SCREENX/2,23);
  textAlign(LEFT);
  text("Score: ",SCREEN_BORDER+2,23);
  text(score,60,23);
  stroke(255);
  line(0,0,0,SCREENY);
  line(1,0,1,SCREENY);
  line(SCREENX-1,0,SCREENX-1,SCREENY);
  line(SCREENX-2,0,SCREENX-2,SCREENY);
  line(0,SCREENY-1,SCREENX,SCREENY-1);
  line(0,SCREENY-2,SCREENX,SCREENY-2);
  line(0,SCREENY-2*MARGIN,SCREENX,SCREENY-2*MARGIN);
  if(stash==0){}
  //If player has power-up, draw it on the top bar, with its particular power-up configuration
  else{ 
    fill(255);
    stroke(255,0,0);
    ellipse(SCREENX-100,MARGIN/2,13,13);
    noStroke();
    fill(255,0,0);
    if(stash==1){
      triangle(SCREENX-100,MARGIN/2-.3*POWER_UP_HEIGHT,SCREENX-100,MARGIN/2,SCREENX-100-.2*POWER_UP_WIDTH,MARGIN/2);
      triangle(SCREENX-100,MARGIN/2+.3*POWER_UP_HEIGHT,SCREENX-100,MARGIN/2,SCREENX-100+.2*POWER_UP_WIDTH,MARGIN/2);
    }
    else if(stash==2){
      ellipse(SCREENX-100,MARGIN/2,.2*POWER_UP_WIDTH,.2*POWER_UP_HEIGHT);
    }
    else if(stash==3){
      textAlign(CENTER);
      text("3",SCREENX-98,MARGIN/2+10);
    }
    else if(stash==4){
      rect(SCREENX-100-.2*POWER_UP_WIDTH,MARGIN/2-.2*POWER_UP_HEIGHT,.4*POWER_UP_WIDTH,.4*POWER_UP_HEIGHT);
    }
  }
  //If the player is using a power-up, draw the time left with it
  if(currentPowerUp != 0){
    stroke(255);
    textAlign(RIGHT);
    fill(255,0,0);
    text(powerUpTime,SCREENX-SCREEN_BORDER,SCREENY-MARGIN);
  }
}


//Deal with any key being pressed at any stage of the game
void keyPressed(){
  
  //MENU SCREEN
  if(onMenuScreen==true){
    if(keyPressed){
        if(keyCode==UP){currentSelection+=1;}
        else if(keyCode==DOWN){currentSelection-=1;
      }
        else if(selection1 == true && key=='\n'){
          score =0 ;
          onMenuScreen = false;
          gameSetup = true;
        }
        else if(selection2 == true && key=='\n'){
          onMenuScreen = false;
          onHowToPlayScreen = true;
        }
        else if(selection3 == true && key=='\n'){
          onMenuScreen = false;
          onHighScoresMenu = true;
        }
      }
  }
  
  //HIGH SCORE MENU
  else if(onHighScoresMenu==true){
    if(keyPressed){
      if(key == '\n' && typing.length()>0) {
        saved = typing;
        typing = "";
        initialsEntered = true;
      }
      else if (keyCode == BACKSPACE && typing.length()>0) {
        typing = typing.substring(0, typing.length()-1);
      } 
      else if (keyCode == LEFT) {
        onHighScoresMenu = false;
        onMenuScreen = true;
      }
      else{
        if(typing.length()<3 && (('a'<=key && key<='z')||('A'<=key && key<='Z'))){
          typing = typing + key;
          typing = typing.toUpperCase();
        }
      }
    }
  }
  
  //HOW TO PLAY SCREEN
  else if(onHowToPlayScreen==true){
    if(keyPressed){
      if (keyCode == LEFT) {
        onHowToPlayScreen = false;
        onMenuScreen = true;
      }
    }
  }
        
  //PAUSED GAME
  else if(paused){
    if(keyPressed){
      if(key == 'p' || key == 'P'){
        paused = false;
      }
    }
  }
        
   //IN A GAME
   else{
     if(keyPressed){
       if(keyCode==LEFT){
         movingLeft1 = true;
       }
       if(keyCode==RIGHT){
         movingRight1 = true;
       }
       if((keyCode == UP || key==' ') && bulletCooldown == 0){
         projectileOnScreen = true;
         shot = true;
         bulletCooldown = BULLET_DELAY;
       }
       if(key == 'p' || key == 'P'){
         paused = true;
       }
     }
   }
}

//Deal with a key being release at any stage of the game (most actions occur on a "key-press")
void keyReleased(){
  if(keyCode==LEFT){movingLeft1 = false;}
  if(keyCode==RIGHT){movingRight1 = false;}
}
