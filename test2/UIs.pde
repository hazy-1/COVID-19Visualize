class UIs {
    int basePosX, basePosY;
    PVector scallPointPos;

    UIs() {
        scallPointPos = new PVector(50 + 25, 25 + 25);
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
        colorMode(HSB, 360, 100, 100);
        
        int sDataNum = 23605-21569;

        // シータ
        float theta;
        // 円の半径
        float r = 300;
        //円の各点の座標
        float x = 0;
        float y = 0;
        
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
            beginShape();
                for(int i = 0; i < sDataNum+2; i++){
                    theta = radians( map(i, 0, sDataNum+2, 0, 360) );
                    // if(!mutData[listNum][0].equals("0")){
                    //     for(int j = 0; j < mutData[listNum].length; j++){
                    //         String[] mutDataSpliter = mutData[listNum][j].split(",");
                    //         if(int(mutDataSpliter[0]) >= 21569 && int(mutDataSpliter[0]) <= 23605) {
                    //             if(map(float(mutDataSpliter[0]), 21569, 23605, 0, sDataNum) == float(i)){
                    //                 println("yes");
                    //                 r = map(float(mutDataSpliter[1]), 1, 27, 500, (displayHeight-50)/2);
                    //                 break;
                    //             }
                    //         }
                    //         else r = 300;
                    //     }

                    // }
                    x = r * ((s1Divergence[listNum]+1)*0.5) * cos(theta) + displayWidth-(displayHeight/2+25);
                    y = r * ((s1Divergence[listNum]+1)*0.5) * sin(theta) + displayHeight/2;                    
                    curveVertex(x, y);
                }
            endShape();

            // stroke(0, 0 ,100);
            // strokeWeight(2);
            // noFill();
            // line( (displayWidth-((displayHeight-100)/2+50)) - (r *((s1Divergence[listNum]+1)*0.5)), displayHeight/2, (displayWidth-((displayHeight-100)/2)), displayHeight/2);
            // fill(0, 0, 100);

            // textFont(title);
            // textAlign(RIGHT);
            // text("name", displayWidth-((displayHeight-100)/2+50), displayHeight/2-50);
            // textFont(number);
            // text(name[listNum], displayWidth-((displayHeight-100)/2+50), displayHeight/2-25);

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

            // textFont(title);
            // text("S-1Divergence", displayWidth-((displayHeight-100)/2+50), displayHeight/2+130);
            // textFont(number);
            // text(divergence[listNum] , displayWidth-((displayHeight-100)/2+50), displayHeight/2+155);


            textFont(title);
            text("Country", displayWidth-((displayHeight-100)/2+50), displayHeight/2+200);
            textFont(number);
            text(country[listNum] , displayWidth-((displayHeight-100)/2+50), displayHeight/2+225);
        }        
    }

    void scrollBar() {
        if(mousePressed) {
                dist = -1*(map(mouseY, 0, displayHeight, -0, displayY-displayHeight));
                ellipse(10, mouseY, 10, 10);
        }
    }

    void divergenceMemory() {
        int x;
        basePosX = 45;
        basePosY = 60;
        textAlign(LEFT);
        textFont(title);
        fill(0, 0, 100);
        text("Divergence", basePosX, basePosY);
        for(int i = 0; i <= 93; i += 10) {
            
            x = (int)map(i, 0, 90, basePosX+5, displayWidth-50);
            textAlign(CENTER);
            text(i, x, basePosY+20);
            strokeWeight(1);
            stroke(0, 0, 100);  
            line(x, basePosY+20+5, x, basePosY+20+15);
        }
    }

    void scallBar() {
        basePosX = 50;
        basePosY = 25;
        int ellipseSize = 50;
        

        fill(0, 0, 0, 0);
        rect(basePosX, basePosY, displayWidth-basePosX*2, ellipseSize);
        fill(0, 0, 0);
        calcScrollPos(basePosX, basePosY, ellipseSize);
        ellipse(scallPointPos.x, scallPointPos.y, ellipseSize, ellipseSize);
    }

    void calcScrollPos(int basePosX, int basePosY, int ellipseSize) {
        boolean trigger = false;
        float distMarker = 0;
        float x = 0;

        fill(0, 0, 0, 0);
        // スクロールバー圏内にマウスがいるか
        if(scallPointPos.x-ellipseSize/2 <= mouseX && scallPointPos.x+ellipseSize/2 >= mouseX && scallPointPos.y-ellipseSize/2 <= mouseY && scallPointPos.y+ellipseSize/2 >= mouseY) {
            fill(0, 0, 100);
            if(mousePressed) {
                trigger = true;
                distMarker = mouseX;
                x = scallPointPos.x;
            }
            else trigger = false;
        }

        if(trigger) {
            scallPointPos.set( mouseX, scallPointPos.y );
        }
    }

    void circleScallLine() {
    }
}
