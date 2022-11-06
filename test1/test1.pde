Table strains;

int[] period;
float[] divergence;
String[] label;
String[] title;
int tableLength, labelNum;
int dateNum;

void setup() {
    fullScreen(2);
    pixelDensity(displayDensity());

    colorMode(HSB, 360, 100, 100);
    background(0, 0, 0);

    strains = loadTable("../data/strains3.csv");
    tableLength = strains.getRowCount()-1;
    
    labelNum = 29;
    loadData();
    drawPoints();
}

void draw() {
}

void loadData() {
    period = new int[tableLength];
    divergence = new float[tableLength];
    int labelNum = 29;
    label = new String[labelNum];
    title = new String[tableLength];
    
    label[0] ="19A";

    String data;
    int counter = 0;

    boolean match = false;
    
    for(int i = 1; i <= tableLength; i++) {
        // data = strains.getString(i, 2);
        // period[i-1] = Integer.valueOf(data);

        data = strains.getString(i, 7);
        divergence[i-1] = float(data);

        data = strains.getString(i, 8);
        title[i-1] = data;

        for(int j = 0; j < counter; j++) {
            // if(label[j] == strains.getString(i, 8)) println("yes!!");
            if( label[j].equals(strains.getString(i, 8)) ) match = true;
        }
        if(match == false) {
            label[counter] = strains.getString(i, 8);
            counter++;
        }
        match = false;
    }

    println(label);
}

void drawPoints() {
    float x, y;
    float periodMapper;
    float offset = displayWidth;

    noStroke();
    fill(10, 90,80);
    ellipse(50+(displayHeight-50-50)/2, 50+(displayHeight-50-50)/2, displayHeight-50-50, displayHeight-50-50);

    fill(0, 0, 0, 200);
    rect(50, displayHeight/3-50, displayWidth-50-50, displayHeight-displayHeight/3);
    
    for(int i = 0; i < tableLength; i++) {
        
        colorMode(HSB);

   

        x = map(divergence[i], 0, 93, 50, displayWidth-50);
        y = map(i, 0, tableLength, displayHeight/3, displayHeight-50);
        strokeWeight(2.5);
        stroke(0, 0, 100);
        point(x, y);

        strokeWeight(2);
        for(int j = 0; j < labelNum; j++) {
           if( label[j].equals(title[i]) ) stroke(40+j, 90, 80);
        }
        point(x, y);
    }
}

// void setLabel() {
//    label = new String[labelNum];

//    int counter = 0;

//    for(int i = 1; i < tableLength; i++) {
//        for(int j = 0; j < labelNum; j++) {
//            if(strains.getString(i, 8) == label[j]) {

//            }
//            else 
//        }
//        label[counter] = strains.getString(i, 8);
//    }
// }
