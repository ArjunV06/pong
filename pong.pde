
ArrayList<Ball> balls = new ArrayList<Ball>();
ScoreBoard sb;
Paddle left;
Paddle right;
Ball ball;
int directionLeft=0;
int directionRight=0;
int screen=0;
Button settingsButton;
Button startButton;
Button tutorialButton;
Button pongButton;
boolean crazyMode;
boolean deleteCrazy=false;
PFont font;
PFont sbFont;
//boolean quick.goingRight=boolean(int(random(0,1)));
//boolean quick.goingDown=boolean(int(random(0,1)));
Button mainMenu;

void setup()
{
  
  size(1920,1080,P2D);
  //smooth(8);
  frameRate(60);
  //fullScreen();
  //size(displayWidth,displayHeight,P2D);
  //surface.setResizable(true);
  sb = new ScoreBoard();
  float acceleration=(height/1080)*0.4;
  float ease=(height/1080)*0.8;
  font = createFont("arturito.ttf",128);
  sbFont = createFont("bit5x3.ttf",128);
  left = new Paddle(15,120,32,ease,acceleration,150,height/2,0.15); //the third number refers to speed, which is appropximately the max speed that allows you to 
  right = new Paddle(15,120,32,ease,acceleration,width-150,height/2,0.15);
  balls.add(new Ball(width/2,height/2,10,3,0.005,0.005,8));
  ball = new Ball(width/2,height/2,10,3,0.005,0.005,8);
  textAlign(CENTER, CENTER);
  settingsButton = new Button();
  startButton = new Button();
  tutorialButton = new Button();
  pongButton = new Button();
  mainMenu = new Button();


}

void draw(){
  background(0);
  switch(screen)
  {
    case(2):
      pushStyle();
      textSize(64);
      text("PRESS TAB TO UNPAUSE",width/2,100);
      text("PRESS CONTROL TO GO TO MAIN MENU",width/2,height/2);
      text("PRESS SHIFT TO RESET GAME",width/2,height-100);
      textSize(12);
      
      popStyle();
    break;
    case(0):
      pongButton.display(width/2,200,300,100,"PONG",165,false);

      //settingsButton.display(width/3,height/2,600,300,"SETTINGS",64,true);
      //settingsButton.hover();

      startButton.display(width/3,height/2,400,200,"PLAY",64,true);
      startButton.hover();
      if(startButton.leftClick())
      {
        screen++;
      }
    break;
      
    case(1):
      //println(frameRate);
      //println(ball.xVel, ball.yVel);
      left.confine();
      right.confine();
      //ball.confine(left, right);
      //println(left.speed, abs(left.speed), left.maxSpeed,directionLeft,left.accel);
      println(balls.size(),frameRate);
      if(deleteCrazy && frameCount%1==0 && balls.size()>1)
      {
        int del=balls.size();
        int count=1;
        while(count<5 && balls.size()>1)
        {
          balls.remove(del-1);
          //Ball delQuick=balls.get(0);
          //delQuick.reset();
          del--;
          count++;
        }
        
        
        
        
    
    
        
      }
      else
      {
        deleteCrazy=false;
      }
       
      /*if(frameCount%1==0 && crazyMode)
      {
        balls.add(new Ball(width/2,height/1,10,3,0.005,0.005,int(random(2,18))));
        color quickColor = color(int(random(255)),int(random(255)),int(random(255)));
        Ball quick = balls.get(balls.size()-1);
        quick.colorSet(quickColor);
        balls.add(new Ball(width/2,height/2,10,3,0.005,0.005,int(random(2,18))));
        quickColor = color(int(random(255)),int(random(255)),int(random(255)));
        quick = balls.get(balls.size()-1);
        quick.colorSet(quickColor);
        balls.add(new Ball(width/2,height/3,10,3,0.005,0.005,int(random(2,18))));
        quickColor = color(int(random(255)),int(random(255)),int(random(255)));
        quick = balls.get(balls.size()-1);
        quick.colorSet(quickColor);
        balls.add(new Ball(width/2,height/4,10,3,0.005,0.005,int(random(2,18))));
        quickColor = color(int(random(255)),int(random(255)),int(random(255)));
        quick = balls.get(balls.size()-1);
        quick.colorSet(quickColor);
        balls.add(new Ball(width/2,height/5,10,3,0.005,0.005,int(random(2,18))));
    
    
        quickColor = color(int(random(255)),int(random(255)),int(random(255)));
        quick = balls.get(balls.size()-1);
        quick.colorSet(quickColor);
      }*/
      if(frameCount%1==0 && crazyMode)
      {
        
        for(int i=0;i<10;i++)
        {
          int inScreen=i*(height/10);
          if(inScreen<20)
          {
            inScreen+=10;
          }
          else if(inScreen>height-20)
          {
            inScreen-=10;
          }
          if(random(1)<0.7)
          {
            balls.add(new Ball(width/2,inScreen,10,random(-3,3),0.005,0.005,int(random(2,18))));
            color quickColor = color(int(random(255)),int(random(255)),int(random(255)));
            Ball quick = balls.get(balls.size()-1);
            quick.colorSet(quickColor);

          }

          
        }
      }
      for(int i=0; i<balls.size(); i++)
      {
        
        Ball quick = balls.get(i);
        /*for(int j=0; j<balls.size(); j++)
        {
          Ball quickagain =  balls.get(j);
          if(quick.collisionDetected(quickagain))
          {
            quick.xVel*=-1;
            quick.yVel*=-1;
          }
        }*/
        
        quick.display();
        
        
        
          //if(ball.inBounds(left,right))
        
          //rect(100,100,100,100);
          if(quick.collisionDetected(right))
          {
            if(right.speed>0)
            {
              quick.goingDown=false;
            }
            else
            {
              quick.goingDown=true;
            }
            quick.goingRight=!quick.goingRight;
            quick.speedChange(right);

            
            
            
            
            
          }
          else if(quick.collisionDetected(left))
          {

            if(left.speed>0)
            {
              quick.goingDown=false;
            }
            else
            {
              quick.goingDown=true;
            }

            quick.goingRight=!quick.goingRight;
            quick.speedChange(left);
          
          }
          else if(quick.collisionDetected())
          {
            quick.goingDown=!quick.goingDown;
          }
          
        
        
        
        if(quick.inBounds(sb))
        {
          quick.move(right,left);
        }
        else
        {
          quick.reset();
        }
      }
      
    



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
    break;
      
      
      
  }

}
  
