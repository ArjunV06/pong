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
    void showFrame()
    {
        pushStyle();
        noFill();
        stroke(20);
        strokeWeight(4);
        rectMode(CENTER);
        rect(localXpos,localYpos,localWidth,localHeight);
        popStyle();
    }
    boolean rightClick()
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
    boolean leftClick()
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

    boolean hover()
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