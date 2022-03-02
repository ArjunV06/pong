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
    void move(boolean right)
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
    
    boolean collisionDetected(Paddle paddle)
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