import ddf.minim.*;

//Define all constants used throughout the program

final static int PLAYER_WIDTH        = 30;
final static int PLAYER_HEIGHT       = 15;
final static int FRAMES_PER_SECOND     = 30;
final static int MARGIN                = 30;
final static int INVADER1_WIDTH        = 28;
final static int INVADER1_HEIGHT       = 26;
final static int INVADER2_WIDTH        = 28;
final static int INVADER2_HEIGHT       = 26;
final static int INVADER3_HEIGHT       = 26;
final static int INVADER3_WIDTH        = 28;
final static int PROJECTILE_WIDTH      = 4;
final static int PROJECTILE_HEIGHT     = 8;
final static int SHIELD_PIECE_WIDTH    = 4;
final static int SHIELD_PIECE_HEIGHT   = 8;
final static int POWER_UP_HEIGHT       = 30;
final static int POWER_UP_WIDTH        = 30;
final static int SCREENX               = 500;
final static int SCREENY               = 600;
final static int SCREEN_BORDER         = 3;
final static int EXPLOSION_TIME        = 8;
final static int AMOUNT_OF_INVADERS    = 10;
final static float SPACE_WHILE_DANCING = 2.4;
final static float AMOUNT_BETWEEN_INVADERS = 1.5;
final static float BULLET_DELAY        = 4;
final static float SPEED               = 2;        // <-- Change this number to instantly alter the difficulty

Boolean movingDownwards;
Boolean movedOut;
boolean projectileOnScreen;
boolean onMenuScreen;
boolean gameSetup;
boolean bottomHit;
boolean powerUpOnScreen;
boolean newHighScore;
boolean onHighScoresMenu;
boolean shot;
boolean movingLeft1;
boolean movingRight1;
boolean keyBeingPressed;
boolean paused;  
boolean selection1;
boolean selection2;
boolean selection3;
boolean initialsEntered;
boolean onHowToPlayScreen;
float   stash;
float   currentPowerUp;
float   bulletCooldown;
int     currentSelection;
int     score;
int     livesRemaining;
int     killCount;
int     powerUpTime;
int     currentPlayerProjectileIndex;
int     currentInvaderProjectileIndex;
int     fireRate;
int     randomInvaderForPowerUp;
int     randomShootInvader;
int     lastScore;
int     spacesMovedDown;
int     invaderGraveyard;
int     bulletGraveyard;
int     shieldGraveyard;
int     powerUpGraveyard;
int[]   topHighScores;
int[][] shieldPiece1ArrayInitialiser;
int[][] shieldPiece2ArrayInitialiser;
int[][] shieldPiece3ArrayInitialiser;
int[][] shieldPiece4ArrayInitialiser;
PFont   gameFont;
PFont   scoreFont;
String[] highScoresStrings;
String[] scoreHolders;
String   typing;
String   saved;

Player          thePlayer;
Lives           playerLives;
Invader3        invader3;
Invader1        invaders1Array[];
Invader2        invaders2Array[];
Invader3        invaders3Array[];
Minim           minim;
AudioPlayer     soundtrack;
AudioPlayer     player;
AudioPlayer     invaderDeath;
Projectile      playerProjectile[];
Projectile      invaderProjectile[];
MainMenu        mainMenu;
LevelTransition levelTransition;
PowerUp         powerUp;
HighScoresMenu  highScoreMenu;
ShieldPiece     shieldPiece1Array[][];
ShieldPiece     shieldPiece2Array[][];
ShieldPiece     shieldPiece3Array[][];
ShieldPiece     shieldPiece4Array[][];


