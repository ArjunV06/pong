class Ball
{
    int xPos;
    int yPos;
    int radius;
    float xVelInitial;
    float yVelInitial;
    float xVel;
    float yVel;
    float xAcc;
    float yAcc;
    boolean collisionCooldown;
    boolean goingDown;
    boolean goingRight;
    int startFrame=0;
    color ballColor=color((255));

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
        yVelInitial=yVel;
        xVelInitial=xVel;
    }

    void display()
    {
        pushStyle();
        fill(ballColor);
        ellipse(xPos,yPos,radius*2,radius*2);
        popStyle();
    }
    void colorSet(color quickC)
    {
        ballColor=quickC;
    }
    void move(Paddle rightp, Paddle left)
    {
        if(yVel>20)
        {
            yVel=yVel-10;
        }
        if(goingRight)
        {
            
            xPos+=xVel;
            xVel+=xAcc;
            yVel-=yAcc;
            

        }
        else
        {
            
            xPos-=xVel;
            xVel+=xAcc;
            if(yVel<5)
            {
                yVel+=yAcc;
            }
            else
            {
                yVel-=yAcc*yVel;
            }
            
            
        }
        if(goingDown)
        {
            /*if(right)
            {
                yPos=constrain(yPos,0+this.radius+30,height-this.radius-30);
                yPos+=yVel*left.speed; //the way this is set up works PERFECT for a power up!!!
                
            }
            else
            {
                yPos=constrain(yPos,0+this.radius+30,height-this.radius-30);
                yPos+=yVel*rightp.speed; //the way this is set up works PERFECT for a power up!!!
            }*/
            
            yPos+=int(yVel);
            
        }
        else
        {
            yPos-=int(yVel);
            
        }
    }
    
    void confine(Paddle left, Paddle right)
    {
        xPos=constrain(xPos,left.xPos+(left.widt/2)+this.radius-2, right.xPos-(right.widt/2)-this.radius+2);
    }
    boolean inBounds(Paddle left, Paddle right)
    {
        //println(this.xPos, (right.xPos-(right.widt/2)), this.xPos, (left.xPos+(left.widt/2)));
        if(this.xPos<=(right.xPos-(right.widt/2)) && (this.xPos>=(left.xPos+(left.widt/2))))
        {
            return true;
        }
        
        else
        {
            return false;
        }

    }
    boolean inBounds()
    {
        if(this.xPos-this.radius>width || this.xPos+this.radius<0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    void speedChange(Paddle paddle)
    {
        yVel*=abs((paddle.speed/10));
        yVel+=random(3);
    }
    boolean inBounds(ScoreBoard sb)
    {
        if(this.xPos-this.radius>width)
        {   
            sb.increaseLeftScore();
            return false;
        }
        else if(this.xPos+this.radius<0)
        {
            sb.increaseRightScore();
            return false;
        }
        else
        {
            return true;
        }
    }
    void reset()
    {
        xPos=width/2;
        yPos=height/2;
        if(random(1)>0.5)
        {
            xVel=xVelInitial;
        }
        else
        {
            xVel=-xVelInitial;
        }
        
        yVel=yVelInitial+random(-15,15);
    }
    /*boolean collisionDetected(Ball ball)
    {
        if(((this.xPos+ball.xPos)/2)==this.xPos+this.radius && ((this.yPos+ball.yPos)/2)==this.yPos+this.radius)
        {
            if(this.xPos!=ball.xPos && this.yPos!=ball.yPos)
            {
                return true;
            }
        return false;
        }
            
        else
        {
            return false;
        }
        
    }*/
    boolean collisionDetected()
    {
        if(this.yPos-this.radius<=0+2)
        {
            return true;
        }
        else if(this.yPos+this.radius>=height-2)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    boolean collisionDetected(Paddle paddle)
    {
        //println(collisionCooldown);
        boolean returnvar=false;
        
        if(collisionCooldown)   //has a significant effect on framerate
        {
            if(startFrame==0)
            {
                startFrame=frameCount;
            }
            else if(frameCount>startFrame+20)
            {
                collisionCooldown=!collisionCooldown;
                startFrame=0;
            }
            //println(startFrame);
        }
        else if(!collisionCooldown)
        {
            int xDis = abs(this.xPos-paddle.xPos-3);
            int yDis = abs(this.yPos-paddle.yPos-3);
            //int cornerCase = ((((xDis - paddle.widt/2))^2) + ((yDis - paddle.heigh/2))^2); //distance formula
           
           
            int topLeftX=paddle.xPos-paddle.widt/2;
            int topLeftY=paddle.yPos-paddle.heigh/2;

            int topRightX=paddle.xPos+paddle.widt/2;
            int topRightY=topLeftY;

            int bottomLeftX=topLeftX;
            int bottomLeftY=paddle.yPos+paddle.heigh/2;

            int bottomRightX=topRightX;
            int bottomRightY=bottomLeftY;

            if(dist(topLeftX,topLeftY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            else if(dist(topRightX,topRightY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            else if(dist(bottomLeftX,bottomLeftY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            else if(dist(bottomRightX,bottomRightY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            

           
           
            else if(xDis > (paddle.widt/2 + this.radius))
            {
                returnvar = false;
                //collisionCooldown=false;
                return returnvar;
            }
            else if(yDis > (paddle.heigh/2 + this.radius))
            {
                returnvar = false;
                //collisionCooldown=false;
                return returnvar;
            }
            else if(xDis <= (paddle.widt/2))
            {
                returnvar = true;
                collisionCooldown=true;
                return returnvar;
            }
            else if(yDis <= (paddle.heigh/2))
            {
                returnvar = true;
                collisionCooldown=true;
                return returnvar;
                
            }
            /* if(cornerCase <= (this.radius^2)) //squared since we didnt sqrt prior
            {
                collisionCooldown=true;
                return true;
            }
           */

            



            
        }
        //return returnvar;
        return false;

    }

    
}