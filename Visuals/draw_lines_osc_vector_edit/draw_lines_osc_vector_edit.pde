// library oscP5 is required
import oscP5.*;
int oscPort = 12000; // port to listen for osc messages
int linesMax = 500; //number of lines that will be drawn
float lerpFactor = 0.5; // scaling of drawing
float scaleFactor = 1; // scaling of drawing
int offSetX = 0; // x and y offset of drawing
int offSetY = 0;
PVector centroid = new PVector(0,0);
PVector centroid_old = new PVector(0,0);
PVector middle;
boolean initCentroid = true;
int frameRate = 25;
OscP5 oscP5;

ArrayList<ColouredLine> linesList, linesListCopy;

void setup() {
  size(1000, 1000);
  linesList = new ArrayList<ColouredLine>();
  oscP5 = new OscP5(this, oscPort); 
  colorMode(HSB, 100);
  frameRate(frameRate);
}

void draw() { 
  background(0); //black
  scale(scaleFactor); //zoom
  // hack against sudden jumps
  float d = centroid_old.dist(centroid);
  if(d > 100){
    centroid_old = centroid.copy();
  };
  centroid_old.lerp(centroid, lerpFactor);
  
  translate((width / (2 * scaleFactor)) - centroid_old.x + offSetX, (height / (2 * scaleFactor)) - centroid_old.y + offSetY);

  for (int i = 0; i <= linesList.size() - 1; i++) { 
    float alphaNow = ((i / float(linesList.size())) * 256); // i * 2 
    ColouredLine currentLine = linesList.get(i);
    currentLine.display(int(alphaNow));  
  }
}

// this function is called whenever an osc message arrives
// osc-parsing
void oscEvent(OscMessage message) {
  
  // check the addresse and do the according action
  if(message.checkAddrPattern("/lines")==true) {
    
    // call function which will draw the lines
    oscToLine(message); 
  } else if(message.checkAddrPattern("/reset")==true) {
    initCentroid = true;
    linesList = new ArrayList<ColouredLine>();
  } else if(message.checkAddrPattern("/linesMax")==true){
    
    // change the number of lines which will be drawn
    linesMax = message.get(0).intValue();
  } else if(message.checkAddrPattern("/lerpFactor")==true){
    lerpFactor = message.get(0).floatValue();
    
  } else if(message.checkAddrPattern("/scale")==true){
    
    // change the scaling of the drawing
    scaleFactor = message.get(0).floatValue();

  } else if(message.checkAddrPattern("/offsetX")==true){
    
    // translate drawing by an offset
    offSetX = message.get(0).intValue();
  } else if(message.checkAddrPattern("/offsetY")==true){
    offSetY = message.get(0).intValue();
  } else if(message.checkAddrPattern("/offsetXY")==true){
    offSetX = message.get(0).intValue();
    offSetY = message.get(1).intValue();
  }
}

void oscToLine(OscMessage message) {
  // find out how many lines are sent ++++
  // one line requires four numbers (two points with x and y) and has one color/level-parameter. so to calculate how many are sent we divide by five
  int numLines = message.typetag().length() / 9; 

  
  // add new lines to list
  for(int i = 0; i < numLines; i++) { 
    int j = i * 9; //find the right position in the array according to the number of the line
    linesList.add(new ColouredLine(
      new PVector(message.get(0 + j).intValue(), message.get(1 + j).intValue()),   //gets coordinate x and y of p1
      new PVector(message.get(2 + j).intValue(), message.get(3 + j).intValue()),   //gets coordinate x and y of p2    
      message.get(4 + j).floatValue(),  // branch Level
      message.get(5 + j).floatValue(),  // volume
      message.get(6 + j).intValue(),  // baseColor
      message.get(7 + j).floatValue() / frameRate, // duration, divide by frameRate to calculate Increment
      message.get(8 + j).intValue()
    ));
  };
  
  centroid.set(0,0);
  for (int i = 0; i <= linesList.size() - 1; i++) { 
    ColouredLine currentLine = linesList.get(i);
    PVector addMe = new PVector(currentLine.p1.x, currentLine.p1.y); 
    centroid.add(addMe);
  };
  
  centroid.div((linesList.size()));
  if(initCentroid){
    centroid_old = centroid.copy();
    initCentroid = false;
 };
    
  // remove old lines whenever the arrayList gets bigger than linesMax
  while (linesList.size() > linesMax) {
      linesList.remove(0);  
  };
}

class ColouredLine 
{
  PVector p1;
  PVector p2;
  float branchLevel;
  float volume;
  int baseColor;
  float lerpChange = 0.0;
  float lerpIncr;
  int interp;
 
  ColouredLine(PVector ip1, PVector ip2, float ibranchLevel, float ivolume, int ibaseColor, float ilerpIncr,
  int iInterp) {
    p1 = ip1;
    p2 = ip2;
    branchLevel = ibranchLevel;
    volume = ivolume;
    baseColor = ibaseColor;
    lerpIncr = ilerpIncr;
    interp = iInterp;
  }
 
  void display(int alpha) {
    //Color according to branch level
    strokeWeight(map(branchLevel, 1, 0, 1, 7));
    //stroke(
    //  map(branchLevel, 1, 0, 65 - baseColor, 100 - baseColor), 
    //  map(branchLevel, 1, 0, 35 - baseColor, 85 - baseColor), 
    //  map(branchLevel, 1, 0, 50 - baseColor, 100 - baseColor), 
    //  alpha * volume
    //);
    stroke(
      map(branchLevel, 1, 0, 65 - baseColor, 100 - baseColor), 
      map(branchLevel, 1, 0, 0, 100), 
      map(branchLevel, 1, 0, 50 - baseColor, 100 - baseColor), 
      alpha * volume
    );
    if(interp == 1){
      PVector lerp_p1 = p1.copy();
      lerp_p1.lerp(p2, lerpChange);
      line(p1.x, p1.y, lerp_p1.x, lerp_p1.y);
      if(lerpChange < 1.0){
        lerpChange += lerpIncr;
      };
    } 
    else {
      line(p1.x, p1.y, p2.x, p2.y);
    };
  }
}
