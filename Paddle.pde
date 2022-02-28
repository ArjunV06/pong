class Paddle
{
    int widt;
    int heigh;
    float maxSpeed;
    float speed;
    int xcor;
    int ycor;
    float ease;
    float accel;
    boolean wallcollision;
    float bounceOff;



    Paddle(int wid, int hei, float spe, int x, int y)
    {
        widt=wid;
        heigh=hei;
        maxSpeed=spe;
        xcor=x;
        ycor=y;
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
        xcor=x;
        ycor=y;
        speed=0;
        wallcollision=false;
        bounceOff=bounce;
    }

    void display()
    {
        pushStyle();
        fill(255);
        rect(xcor,ycor,widt,heigh);
        popStyle();
    }

    void displayPower(int x, int y, int sizex, int sizey)
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

    void confine()
    {
        ycor=constrain(ycor,heigh/2+30,height-heigh/2-30);
    }

    void up()
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
        if(ycor>=heigh/2+30 && ycor<=height-(heigh/2+30))
        {
            ycor-=int(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            ycor-=int(speed);
            /*if(ycor>height/2)
            {
                ycor=height-heigh/2-31;
            }
            else
            {
                ycor=heigh/2+31;
            }*/

        }
        
         

    }
    void stopUp()
    {
        if(speed>0+ease)
        {
            speed-=ease;
        }
        else if(speed==ease)
        {
            speed=0;
        }
        if(ycor>=heigh/2+30 && ycor<=height-heigh/2-30)
        {
            ycor-=int(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            ycor-=int(speed);
            /*speed=0;
            if(ycor>height/2)
            {
                ycor=height-heigh/2-31;
            }
            else
            {
                ycor=heigh/2+31;
            }*/
        }
    }


    void down()
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
        if(ycor<=height-heigh/2-30 && ycor>=heigh/2+30)
        {
            ycor-=int(speed);
            wallcollision=false;
            
        }
        else
        {   
            ycor-=int(speed);
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            /*if(ycor>height/2)
            {
                ycor=height-heigh/2-31;
            }
            else
            {
                ycor=heigh/2+31;
            }*/

        }
        
         

    }
    void stopDown()
    {
        if(speed<0-ease)
        {
            speed+=ease;
        }
        else if(abs(speed)==ease)
        {
            speed=0;
        }
        if(ycor<=height-heigh/2-30 && ycor>=heigh/2+30)
        {
            ycor-=int(speed);
            wallcollision=false;
        }
        else
        {
            if(!wallcollision)
            {
                speed=speed*(-bounceOff);
                wallcollision=true;
            }
            
            ycor-=int(speed);
            /*if(ycor>height/2)
            {
                ycor=height-heigh/2-31;
            }
            else
            {
                ycor=heigh/2+31;
            }*/

        }
    }
}