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

    void display()
    {
        ellipse(xPos,yPos,radius*2,radius*2);
    }
    void move(boolean right, boolean down, Paddle rightp, Paddle left)
    {
        if(right)
        {
            
            xPos+=xVel;
            

        }
        else
        {
            
            xPos-=xVel;
            
        }
        if(down)
        {
            if(right)
            {
                yPos+=yVel*left.speed; //the way this is set up works PERFECT for a power up!!!
                yPos=constrain(yPos,0+this.radius,height-this.radius);
            }
            
        }
        else
        {
            yPos-=yVel;
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
    boolean inBounds(ScoreBoard sb)
    {
        if(this.xPos-this.radius>width)
        {   
            sb.increaseRightScore();
            return false;
        }
        else if(this.xPos+this.radius<0)
        {
            sb.increaseLeftScore();
            return false;
        }
        else
        {
            return true;
        }
    }
    void reset()
    {
        ball.xPos=width/2;
        ball.yPos=height/2;
    }
    boolean collisionDetected()
    {
        if(this.yPos-this.radius<=0)
        {
            return true;
        }
        else if(this.yPos+this.radius>=height)
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
            else if(frameCount>startFrame+45)
            {
                collisionCooldown=!collisionCooldown;
            }
            //println(startFrame);
        }
        if(!collisionCooldown)
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

            if(dist(topRightX,topRightY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            if(dist(bottomLeftX,bottomLeftY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            if(dist(bottomRightX,bottomRightY,this.xPos,this.yPos)<=this.radius+1)
            {
                collisionCooldown=true;
                return true;
                
            }

            

           
           
            if(xDis > (paddle.widt/2 + this.radius))
            {
                returnvar = false;
                collisionCooldown=false;
                return returnvar;
            }
            if(yDis > (paddle.heigh/2 + this.radius))
            {
                returnvar = false;
                collisionCooldown=false;
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