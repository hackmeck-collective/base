// library oscP5 is required
import oscP5.*;
int oscPort = 12000; // port to listen for osc messages
int linesMax = 500; //number of lines that will be drawn
float scaleFactor = 1; // scaling of drawing
int offSetX = 0; // x and y offset of drawing
int offSetY = 0;
OscP5 oscP5;

ArrayList<Line> lines;

void setup() {
  size(1000, 1000);
  lines = new ArrayList<Line>();
  oscP5 = new OscP5(this, oscPort); 
  /*
  lines only need to be drawn when a new osc message arrives, so we use noLoop
  */
  //stroke(255); // white stroke
  colorMode(HSB, 100);
  noLoop(); //draw-loop deactivated
}

void draw() { 
  background(0); //black 
  
  scale(scaleFactor); //zoom
  translate(offSetX / scaleFactor, offSetY / scaleFactor);

  for (int i = 0; i <= lines.size() - 1; i++) { 
    Line line = lines.get(i);
    //println("lines:", lines);

    line.display();  
  }  
}

// this function is called whenever an osc message arrives
// osc-parsing
void oscEvent(OscMessage message) {
  
  // check the addresse and do the according action
  if(message.checkAddrPattern("/lines")==true) {
    
    // call function which will draw the lines
    oscToLine(message); 
  } else if(message.checkAddrPattern("/linesMax")==true){
    
    // change the number of lines which will be drawn
    linesMax = message.get(0).intValue();

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
  // one line requires four numbers (two points with x and y), so to calculate how many are sent we divide by four
  int numLines = message.typetag().length() / 5; 
  
  offSetX = (width / 2) - message.get(0).intValue();
  offSetY = (height / 2) - message.get(1).intValue();
  // add new lines to list
  for(int i = 0; i < numLines; i++) { 
    int j = i * 5; //find the right position in the array according to the number of the line
    lines.add(new Line(
      message.get(0 + j).intValue(),   //gets coordinate x of p1
      message.get(1 + j).intValue(),   //gets coordinate y of p1
      message.get(2 + j).intValue(),   //gets coordinate x of p2
      message.get(3 + j).intValue(),    //gets coordinate y of p2
      message.get(4 + j).floatValue()  // branch Level
    ));
  };
  
  // remove old lines whenever the arrayList gets bigger than linesMax
  while (lines.size() > linesMax) {
      lines.remove(0);  
  };
  redraw(); 
}

class Line 
{
  int p1_x;
  int p1_y;
  int p2_x;
  int p2_y;
  float branchLevel;
 
  Line(int ip1_x, int ip1_y, int ip2_x, int ip2_y, float ibranchLevel) {
    p1_x = ip1_x;
    p1_y = ip1_y;
    p2_x = ip2_x;
    p2_y = ip2_y;
    branchLevel = ibranchLevel;
  }
 
  void display() {
    //println(p1_x, p1_y, p2_x, p2_y);
    //Color according to branch level
    stroke(map(branchLevel, 0, 1, 0, 100), 100, 100);
    line(p1_x, p1_y, p2_x, p2_y);
  }
}
