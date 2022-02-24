class ScoreBoard {
  
  int leftScore;
  int rightScore;
  
  
  int size;


  ScoreBoard() {
    this(0,0,120);
  }

  ScoreBoard(int l, int r, int s) {
    leftScore = l;
    rightScore = r;
    size = s;
  }
  
  void display(){
    pushStyle();
    
    textFont(font);
    String score = leftScore + "       " +rightScore;
    textAlign(CENTER);
    text(score,width/2,height/8);
    popStyle();
    
  }

  void increaseLeftScore()
  {
    leftScore++;
  }
  
  void increaseLeftScore(int l)
  {
    leftScore+=l;
  }

  void increaseRightScore()
  {
    rightScore++;
  }

  void increaseRightScore(int r)
  {
    rightScore+=r; 
  }

  void reset()
  {
    rightScore=0;
    leftScore=0;
  }
}

