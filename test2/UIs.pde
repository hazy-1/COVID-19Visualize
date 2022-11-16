class UIs {
    UIs() {
    }

    int calcCollision() {
        int colNum = 0;
        for(int i = 0; i < tableLength; i++) {
            if(pointCoord[i].x-10 <= mouseX && mouseX <= pointCoord[i].x+10 && pointCoord[i].y + dist -10 <= mouseY && mouseY <= pointCoord[i].y + dist +10){
                colNum = i;
                break;
            } 
            else colNum = -1;
        }
        return colNum;
    }

    void dispInfoCircle() {
        colorMode(HSB, 360, 100, 100, 100);
        
        int listNum = calcCollision();
        int label = 0;
        if(listNum != -1) {
            for(int j = 0; j < cladeListNum; j++) {
                if( cladeList[j].equals(clade[listNum]) ) {
                    fill(j*10, 90, 80);
                    label = j;
                }
            }
            
            noStroke();
            ellipse(displayWidth-((displayHeight-100)/2+50), displayHeight/2, displayHeight-50, displayHeight-50);

            fill(0, 0, 100);
            textFont(title);
            textAlign(RIGHT);
            text("Clade", displayWidth-((displayHeight-100)/2+50), displayHeight/2);
            textFont(number);
            text(cladeList[label], displayWidth-((displayHeight-100)/2+50), displayHeight/2+25);

            textFont(title);
            text("Date", displayWidth-((displayHeight-100)/2+50), displayHeight/2+60);
            textFont(number);
            text(period[listNum] , displayWidth-((displayHeight-100)/2+50), displayHeight/2+85);

            textFont(title);
            text("Divergence", displayWidth-((displayHeight-100)/2+50), displayHeight/2+130);
            textFont(number);
            text(divergence[listNum] , displayWidth-((displayHeight-100)/2+50), displayHeight/2+155);
        }        
    }

    void scrollBar() {

        if(mousePressed) {
                dist = -1*(map(mouseY, 0, displayHeight, 100, displayY-displayHeight));
                // rect(10, , 25, 25);
                ellipse(10, mouseY, 10, 10);

        }
    }
}