void keyPressed() 
{ 

  println(keyCode);
  switch(screen)
  {
    case 1:
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
        break;
        
        
        
      }
    break;
  
    
    
  }       
  if(keyCode==9)
  {
    switch(screen)
    {
      case 1:
        screen=2;
      break;
      case 2:
        screen=1;
      break;
    }
      
  }
  if(keyCode==16)
  {
    switch(screen)
    {
      case 2:
        resetAll();
        screen=1;
      break;
    }
  }
  if(keyCode==17)
  {
    
    
      
        resetAll();
        screen=0;
      
    

  }
  if(keyCode==32)
  {
    deleteCrazy=false;
    balls.add(new Ball(width/2,height/2,10,3,0.005,0.005,int(random(2,18))));
    
    
      color quickColor = color(int(random(255)),int(random(255)),int(random(255)));
      Ball quick = balls.get(balls.size()-1);
      quick.colorSet(quickColor);
     
  }
  if(keyCode==45)
  {
    if(balls.size()>1)
    balls.remove(balls.size()-1);
    deleteCrazy=false;
  }
  if(keyCode==67)
  {
    deleteCrazy=false;
    crazyMode=!crazyMode;
  }
  if(keyCode==88)
  {
    crazyMode=false;
    deleteCrazy=true;
  }

  
  
}
void resetAll()
{
  deleteCrazy=false;
  crazyMode=false;
  sb.reset();
  for(int i=balls.size(); i>1; i--)
  {
    balls.remove(i-1);
    Ball delQuick=balls.get(0);
    delQuick.reset();
    
    
  }
  
  right.reset();
  left.reset();
}
void keyReleased() 
{
  switch(screen)
  {
    case 1:
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
    break;


  }
  
}
