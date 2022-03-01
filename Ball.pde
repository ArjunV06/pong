class Ball
{
    int xPos;
    int yPos;
    int radius;
    float xVel;
    float yVel;
    float xAcc;
    float yAcc;

    Ball(int xPosl,int yPos_, float xVel_, float yVel_, float xAcc_, float yAcc_, int radius_)
    {

        xPos=xPosl;
        yPos=yPos_;
        xVel=xVel_;
        yVel=yVel_;
        xAcc=xAcc_;
        yAcc=yAcc_;
        radius=radius_;

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
        int xDis = abs(this.xPos-paddle.xPos);
        int yDis = abs(this.yPos-paddle.yPos);
        if(xDis > (paddle.widt/2 + this.radius))
        {
            return false;
        }
        if(yDis > (paddle.heigh/2 + this.radius))
        {
            return false;
        }
        if(xDis <= (paddle.widt/2))
        {
            return true;
        }
        if(yDis <= (paddle.heigh/2))
        {
            return true;
        }

        int cornerCase = (((xDis - paddle.widt/2)^2) + ((yDis - paddle.heigh/2)^2)); //for if it is detected in the corner (used distance formula) 

        return (cornerCase <= (ball.radius^2)); //if distance of center of ball to the center of circle <radius^2 aka a radius away from circle


    }
}