// die library oscP5 muss installiert sein
import oscP5.*;
int oscPort = 12000; // auf diesem Port werden osc messages empfangen
int number_lines = 5; //number of actual lines
OscP5 oscP5;

ArrayList<Line> lines;

void setup() {
  size(640,640);
  lines = new ArrayList<Line>();
  /*
    Es werden ausschließlich neue Linien gezeichnet wenn eine neue Osc Message kommt,
    daher noLoop
  */
  //noLoop(); //Das schaltet die draw-loop aus. //Das ist jetzt an! 
  oscP5 = new OscP5(this, oscPort); 
}

void draw() { 
  // die Array Liste mit den Linien durchgehen und alle Linien zeichnen
  background(209);
  for (int i = 0; i <= lines.size() - 1; i++) { 
    Line line = lines.get(i);
    //println("lines:", lines);
    if (lines.size() > number_lines) {
      lines.remove(0);  
    };
    line.display();  
  }  
}

// Wenn eine beliebige Osc Message empfangen wird, wird diese Funktion gerufen. 
void oscEvent(OscMessage m) {
  // herausfinden, wieviele Linien bei dieser osc msg gesendet werden
  // eine Linie brauch vier Daten (zwei Punkte mit je x und y), daher die Laenge durch 4 teilen
  int numLines = m.typetag().length() / 4; 
  println("number of lines: ", numLines);
  
  // alte Linien aus dem Array entfernen
  //lines.clear(); //Funktioniert komischerweise auch ohne!
  
  // die neu empfangenen Linien hinzufuegen
  for(int i = 0; i < numLines; i++) { 
    int j = i * 4; 
    lines.add(new Line(
      m.get(0 + j).intValue(),   //gets coordinate x of p1
      m.get(1 + j).intValue(),   //gets coordinate y of p1
      m.get(2 + j).intValue(),   //gets coordinate x of p2
      m.get(3 + j).intValue()    //gets coordinate y of p2
    ));
  };
  //redraw(); //funktioniert komischerweise auch ohne!
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
