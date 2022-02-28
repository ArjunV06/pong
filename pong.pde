

ScoreBoard sb;
Paddle left;
Paddle right;
int directionLeft=0;
int directionRight=0;
PFont font;
void setup(){
  size(1920,1080,P2D);
  //fullScreen(3);
  //size(displayWidth,displayHeight,P2D);
  sb = new ScoreBoard();
  float acceleration=(height/1080)*0.3;
  float ease=(height/1080)*0.8;
<<<<<<< HEAD
  font = createFont("bit5x3.ttf",128);
=======
  int fontSize=width*10;
  font = createFont("bit5x3.ttf",108);
>>>>>>> 60660512018cf2dffa0dd49e8de56a86b47d1b42
  left = new Paddle(15,120,32,ease,acceleration,150,height/2,0.15); //the third number refers to speed, which is appropximately the max speed that allows you to 
  right = new Paddle(15,120,32,ease,acceleration,width-150,height/2,0.15);
}

void draw(){
  println(frameRate);
  left.confine();
  right.confine();
  //println(left.speed, abs(left.speed), left.maxSpeed,directionLeft,left.accel);
  background(0);
  left.displayPower(width/2-width/4,height-30,width/5,20);
  right.displayPower(width/2+width/4,height-30,width/5,20);
  rectMode(CENTER);
  for(int i = height;i>=0;i-=30)
  {
   rect(width/2,i,10,10);
  }
  sb.display();
  left.display();
  right.display();
  
  switch(directionLeft)
  {
    case 1:
      left.up();
    break;
    case 2:
      left.stopUp();
      left.stopDown();
    break;
    case 3:
      left.down();
    break;
    case 4:
      left.stopDown();
      left.stopUp();
      
  }
 
  switch(directionRight)
  {
    case 1:
      right.up();
    break;
    case 2:
      right.stopUp();
      right.stopDown();
    break;
    case 3:
      right.down();
    break;
    case 4:
      right.stopDown();
      right.stopUp();
    
  }
  
  
  
  
}
void keyPressed() 
{ println(keyCode);
  switch(keyCode)
  {
    case 65:
      sb.increaseLeftScore();
    break;
    case 68:
      sb.increaseRightScore();
    break;
    case 82:
      sb.reset();
    break;
    case 87:
    //case 87:
      directionLeft=1;
    break;
    case 83:
    //case 83:
      directionLeft=3;
    break;
    case 38:
    case 104:
      directionRight=1;
    break;
    case 40:
    case 98:
      directionRight=3;
    
    
  }
}
void keyReleased() 
{
  switch(keyCode)
  {
    case 87:
    //case 87:
      directionLeft=2;
    break;
    case 83:
    //case 83:
      directionLeft=4;
    break;
    case 38:
    case 104:
      directionRight=2;
    break;
    case 40:
    case 98:
      directionRight=4;
  }
}
