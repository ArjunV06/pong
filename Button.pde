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
    void ShowFrame()
    {
        noFill();
        stroke(20);
        rectMode(CENTER);
        rect(localXpos,localYpos,localWidth,localHeight);
    }
    boolean RightClick()
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
    boolean LeftClick()
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

}