void setup(){
  size(SCREENX,SCREENY);
  ellipseMode(RADIUS);
  frameRate(FRAMES_PER_SECOND);
  background(0);
  
  movingDownwards    = false;
  onMenuScreen       = true;
  gameSetup          = false;
  projectileOnScreen = false;
  bottomHit          = false;
  paused             = false;
  newHighScore       = false;
  onHighScoresMenu   = false;
  powerUpOnScreen    = false;
  shot               = false;
  movingLeft1        = false;
  movingRight1       = false;
  keyBeingPressed    = false;
  paused             = false;
  onHowToPlayScreen  = false;
  currentSelection   = 100000001;
  score              = 0;
  spacesMovedDown    = 0;
  livesRemaining     = 3;
  killCount          = 0;
  stash              = 0;
  currentPowerUp     = 0;
  bulletCooldown     = 0;
  fireRate           = 2;
  powerUpTime        = 30;
  currentPlayerProjectileIndex  = 0;
  currentInvaderProjectileIndex = 0;
  invaderGraveyard   = SCREENY + 100;
  bulletGraveyard    = SCREENY + 1000;
  shieldGraveyard    = SCREENY + 10000;
  powerUpGraveyard   = SCREENY + 100000;
  lastScore          = 0;
  playerLives        = new Lives();
  thePlayer          = new Player();
  mainMenu           = new MainMenu();
  highScoreMenu      = new HighScoresMenu();
  levelTransition    = new LevelTransition();
  invader3           = new Invader3(99999,99999);
  invaders1Array     = new Invader1[AMOUNT_OF_INVADERS];
  invaders2Array     = new Invader2[AMOUNT_OF_INVADERS];
  invaders3Array     = new Invader3[AMOUNT_OF_INVADERS];
  playerProjectile   = new Projectile[200];
  invaderProjectile  = new Projectile[200];
  powerUp            = new PowerUp(invader3);
  minim              = new Minim(this);
  
  //Here shield piece Arrays can be drawn out in 1s and 0s, which will be reflected in the way they are arranged in the game.
  //  Each 1 in a 2D array will materialise as part of one of a player's shields during the game.
  
  shieldPiece1ArrayInitialiser = new int[][] {
  { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
  { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
  { 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
  { 1, 1, 1, 0, 0, 0, 00, 0, 0, 0, 1, 1, 1 }       };
  shieldPiece1Array = new ShieldPiece[13][5];
  shieldPiece2ArrayInitialiser = new int[][] {
  { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
  { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
  { 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 }       };
  shieldPiece2Array = new ShieldPiece[13][5];
  shieldPiece3ArrayInitialiser = new int[][] {
  { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
  { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
  { 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 }       };
  shieldPiece3Array = new ShieldPiece[13][5]; 
  shieldPiece4ArrayInitialiser = new int[][] {
  { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
  { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
  { 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
  { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 }       }; 
  shieldPiece4Array = new ShieldPiece[13][5];
  
  for(int i=0;i<shieldPiece1ArrayInitialiser[1].length; i++){
    for(int j=0; j<shieldPiece1ArrayInitialiser.length; j++){
      shieldPiece1Array[i][j]     = new ShieldPiece(999,999);
      shieldPiece2Array[i][j]     = new ShieldPiece(999,999);
      shieldPiece3Array[i][j]     = new ShieldPiece(999,999);
      shieldPiece4Array[i][j]     = new ShieldPiece(999,999);}}
  for(int i=0; i<playerProjectile.length; i++){
    playerProjectile[i]     = new Projectile(-50,-50);}
  for(int i=0; i<invaderProjectile.length; i++){
    invaderProjectile[i]     = new Projectile(-50,-50);}
  for(int i=0; i<invaders1Array.length; i++){
    invaders1Array[i] = new Invader1(60,i*INVADER1_HEIGHT*SPACE_WHILE_DANCING+INVADER1_HEIGHT);}
  for(int i=0; i<invaders2Array.length; i++){
    invaders2Array[i] = new Invader2(SCREENX-60,i*INVADER2_HEIGHT*SPACE_WHILE_DANCING+INVADER2_HEIGHT);}
  randomInvaderForPowerUp          = int(random(invaders3Array.length-1));
    
  // Initialise different sounds used in the game imported from the folder the game is in
  //player = minim.loadFile("Moar Ghosts and Stuff .mov");
  //soundtrack = minim.loadFile("Moar Ghosts and Stuff .mov");
  invaderDeath = minim.loadFile("Invader Death.mov");
  //soundtrack.loop();
  
  // Initialise different fonts
  gameFont           = loadFont("DINCondensed-Bold-48.vlw");
  scoreFont          = loadFont("HiraKakuStdN-W8-48.vlw");
  
  //Bring in the current high-scores and their corresponding high-score-holders
  highScoresStrings  = loadStrings("InvadersHighScores.txt");
  scoreHolders       = loadStrings("InvadersHighScoreHolders.txt");
  topHighScores      = new int[highScoresStrings.length];
  for(int i=0;i<highScoresStrings.length;i++){
    topHighScores[i]  = int(highScoresStrings[i]);}
}


void draw(){
  
  // MENU SCREEN
  
  if(onMenuScreen == true){
    mainMenu.display();
    for(int i=0; i<invaders1Array.length; i++){
      invaders1Array[i].dance();
      invaders1Array[i].draw();}
    for(int i=0; i<invaders2Array.length; i++){
      invaders2Array[i].dance();
      invaders2Array[i].draw();}
    fill(255);
    rect(0,0,SCREENX,30);}
    
  // GAME SETUP (happens upon starting a new game.)  
    
  else if(gameSetup==true){
    if(bottomHit==true){
      if(playerLives.livesRemaining>0){
        levelTransition.goBackUp(invaders1Array,invaders2Array,invaders3Array, playerLives, playerProjectile, invaderProjectile);}
      else{
        levelTransition.gameOver(invaders1Array,invaders2Array,invaders3Array,playerLives);}}
    else{
      levelTransition.change(invaders1Array,invaders2Array,invaders3Array, playerProjectile, invaderProjectile, invader3, shieldPiece1ArrayInitialiser, shieldPiece1Array);}
    thePlayer.draw();
    drawLayout();
    playerLives.draw();
  }
  
  // HIGH SCORE MENU SCREEN
  
  
  else if(onHighScoresMenu==true){
    highScoreMenu.display();
    for(int i=0; i<invaders1Array.length; i++){
      invaders1Array[i].dance();
      invaders1Array[i].draw();}
    for(int i=0; i<invaders2Array.length; i++){
      invaders2Array[i].dance();
      invaders2Array[i].draw();}
    fill(255);
    rect(0,0,SCREENX,30);}
    
  // PAUSED GAME  
    
  else if(paused==true){
    if (frameCount%40<20) {
      fill(255);}
    else{
      fill(0);}
      noStroke();
      textAlign(CENTER);
      textFont(gameFont, 70);
      text("Game Paused", SCREENX/2, 2*SCREENY/3);}
      
  // HOW TO PLAY SCREEN
  
  else if(onHowToPlayScreen==true){
    mainMenu.displayHowTo();
    for(int i=0; i<invaders1Array.length; i++){
      invaders1Array[i].dance();
      invaders1Array[i].draw();}
    for(int i=0; i<invaders2Array.length; i++){
      invaders2Array[i].dance();
      invaders2Array[i].draw();}
    fill(255);
    rect(0,0,SCREENX,30);
  }
  
  // PLAYING IN GAME MODE
  
  else{
      background(0);
      //If powerup-invader has been shot, emit power-up and kill invader
      if(invaders3Array[randomInvaderForPowerUp].exploded==true && frameCount - invaders3Array[randomInvaderForPowerUp].timeOfExplosion == 7){
        powerUp = new PowerUp(invaders3Array[randomInvaderForPowerUp]);}
      //if power-up is on screen
      if(powerUpOnScreen = true){
        powerUp.move();
        powerUp.draw();
        if(projectileOnScreen == true){
          for(int k=0;k<playerProjectile.length;k++){
            powerUp.store(playerProjectile[k]);}}
        powerUp.activate();
        powerUp.deActivate();}
      //if projectile is on screen
      if(projectileOnScreen == true){
          for(int k=0;k<invaderProjectile.length;k++){
            thePlayer.explode(invaderProjectile[k]);}}
      //if the player has shot
      if(shot == true){
        //if the player has the 3rd power up, shoot three projectiles
        if(currentPowerUp==3){
          playerProjectile[currentPlayerProjectileIndex] = new Projectile(thePlayer.xpos-4*PROJECTILE_WIDTH,thePlayer.ypos);
          playerProjectile[currentPlayerProjectileIndex+1] = new Projectile(thePlayer.xpos,thePlayer.ypos);
          playerProjectile[currentPlayerProjectileIndex+2] = new Projectile(thePlayer.xpos+4*PROJECTILE_WIDTH,thePlayer.ypos);
          shot = false;
          currentPlayerProjectileIndex+=3;}
        else{
          playerProjectile[currentPlayerProjectileIndex] = new Projectile(thePlayer.xpos,thePlayer.ypos);
          shot = false;
          currentPlayerProjectileIndex++;}
        //if the player has shot more bullets than allowed, overwrite the first projectile used (wrap around the list of projectile)  
        if(currentPlayerProjectileIndex>=playerProjectile.length-3){currentPlayerProjectileIndex=0;}}
       //randomly let invaders shoot projectiles
      if(int(random(20*levelTransition.level+10))==1){
        projectileOnScreen=true;
        randomShootInvader = int(random(invaders2Array.length));
        invaderProjectile[currentInvaderProjectileIndex] = new Projectile(invaders2Array[randomShootInvader].xpos,invaders2Array[randomShootInvader].ypos);
        currentInvaderProjectileIndex++;
        //if the invaders have shot more bullets than allowed, overwrite the first projectile (wrap around the list of projectile)
        if(currentInvaderProjectileIndex>=invaderProjectile.length-3){currentInvaderProjectileIndex=0;}}
      //if projectiles are on the screen
      if(projectileOnScreen == true){
        //take care of player's projectiles
        for(int k=0;k<playerProjectile.length;k++){
          playerProjectile[k].move();
          playerProjectile[k].draw();
          playerProjectile[k].collide();}
        //take care of invaders' projectiles
        for(int k=0;k<invaderProjectile.length;k++){
          invaderProjectile[k].drop();
          invaderProjectile[k].draw();
          invaderProjectile[k].collide();}}
      //take care of all the shields' shield pieces
      for(int i=0;i<shieldPiece1ArrayInitialiser[1].length; i++){
          for(int j=0;j<shieldPiece1ArrayInitialiser.length; j++){
            //Shield number 1
            if(shieldPiece1ArrayInitialiser[j][i]==1){
              shieldPiece1Array[i][j].draw();
              for(int k=0;k<invaderProjectile.length;k++){
                shieldPiece1Array[i][j].explode(invaderProjectile[k]);}
              for(int k=0;k<playerProjectile.length;k++){
                shieldPiece1Array[i][j].explode(playerProjectile[k]);}}
            if(shieldPiece1Array[i][j].hit==true){
              shieldPiece1ArrayInitialiser[j][i] = 0;}
            //Shield number 2
            if(shieldPiece2ArrayInitialiser[j][i]==1){
              shieldPiece2Array[i][j].draw();
              for(int k=0;k<invaderProjectile.length;k++){
                shieldPiece2Array[i][j].explode(invaderProjectile[k]);}
              for(int k=0;k<playerProjectile.length;k++){
                shieldPiece2Array[i][j].explode(playerProjectile[k]);}}
            if(shieldPiece2Array[i][j].hit==true){
              shieldPiece2ArrayInitialiser[j][i] = 0;}
            //Shield number 3
            if(shieldPiece3ArrayInitialiser[j][i]==1){
              shieldPiece3Array[i][j].draw();
              for(int k=0;k<invaderProjectile.length;k++){
                shieldPiece3Array[i][j].explode(invaderProjectile[k]);}
              for(int k=0;k<playerProjectile.length;k++){
                shieldPiece3Array[i][j].explode(playerProjectile[k]);}}
            if(shieldPiece3Array[i][j].hit==true){
              shieldPiece3ArrayInitialiser[j][i] = 0;}
            //Shield number 4
            if(shieldPiece4ArrayInitialiser[j][i]==1){
              shieldPiece4Array[i][j].draw();
              for(int k=0;k<invaderProjectile.length;k++){
                shieldPiece4Array[i][j].explode(invaderProjectile[k]);}
              for(int k=0;k<playerProjectile.length;k++){
                shieldPiece4Array[i][j].explode(playerProjectile[k]);}}
            if(shieldPiece4Array[i][j].hit==true){
              shieldPiece4ArrayInitialiser[j][i] = 0;}}}
      //move all the space-invader_1s
      for(int i=0; i<invaders1Array.length; i++){
        invaders1Array[i].move();
        invaders1Array[i].draw();
        invaders1Array[i].disappear();
        if(projectileOnScreen == true){
          for(int k=0;k<playerProjectile.length;k++){
            invaders1Array[i].explode(playerProjectile[k]);}}
      }
      //move all the space-invader_2s
      for(int i=0; i<invaders2Array.length; i++){
        invaders2Array[i].move();
        invaders2Array[i].draw();
        invaders2Array[i].disappear();
        if(projectileOnScreen == true){
          for(int k=0;k<playerProjectile.length;k++){
            invaders2Array[i].explode(playerProjectile[k]);}}
      }
      //move all the space-invader_3s
      for(int i=0; i<invaders3Array.length; i++){
        invaders3Array[i].move();
        invaders3Array[i].draw();
        invaders3Array[i].disappear();
        if(projectileOnScreen == true){
          for(int k=0;k<playerProjectile.length;k++){
            invaders3Array[i].explode(playerProjectile[k]);}}
      }
      //Take care of general drawing
      thePlayer.move();
      thePlayer.draw();
      drawLayout();
      playerLives.draw();
      levelTransition.checkTransition();
      //count down the power-up time
      if(frameCount%FRAMES_PER_SECOND==0 && currentPowerUp !=0){
        powerUpTime--;}
      //take care of bullet-cooldown time
      if((frameCount%FRAMES_PER_SECOND==0||frameCount%FRAMES_PER_SECOND==FRAMES_PER_SECOND/2) && bulletCooldown >0 && fireRate==4){
        bulletCooldown-=fireRate;}
      else if((frameCount%FRAMES_PER_SECOND==0||frameCount%FRAMES_PER_SECOND==FRAMES_PER_SECOND/2) && bulletCooldown >0 && fireRate==2){
        bulletCooldown-=fireRate;}
      if(bulletCooldown<0){bulletCooldown=0;}
  }
}
