class Button
{
    int localXpos;
    int localYpos;
    int localWidth;
    int localHeight;
    boolean rightClick;
    boolean leftClick;
    Button()
    {
        
    }
    void display(int xPos, int yPos, int width, int height, String text, int fontSize, boolean trueb)
    {
        localXpos=xPos;
        localYpos=yPos;
        localHeight=height;
        localWidth=width;
        rightClick=false;
        pushStyle();
        textAlign(CENTER,CENTER);
        textFont((font),fontSize);
        text(text,xPos,yPos);
        noFill();
        stroke(255);
        strokeWeight(8);
        rectMode(CENTER);
        if(trueb)
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
            pushStyle();
            rectMode(CENTER);
            fill(80,100);
            rect(localXpos,localYpos,localWidth,localHeight);
            popStyle();
            return true;
        }
        else
        {
            return false;
        }
        

    }



}