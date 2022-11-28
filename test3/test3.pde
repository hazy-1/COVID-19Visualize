import java.util.Calendar;

CovidMap covidmap;
UIs ui;

PGraphics mapPos;
PVector[] pointCoord;
PFont title, number;

int tableLength;
int displayX, displayY;
float dist = 0;

//日付
String[] period;  
String[] country;
Calendar cal; 
String[] periodList;
int dateNum;

//世代数
float[] divergence;
//系統
String[] clade;
//系統list
String[] cladeList;
int cladeListNum;

void setup() {
    fullScreen();
    frameRate(4);
    // size(500, 500);
    pixelDensity(displayDensity());

    colorMode(HSB, 360, 100, 100, 100);
    background(255, 0, 0);


    title = createFont("TWKLausannePan-450.otf", 14);
    number = createFont("TWKLausannePan-450.otf", 24);

    covidmap = new CovidMap();
    covidmap.loadData();
    covidmap.setData();

    ui = new UIs();
}

void draw() {
    background(0, 0, 0);
    covidmap.dispMap();
    ui.dispInfoCircle();
    ui.scrollBar();
    ui.divergenceMemory();
    image(mapPos, 0, dist);
    // ui.scallBar();
}
