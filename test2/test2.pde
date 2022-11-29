import java.util.Calendar;

CovidMap covidmap;
UIs ui;
Mutations mutations;

PGraphics mapPos;
PVector[] pointCoord;
PFont title, number;
Table strains;    

int tableLength;
int displayX, displayY;
float dist = 0;

//21569-23605
//名前
String[] name;  
//日付
String[] period;  
String[] country;
Calendar cal; 
String[] periodList;
int dateNum;

//世代数
float[] divergence;
//S1の世代数
float[] s1Divergence;

//系統
String[] clade;
//系統list
String[] cladeList;
int cladeListNum;

//ミュータント遺伝子情報
String[][] mutData;

//S1orDivergenceの切り替え
int switchFlag = 0;

void setup() {
     fullScreen(2);
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

    mutations = new Mutations();
    ui = new UIs();

    mutations.loadData();
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
