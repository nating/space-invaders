class HighScoresMenu{
  boolean newHighScoreInputted;
  boolean newHighScore;
  
  HighScoresMenu(){
    currentSelection = 100000001;  //Ridiculously high number to avoid how modulo wraps around when passing zero >.<
    keyBeingPressed = false;
    typing = "";
    saved = "";
    initialsEntered = false;
    newHighScore = false;
  }
  
  //Draw the high score menu
  void display(){
    background(0);
    fill(255);
    rect(0,0,SCREENX,30);
    textFont(gameFont,70);
    textAlign(CENTER);
    fill(255);
    stroke(255);
    text("High Scores:",SCREENX/2,SCREENY/4);
    textFont(scoreFont,20);
    stroke(255);
    textAlign(RIGHT);
    //Draw each of the 5 high-scores
    text(topHighScores[4],3*SCREENX/4, 6*SCREENY/16);
    text(topHighScores[3],3*SCREENX/4, 7*SCREENY/16);
    text(topHighScores[2],3*SCREENX/4, 8*SCREENY/16);
    text(topHighScores[1],3*SCREENX/4, 9*SCREENY/16);
    text(topHighScores[0],3*SCREENX/4, 10*SCREENY/16);
    textAlign(LEFT);
    //Draw the crown on the top initials
    noStroke();
    fill(255,248,31);
    triangle(SCREENX/4+27,5*SCREENY/16+10,SCREENX/4+38,5*SCREENY/16+10,SCREENX/4+32,5*SCREENY/16-5);
    triangle(SCREENX/4+38,5*SCREENY/16+10,SCREENX/4+49,5*SCREENY/16+10,SCREENX/4+43,5*SCREENY/16-5);
    triangle(SCREENX/4+49,5*SCREENY/16+10,SCREENX/4+60,5*SCREENY/16+10,SCREENX/4+54,5*SCREENY/16-5);
    rect(SCREENX/4+27,5*SCREENY/16+10,33,7);
    //If the top initials are of length 3, increase the crown size by another triangle
    if(scoreHolders[4].length()==3){
      triangle(SCREENX/4+50,5*SCREENY/16+10,SCREENX/4+71,5*SCREENY/16+10,SCREENX/4+65,5*SCREENY/16-5);
      rect(SCREENX/4+27,5*SCREENY/16+10,44,7);}
    //Draw the numbers beside the initials
    fill(255);
    text("1. "+scoreHolders[4],SCREENX/4, 6*SCREENY/16);
    text("2. "+scoreHolders[3],SCREENX/4, 7*SCREENY/16);
    text("3. "+scoreHolders[2],SCREENX/4, 8*SCREENY/16);
    text("4. "+scoreHolders[1],SCREENX/4, 9*SCREENY/16);
    text("5. "+scoreHolders[0],SCREENX/4, 10*SCREENY/16);
    //If players have a score from a previously played game, display it.
    if(score>=0){
      textAlign(CENTER);
      text("Your Score:",SCREENX/2, 13*SCREENY/16);
      text(lastScore,SCREENX/2, 14*SCREENY/16);}
    stroke(255);
    line(0,0,0,SCREENY);
    line(1,0,1,SCREENY);
    line(SCREENX-1,0,SCREENX-1,SCREENY);
    line(SCREENX-2,0,SCREENX-2,SCREENY);
    line(0,SCREENY-1,SCREENX,SCREENY-1);
    line(0,SCREENY-2,SCREENX,SCREENY-2);
    textFont(gameFont,25);
    textAlign(CENTER);
    highScoreMenu.higherThan(topHighScores,score);
    //If player has a new highscore, prompt input
    if(newHighScore==true){
      text("Please enter initials: ", SCREENX/2, 11*SCREENY/16);
      text(typing, SCREENX/2, 12*SCREENY/16);
      //If initials have been entered, update the high-scores
      if(initialsEntered==true){
        highScoreMenu.insertScore(topHighScores,scoreHolders,score);
        saveStrings("InvadersHighScoreHoldersFile.txt", scoreHolders);
        for(int i=0;i<highScoresStrings.length;i++){
          highScoresStrings[i] = "" + topHighScores[i];}
          saveStrings("InvadersHighScoreHoldersFile copy.txt",highScoresStrings);
          lastScore = score;
          score = 0;
          newHighScore=false;}}
    }
    
    //Check if player's score is higher than any of the high-score holders
    void higherThan(int[] highScoreList, int score){
      for(int i=0;i<highScoreList.length;i++){
        if (score >= highScoreList[i]){
          newHighScore = true;
        }
      }
    }
    
    //Insert score in list and move out the bottom high-score holder
    void insertScore(int[] highScoreList,String[] scoreHolders, int score){
      int placeForHighScore = 0;
      for(int i = 0;i<highScoreList.length-1;i++){
        if(score>=highScoreList[i+1]){
          placeForHighScore++;
        }
      }
      for(int count = 1; count < placeForHighScore + 1; count++){
        highScoreList[count -1] = highScoreList[count];
        scoreHolders[count -1] = scoreHolders[count];
      }
      highScoreList[placeForHighScore] = score;
      scoreHolders[placeForHighScore] = saved;
      initialsEntered = true;
    }  
  
}
