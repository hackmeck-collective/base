// library oscP5 is required
import oscP5.*;
int oscPort = 12000; // port to listen for osc messages
int linesMax = 20; //number of lines that will be drawn
float scaleFactor = 1; // scaling of drawing
int offSetX = 0; // x and y offset of drawing
int offSetY = 0;
OscP5 oscP5;

ArrayList<Line> lines;

void setup() {
  size(1000,1000);
  lines = new ArrayList<Line>();
  oscP5 = new OscP5(this, oscPort); 
  /*
    lines only need to be drawn when a new osc message arrives, so we use noLoop
  */
  noLoop(); //draw-loop deactivated
  stroke(255); // white stroke
}

void draw() { 
  background(0); //black 
  
  scale(scaleFactor);
  translate(offSetX / scaleFactor, offSetY / scaleFactor);

  for (int i = 0; i <= lines.size() - 1; i++) { 
    Line line = lines.get(i);
    //println("lines:", lines);

    line.display();  
  }  
}

// this function is called whenever an osc message arrives
void oscEvent(OscMessage m) {
  // check the addresse and do the according action
  if(m.checkAddrPattern("/lines")==true) {
    // call function which will draw the lines
    oscToLine(m); 
  } else if(m.checkAddrPattern("/linesMax")==true){
    // change the number of lines which will be drawn
    linesMax = m.get(0).intValue();
    println("new number of lines: ", linesMax);
  } else if(m.checkAddrPattern("/scale")==true){
    // change the scaling of the drawing
    scaleFactor = m.get(0).floatValue();
    println("new scale factor: ", scaleFactor);
  } else if(m.checkAddrPattern("/offsetX")==true){
    // translate drawing by an offset
    offSetX = m.get(0).intValue();
    println("new offset X: ", offSetX);
  } else if(m.checkAddrPattern("/offsetY")==true){
    offSetY = m.get(0).intValue();
    println("new offset Y: ", offSetY);
  } else if(m.checkAddrPattern("/offsetXY")==true){
    offSetX = m.get(0).intValue();
    offSetY = m.get(1).intValue();
  }
}

void oscToLine(OscMessage m) {
  // find out how many lines are sent 
  // one line requires four numbers (two points with x and y), so to calculate how many are sent we divide by four
  int numLines = m.typetag().length() / 4; 
  //println("number of lines: ", numLines);  
  
  // add new lines to list
  for(int i = 0; i < numLines; i++) { 
    int j = i * 4; 
    lines.add(new Line(
      m.get(0 + j).intValue(),   //gets coordinate x of p1
      m.get(1 + j).intValue(),   //gets coordinate y of p1
      m.get(2 + j).intValue(),   //gets coordinate x of p2
      m.get(3 + j).intValue()    //gets coordinate y of p2
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
 
  Line(int ip1_x, int ip1_y, int ip2_x, int ip2_y) {
    p1_x = ip1_x;
    p1_y = ip1_y;
    p2_x = ip2_x;
    p2_y = ip2_y;
  }
 
  void display() {
    //println(p1_x, p1_y, p2_x, p2_y);
    line(p1_x, p1_y, p2_x, p2_y);
  }
}
