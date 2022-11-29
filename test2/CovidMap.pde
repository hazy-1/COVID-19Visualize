class CovidMap {
    // Table strains;    

    CovidMap() {
        displayY = displayHeight*10;
        mapPos = createGraphics(displayWidth, displayHeight*10);  
        // mapPos = createGraphics(displayWidth, 4000);  
        // strains = loadTable("../data/strains3.csv"); 
        strains = loadTable("../data/strains5.csv"); 
        tableLength = strains.getRowCount()-1;

        //系統の初期設定
        cladeListNum = 29;
        cladeList = new String[cladeListNum];
        clade = new String[tableLength];

        //世代の初期設定
        divergence = new float[tableLength];
        //s1の初期設定
        s1Divergence = new float[tableLength];

        //日付の初期設定
        period = new String[tableLength];
        //日数の格納庫
        dateNum = 1017;
        periodList = new String[dateNum];       
        cal = Calendar.getInstance();
        cal.set(2019, 11, 28);

        //国ラベルの初期化
        country = new String[tableLength];
        
        pointCoord = new PVector[tableLength]; 

        mapPos.beginDraw();
        mapPos.colorMode(HSB, 360, 100, 100);
        mapPos.endDraw();
    }

    void loadData() {
        boolean matchFlag = false;
        int counter = 0;

        String month, day;

        String data;
        for(int i = 0; i < dateNum; i++) {  
            //CSVと表記を同様にする処理
            //Monthの処理
            if(0 <= cal.get(Calendar.MONTH) && cal.get(Calendar.MONTH) <= 8 ) month = "0" + String.valueOf( cal.get(Calendar.MONTH)+1 );
            else month = String.valueOf( cal.get(Calendar.MONTH) +1);

            //Dayの処理
            if(1 <= cal.get(Calendar.DATE) && cal.get(Calendar.DATE) <= 9 ) day = "0" + String.valueOf( cal.get(Calendar.DATE) );
            else day = String.valueOf( cal.get(Calendar.DATE) );

            periodList[i] = (String)( cal.get(Calendar.YEAR) + "/" + month + "/" + day );
            cal.add(Calendar.DATE, 1);
        }
        for(int i = 1; i <= tableLength; i++) {
            //世代数の抽出
            data = strains.getString(i, 7);
            divergence[i-1] = float(data);

            //世代数の抽出
            data = strains.getString(i, 11);
            s1Divergence[i-1] = float(data);

            //系統の抽出
            data = strains.getString(i, 8);
            clade[i-1] = data;

            //期間の抽出
            data = strains.getString(i, 2);
            period[i-1] = data;

            //国の抽出
            data = strains.getString(i, 4);
            country[i-1] = data;

            //cladeListのセット
            for(int j = 0; j < counter; j++) {
                if( cladeList[j].equals(strains.getString(i, 8)) ) matchFlag = true;
            }
            if(matchFlag == false) {
                cladeList[counter] = strains.getString(i, 8);
                counter++;
            }
            matchFlag = false;
        }
    }

    void setData(){
        float periodMapper;
        int offset = 50;

        int dateMapper = 0;
        int counter = 0;
    
        for(int i = 0; i < tableLength; i++) {   
            for(int j = 0; j < dateNum; j++) {
                if(period[i].equals(periodList[j])) {
                    counter++;
                    dateMapper = j;
                }
            }     
            pointCoord[i] = new PVector( map(divergence[i], 0, 93, offset, displayWidth - offset), map(dateMapper, 0, dateNum, offset+150, displayY-offset));
            // pointCoord[i] = new PVector( map(s1Divergence[i], 0, 33, offset, displayWidth - offset), map(dateMapper, 0, dateNum, offset+150, displayY-offset));
        }
    }

    void dispMap() {
        mapPos.beginDraw();
        mapPos.background(360, 100, 100, 0);
        for(int i = 0; i < tableLength; i++ ) {     
                mapPos.strokeWeight(1);
                mapPos.stroke(0, 0, 50);
                mapPos.textAlign(RIGHT);
            if(period[i].equals("2020/01/01")) {
                mapPos.textFont(title);
                mapPos.text(2020, displayWidth-45, pointCoord[i].y-10);
                mapPos.line(10, pointCoord[i].y-8, displayWidth-50, pointCoord[i].y-8);
            }
            else if(period[i].equals("2021/01/01")) {
                mapPos.textFont(title);
                mapPos.text(2021, displayWidth-45, pointCoord[i].y-10);
                mapPos.line(10, pointCoord[i].y-8, displayWidth-50, pointCoord[i].y-8);
            }
            else if(period[i].equals("2022/01/01")) {
                mapPos.textFont(title);
                mapPos.text(2022, displayWidth-50, pointCoord[i].y-10);
                mapPos.line(10, pointCoord[i].y-8, displayWidth-50, pointCoord[i].y-8);
            }

            mapPos.strokeWeight(7);
            for(int j = 0; j < cladeListNum; j++) {                
                if( cladeList[j].equals(clade[i]) ) mapPos.stroke(j*10, 90, 80);
            }
            mapPos.point(pointCoord[i].x, pointCoord[i].y);
        }
        mapPos.endDraw();
    }
}
