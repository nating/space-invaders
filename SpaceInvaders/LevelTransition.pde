class LevelTransition {
  int level;
  int activationTime;
  int transitionDuration;

  LevelTransition() {
    level = 1;
    transitionDuration = 2*FRAMES_PER_SECOND;
    activationTime = -1;
  }

  //Change from one level to another
  void change(Invader1[] invaders1array, Invader2[] invaders2Array, Invader3[] invader3Array, Projectile[] playerProjectile, Projectile[] invaderProjectile, Invader3 invaderX, int[][] shieldPiece1ArrayInitialiser, ShieldPiece[][] shield1PieceArray) {
    projectileOnScreen = false;
    //Take all player projectiles away from the screen
    for (int i =0; i<playerProjectile.length; i++) {
      playerProjectile[i].xpos=-1890;
    }
    //Take all invaders' projectiles away from the screen
    for (int i =0; i<invaderProjectile.length; i++) {
      invaderProjectile[i].xpos=-1890;
    }
    //Print the level to stdout once activated, and set the activation time to the current time.
    if (activationTime == -1) {
      activationTime=frameCount;
      println("\n \n Level " + level);
    }
    //Draw the new level
    background(0);
    drawLayout();
    for (int i=0; i<shieldPiece1ArrayInitialiser[1].length; i++) {
      for (int j=0; j<shieldPiece1ArrayInitialiser.length; j++) {
        if (shieldPiece1ArrayInitialiser[j][i]==1) {
          shieldPiece1Array[i][j] = new ShieldPiece(SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece1Array[i][j].draw();}
        if (shieldPiece2ArrayInitialiser[j][i]==1) {
          shieldPiece2Array[i][j] = new ShieldPiece(2*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece2Array[i][j].draw();}
        if (shieldPiece3ArrayInitialiser[j][i]==1) {
          shieldPiece3Array[i][j] = new ShieldPiece(3*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece3Array[i][j].draw();}
        if (shieldPiece4ArrayInitialiser[j][i]==1) {
          shieldPiece4Array[i][j] = new ShieldPiece(4*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece4Array[i][j].draw();
        }
      }
    }
    for (int i=0; i<invaders1Array.length; i++) {
      invaders1Array[i] = new Invader1(i*INVADER1_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER1_WIDTH*2, INVADER1_HEIGHT*3.5+MARGIN);
      invaders1Array[i].draw();
      invaders1Array[i].dx=level*SPEED;
      invaders1Array[i].dy=level*SPEED/2;
    }
    for (int i=0; i<invaders2Array.length; i++) {
      invaders2Array[i] = new Invader2(i*INVADER2_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER2_WIDTH*2, INVADER2_HEIGHT*2+MARGIN);
      invaders2Array[i].draw();
      invaders2Array[i].dx=level*SPEED;
      invaders2Array[i].dy=level*SPEED/2;
    }
    for (int i=0; i<invaders3Array.length; i++) {
      invaders3Array[i] = new Invader3(i*INVADER3_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER3_WIDTH*2, INVADER3_HEIGHT+MARGIN);
      invaders3Array[i].draw();
      invaders3Array[i].dx=level*SPEED;
      invaders3Array[i].dy=level*SPEED/2;
    }
    randomInvaderForPowerUp = int(random(invaders3Array.length-1));
    fill(255);
    textAlign(CENTER);
    textFont(gameFont, 70);
    //Flash the current level on the screen
    if (frameCount%20<10) {
      text("Level "+level, SCREENX/2, 2*SCREENY/3);
    }
    //Initialise the new level and move back into game mode
    if (frameCount-transitionDuration==activationTime && frameCount>transitionDuration) {
      gameSetup = false;
      activationTime = -1;
    }
  }

  //
  void goBackUp(Invader1[] invaders1array, Invader2[] invaders2Array, Invader3[] invader3Array, Lives lives, Projectile[] playerProjectile, Projectile[] invaderProjectile){
    projectileOnScreen = false;
    for(int i =0; i<playerProjectile.length; i++){
      playerProjectile[i].xpos=-1890;
    }
    for(int i =0; i<invaderProjectile.length; i++){
      invaderProjectile[i].xpos=-1890;
    }
    if(activationTime == -1){
      lives.livesRemaining--;
      activationTime=frameCount;
    } 
    else{
      background(0);
      drawLayout();
      for(int i=0; i<shieldPiece1ArrayInitialiser[1].length; i++){
        for(int j=0; j<shieldPiece1ArrayInitialiser.length; j++){
          if(shieldPiece1ArrayInitialiser[j][i]==1){
            shieldPiece1Array[i][j] = new ShieldPiece(SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
            shieldPiece1Array[i][j].draw();
          }
          if(shieldPiece2ArrayInitialiser[j][i]==1){
            shieldPiece2Array[i][j] = new ShieldPiece(2*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
            shieldPiece2Array[i][j].draw();
          }
          if(shieldPiece3ArrayInitialiser[j][i]==1){
            shieldPiece3Array[i][j] = new ShieldPiece(3*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
            shieldPiece3Array[i][j].draw();
          }
          if(shieldPiece4ArrayInitialiser[j][i]==1){
            shieldPiece4Array[i][j] = new ShieldPiece(4*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
            shieldPiece4Array[i][j].draw();
          }
        }
      }
      lives.draw();
      if(livesRemaining>0){
        for(int i=0; i<invaders1Array.length; i++){
          if(invaders1Array[i].killed == false){
            invaders1Array[i] = new Invader1(i*INVADER1_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER1_WIDTH*2, INVADER1_HEIGHT*3.5+MARGIN);
            invaders1Array[i].draw();
            invaders1Array[i].dx =level*SPEED;
            invaders1Array[i].dy =level*SPEED/2;
          }
        }
        for (int i=0; i<invaders2Array.length; i++){
          if (invaders2Array[i].killed == false){
            invaders2Array[i] = new Invader2(i*INVADER2_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER2_WIDTH*2, INVADER2_HEIGHT*2+MARGIN);
            invaders2Array[i].draw();
            invaders2Array[i].dx =level*SPEED;
            invaders2Array[i].dy =level*SPEED/2;
          }
        }
        for (int i=0; i<invaders3Array.length; i++){
          if (invaders3Array[i].killed == false){
            invaders3Array[i] = new Invader3(i*INVADER3_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER3_WIDTH*2, INVADER3_HEIGHT*1+MARGIN);
            invaders3Array[i].draw();
            invaders3Array[i].dx =level*SPEED;
            invaders3Array[i].dy =level*SPEED/2;
          }
        }
        fill(255);
        textAlign(CENTER);
        textFont(gameFont, 70);
        if (frameCount%20<10){
          text("Level " + level, SCREENX/2, 2*SCREENY/3);
        }
        if (frameCount-transitionDuration==activationTime && frameCount>transitionDuration){
          bottomHit = false;
          gameSetup = false;
          activationTime = -1;
        }
      }
    }
  }

  //Draw game over, to be called when the player dies
  void gameOver(Invader1[] invaders1Array, Invader2[] invaders2Array, Invader3[] invaders3Array, Lives lives){
    if (activationTime == -1){
      activationTime=frameCount;
    }
    background(0);
    drawLayout();
    for (int i=0; i<shieldPiece1ArrayInitialiser[1].length; i++){
      for (int j=0; j<shieldPiece1ArrayInitialiser.length; j++){
        if (shieldPiece1ArrayInitialiser[j][i]==1){
          shieldPiece1Array[i][j] = new ShieldPiece(SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece1Array[i][j].draw();
        }
        if (shieldPiece2ArrayInitialiser[j][i]==1){
          shieldPiece2Array[i][j] = new ShieldPiece(2*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+SCREENX/4+j*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece2Array[i][j].draw();
        }
        if (shieldPiece3ArrayInitialiser[j][i]==1){
          shieldPiece3Array[i][j] = new ShieldPiece(3*SCREENX/5-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+SCREENX/2+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece3Array[i][j].draw();
        }
        if (shieldPiece4ArrayInitialiser[j][i]==1){
          shieldPiece4Array[i][j] = new ShieldPiece(4*SCREENX/5+SCREENX/2-.5*shieldPiece1ArrayInitialiser[1].length*SHIELD_PIECE_WIDTH+SCREENX/2+i*SHIELD_PIECE_WIDTH, SCREENY-4*MARGIN+j*SHIELD_PIECE_HEIGHT);
          shieldPiece4Array[i][j].draw();
        }
      }
    }
    fill(255);
    textAlign(CENTER);
    textFont(gameFont, 80);
    for (int i=0; i<invaders1Array.length; i++){
      invaders1Array[i].draw();
    }
    for (int i=0; i<invaders2Array.length; i++){
      invaders2Array[i].draw();
    }
    for (int i=0; i<invaders3Array.length; i++){
      invaders3Array[i].draw();
    }
    //Flash "GAME OVER" on the screen
    if (frameCount%20<10){
      text("GAME OVER", SCREENX/2, SCREENY/2);
    }
    //Once game over has been on for the transitionDuration, transition to High score menu
    if (frameCount-transitionDuration==activationTime && frameCount>transitionDuration){
      bottomHit = false;
      gameSetup=false;
      onHighScoresMenu = true;
      level = 1;
      currentPowerUp = 0;
      stash = 0;
      killCount = 0;
      activationTime = -1;
      lives.livesRemaining = 3;
      for (int i=0; i<invaders1Array.length; i++){
        invaders1Array[i] = new Invader1(60, i*INVADER1_HEIGHT*SPACE_WHILE_DANCING+INVADER1_HEIGHT);
      }
      for (int i=0; i<invaders2Array.length; i++){
        invaders2Array[i] = new Invader2(SCREENX-60, i*INVADER2_HEIGHT*SPACE_WHILE_DANCING+INVADER2_HEIGHT);}
      lastScore = score;
    }
  }

  //Check if all space invaders have been killed (if level transition should take place)
  void checkTransition(){
    if (killCount == 30){
      killCount = 0;
      level += 1;
      gameSetup = true;
    }
  }
}

