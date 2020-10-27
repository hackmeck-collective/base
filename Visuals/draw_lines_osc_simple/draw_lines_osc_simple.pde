// die library oscP5 muss installiert sein
import oscP5.*;
int oscPort = 12000; // auf diesem Port werden osc messages empfangen
OscP5 oscP5;

ArrayList<Line> lines;

void setup() {
  size(640,640);
  lines = new ArrayList<Line>();
  /*
    Es werden ausschließlich neue Linien gezeichnet wenn eine neue Osc Message kommt,
    daher noLoop
  */
  noLoop(); 
  oscP5 = new OscP5(this, oscPort);
}

void draw() { 
  // die Array Liste mit den Linien durchgehen und alle Linien zeichnen
  for (int i = 0; i <= lines.size() - 1; i++) { 
    Line line = lines.get(i);
    line.display();  
  }  
}

// wenn eine beliebige Osc Message empfangen wird wird diese Funktion gerufen
void oscEvent(OscMessage m) {
  // herausfinden, wieviele Linien bei dieser osc msg gesendet werden
  // eine Linie brauch vier Daten (zwei Punkte mit je x und y), daher die Laenge durch 4 teilen
  int numLines = m.typetag().length() / 4; 
  println("number of lines: ", numLines);
  
  // alte Linien entfernen
  lines.clear();
  
  // die neu empfangenen Linien hinzufuegen
  for(int i = 0; i < numLines; i++) {    
    lines.add(new Line(
      m.get(0 + i).intValue(), 
      m.get(1 + i).intValue(), 
      m.get(2 + i).intValue(), 
      m.get(3 + i).intValue()
    ));
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
    line(p1_x, p1_y, p2_x, p2_y);
  }
}
