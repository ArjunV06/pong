import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pong extends PApplet {



ScoreBoard sb;
Paddle left;
Paddle right;
Ball ball;
int directionLeft=0;
int directionRight=0;
Button test;
PFont font;
boolean rightBool=PApplet.parseBoolean(PApplet.parseInt(random(1)));
public void setup(){
  
  //fullScreen(3);
  //size(displayWidth,displayHeight,P2D);
  //surface.setResizable(true);
  sb = new ScoreBoard();
  float acceleration=(height/1080)*0.4f;
  float ease=(height/1080)*0.8f;
  font = createFont("bit5x3.ttf",128);
  left = new Paddle(15,120,32,ease,acceleration,150,height/2,0.15f); //the third number refers to speed, which is appropximately the max speed that allows you to 
  right = new Paddle(15,120,32,ease,acceleration,width-150,height/2,0.15f);
  ball = new Ball(width/2,height/2,10,0,3,0,30);
  test = new Button(width/2,height/2,500,500);
}

public void draw(){

  println(frameRate);
  left.confine();
  right.confine();
  //println(left.speed, abs(left.speed), left.maxSpeed,directionLeft,left.accel);
  background(0);
  test.showFrame();
  ball.display();
  if(test.leftHover())
  {
    rect(100,100,100,100);
  }
  if(test.leftClick())
  {
    rect(500,500,100,100);
  }
  if(ball.collisionDetected(right) || ball.collisionDetected(left))
  {
    rightBool=!rightBool;
  }
  
  
  ball.move(rightBool);
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
public void keyPressed() 
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
public void keyReleased() 
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
class Ball
{
    int xPos;
    int yPos;
    int radius;
    float xVel;
    float yVel;
    float xAcc;
    float yAcc;
    boolean collisionCooldown;
    int startFrame=0;

    Ball(int xPosl,int yPos_, float xVel_, float yVel_, float xAcc_, float yAcc_, int radius_)
    {

        xPos=xPosl;
        yPos=yPos_;
        xVel=xVel_;
        yVel=yVel_;
        xAcc=xAcc_;
        yAcc=yAcc_;
        radius=radius_;
        collisionCooldown=false;

    }

    public void display()
    {
        ellipse(xPos,yPos,radius*2,radius*2);
    }
    public void move(boolean right)
    {
        if(right)
        {
            xPos+=xVel;

        }
        else
        {
            xPos-=xVel;
        }
    }
    
    public boolean collisionDetected(Paddle paddle)
    {
        boolean returnvar=false;
        
        if(collisionCooldown)   //has a significant effect on framerate
        {
            if(startFrame==0)
            {
                startFrame=frameCount;
            }
            else if(frameCount>startFrame+30)
            {
                collisionCooldown=!collisionCooldown;
            }
            println(startFrame);
        }
        if(!collisionCooldown)
        {
            int xDis = abs(this.xPos-paddle.xPos);
            int yDis = abs(this.yPos-paddle.yPos);
            if(xDis > (paddle.widt/2 + this.radius))
            {
                returnvar = false;
                return returnvar;
            }
            if(yDis > (paddle.heigh/2 + this.radius))
            {
                returnvar = false;
                return returnvar;
            }
            if(xDis <= (paddle.widt/2))
            {
                returnvar = true;
                collisionCooldown=true;
                return returnvar;
            }
            if(yDis <= (paddle.heigh/2))
            {
                returnvar = true;
                collisionCooldown=true;
                return returnvar;
                
            }

            int cornerCase = (((xDis - paddle.widt/2)^2) + ((yDis - paddle.heigh/2)^2)); //for if it is detected in the corner (used distance formula) 

            if(cornerCase <= (ball.radius^2)) //if distance of center of ball to the center of circle <radius^2 aka a radius away from circle
            return true;

            
        }
        return returnvar;

    }

    
}
class Button
{
    int localXpos;
    int localYpos;
    int localWidth;
    int localHeight;
    boolean rightClick;
    boolean leftClick;
    Button(int xPos, int yPos, int width, int height)
    {
        localXpos=xPos;
        localYpos=yPos;
        localHeight=height;
        localWidth=width;
        rightClick=false;
    }
    public void showFrame()
    {
        pushStyle();
        noFill();
        stroke(20);
        strokeWeight(4);
        rectMode(CENTER);
        rect(localXpos,localYpos,localWidth,localHeight);
        popStyle();
    }
    public boolean rightClick()
    {

        if (mousePressed && (mouseButton == RIGHT) && mouseX>(localXpos-localWidth/2) && mouseX<(localXpos+localWidth/2) && mouseY>(localYpos-localHeight/2) && mouseY<(localYpos+localHeight/2))
        {
            rightClick=true;
        }
        else
        {
            rightClick=false;
        }
        return rightClick;

    }
    public boolean leftClick()
    {
        if (mousePressed && (mouseButton == LEFT) && mouseX>(localXpos-localWidth/2) && mouseX<(localXpos+localWidth/2) && mouseY>(localYpos-localHeight/2) && mouseY<(localYpos+localHeight/2))
        {
            leftClick=true;
        }
        else
        {
            leftClick=false;
        }
        return leftClick;
    }

    public boolean leftHover()
    {
        if(mouseX>(localXpos-localWidth/2) && mouseX<(localXpos+localWidth/2) && mouseY>(localYpos-localHeight/2) && mouseY<(localYpos+localHeight/2))
        {
            return true;
        }
        else
        {
            return false;
        }
        

    }



}
class Paddle
{
    int widt;
    int heigh;
    float maxSpeed;
    float speed;
    int xPos;
    int yPos;
    float ease;
    float accel;
    boolean wallcollision;
    float bounceOff;



    Paddle(int wid, int hei, float spe, int x, int y)
    {
        widt=wid;
        heigh=hei;
        maxSpeed=spe;
        xPos=x;
        yPos=y;
        ease=0;
        accel=0;
        speed=0;
        wallcollision=false;
    }
    

    Paddle(int wid, int hei, float spe, float eas, float acc, int x, int y, float bounce)
    {
        widt=wid;
        heigh=hei;
        maxSpeed=spe;
        ease=eas;
        accel=acc;
        xPos=x;
        yPos=y;
        speed=0;
        wallcollision=false;
        bounceOff=bounce;
    }

    public void display()
    {
        pushStyle();
        fill(255);
        rect(xPos,yPos,widt,heigh);
        popStyle();
    }

    public void displayPower(int x, int y, int sizex, int sizey)
    {
        pushStyle();
        rectMode(CENTER);
        noFill();
        stroke(255);
        rect(x,y,sizex,sizey);
        strokeWeight(4);
        line(x,y-sizey/2+2,x,y+sizey/2-2);
        fill(255);
        noStroke();
        rectMode(CORNER);
        float quickStore=sizex/maxSpeed/2;
        float quickStore2=quickStore*speed;
        rect(x,y-sizey/2,quickStore2,sizey);
        popStyle();
    }

    public void confine()
    {
        yPos=constrain(yPos,heigh/2+30,height-heigh/2-30);
    }

    public void up()
    {
        if(abs(speed)<=maxSpeed)
        {
            speed+=accel;
            if(abs(speed)<=((maxSpeed-abs(speed/40))))
            {
                speed+=abs(speed/40);
            }
            
        }
        //println(heigh/2-height);
        if(yPos>=heigh/2+30 && yPos<=height-(heigh/2+30))
        {
            yPos-=PApplet.parseInt(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            yPos-=PApplet.parseInt(speed);
            /*if(yPos>height/2)
            {
                yPos=height-heigh/2-31;
            }
            else
            {
                yPos=heigh/2+31;
            }*/

        }
        
         

    }
    public void stopUp()
    {
        if(speed>0+ease)
        {
            speed-=ease;
        }
        else if(speed==ease)
        {
            speed=0;
        }
        if(yPos>=heigh/2+30 && yPos<=height-heigh/2-30)
        {
            yPos-=PApplet.parseInt(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            yPos-=PApplet.parseInt(speed);
            /*speed=0;
            if(yPos>height/2)
            {
                yPos=height-heigh/2-31;
            }
            else
            {
                yPos=heigh/2+31;
            }*/
        }
    }


    public void down()
    {
        
        if(abs(speed)<=maxSpeed)
        {
            speed-=accel;
            if(abs(speed)<=(maxSpeed-abs(speed/40)))
            {
                //println("hello");
                speed-=abs(speed/40);
            }
        }
            
       // }
        //println(heigh/2-height);
        if(yPos<=height-heigh/2-30 && yPos>=heigh/2+30)
        {
            yPos-=PApplet.parseInt(speed);
            wallcollision=false;
            
        }
        else
        {   
            yPos-=PApplet.parseInt(speed);
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            /*if(yPos>height/2)
            {
                yPos=height-heigh/2-31;
            }
            else
            {
                yPos=heigh/2+31;
            }*/

        }
        
         

    }
    public void stopDown()
    {
        if(speed<0-ease)
        {
            speed+=ease;
        }
        else if(abs(speed)==ease)
        {
            speed=0;
        }
        if(yPos<=height-heigh/2-30 && yPos>=heigh/2+30)
        {
            yPos-=PApplet.parseInt(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            yPos-=PApplet.parseInt(speed);
            /*if(yPos>height/2)
            {
                yPos=height-heigh/2-31;
            }
            else
            {
                yPos=heigh/2+31;
            }*/

        }
    }
}
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
  
  public void display(){
    pushStyle();
    
    textFont(font);
    String score = leftScore + "       " +rightScore;
    textAlign(CENTER);
    text(score,width/2,height/8);
    popStyle();
    
  }

  public void increaseLeftScore()
  {
    leftScore++;
  }
  
  public void increaseLeftScore(int l)
  {
    leftScore+=l;
  }

  public void increaseRightScore()
  {
    rightScore++;
  }

  public void increaseRightScore(int r)
  {
    rightScore+=r; 
  }

  public void reset()
  {
    rightScore=0;
    leftScore=0;
  }
}

  public void settings() {  size(1920,1080,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
