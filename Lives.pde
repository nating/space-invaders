class Lives {
  
  int livesRemaining;
  
  Lives(){
    livesRemaining = 3;
  }
  
  //Draw lives (In the shape of love hearts in the top right hand corner of the screen)
  void draw(){
    noStroke();
      fill(255,0,0);
      if(livesRemaining <= 0){
      fill(155);}
      ellipse(SCREENX-70,10,5,5);
      ellipse(SCREENX-60,10,5,5);
      triangle(SCREENX-75,11,SCREENX-55,11,SCREENX-65,27);
      if(livesRemaining == 1){
      fill(155);}
      ellipse(SCREENX-45,10,5,5);
      ellipse(SCREENX-35,10,5,5);
      triangle(SCREENX-50,11,SCREENX-30,11,SCREENX-40,27);
      if(livesRemaining == 2){
      fill(155);}
      ellipse(SCREENX-20,10,5,5);
      ellipse(SCREENX-10,10,5,5);
      triangle(SCREENX-25,11,SCREENX-5,11,SCREENX-15,27);
    }
}
