/*
Bresenham Algorithm Demo 
  by Nina Lutz, nlutz@mit.edu               MIT Media Lab, Changing Places Group, Summer 2016
  Supervisor: Ira Winder, jiw@mit.edu       MIT Media Lab

NOTE: This code may still be condensed 
  
The bresenham algorithm is a classic algorithm used in early computer graphics. It renders a line on rasterized (gridded) space. 
The algorithm takes in a start and end point and finds all the points between them at the scale that the user sets. 

This implementation takes in a csv with a series of points. I arranged them into seperate lines, each with a unique id. 
If you want to use the code exactly, name your columns "shapeid" for the line id number, "x" for your x coordinate and "y" for your y coordinate

I chose to draw a grid of ellipses, becuase I use this alogirthm in a path finding network over pedestrian paths and ellipses are easier for visual confirmation, but you can use squares
*/

//load a table of points 
//lines should have an ID, I call it "shapeid" because this matches most GeoSpatial data structures from programs like QGIS 
Table table;

//set a scale for your grid; this is the weight of each raster cell
 int scale = 12;
 
//global variables for rendering lines
PVector start, end;
float x, y, x1, x2, y1, y2, dx, dy, Steps, xInc, yInc;

void setup(){
      //loading the table
      table = loadTable("data/lines.csv", "header");
      size(500, 500);
}

void draw(){
        background(0);
        //ArrayList to hold the points
        ArrayList<PVector> Coordinates = new ArrayList<PVector>();

  for(int i = 0; i<table.getRowCount()-1; i++){
       //initialize start and end points and put them into PVectors
        x1 = table.getFloat(i, "x");
        x2 = table.getFloat(i+1, "x");
        y1 = table.getFloat(i, "y");
        y2 = table.getFloat(i+1, "y");
        
        start = new PVector(x1, y1);
        end = new PVector(x2, y2);
        
        //these are what will be rendered between the start and end points, initialize at start
        x = start.x;
        y = start.y;
        
        //calculating the change in x and y across the line
        dx = abs(end.x - start.x);
        dy = abs(end.y - start.y);
        
        //number of steps needed, based on what change is biggest
        //depending on your need for accuracy, you can adjust this, the smaller the Steps number, the fewer points rendered
        if(dx > dy){
          Steps = dx/(scale/2);
        }
        else{
          Steps = dy/(scale/2);        
        }
          
        //x and y increments for the points in the line      
        float xInc = (dx)/(Steps);
        float yInc = (dy)/(Steps);
        
        //this is the code to render vertical and horizontal lines, which need to be handled differently at different resolution for my implementation
                if(x1 == x2 || y1 == y2){
                       if (y2 < y1 || x2 < x1) {
                          start = new PVector(x2, y2);
                          end = new PVector(x1, y1);
                        }
            
                        else{
                          start = new PVector(x1, y1);
                          end = new PVector(x2, y2);
                        }
        
                        //slopes of the lines
                        dx = abs(end.x - start.x);
                        dy = abs(end.y - start.y);
                      
                        //steps needed to render the lines
                        if (dx > dy) {
                          Steps = dx/4;
                        } else {
                          Steps = dy/4;
                        }
                      
                        //increments for the points on the line 
                         xInc =  dx/(Steps);
                         yInc = dy/(Steps);
                      
                        //sets a starting point
                        x = start.x;
                        y = start.y;  
                 }

        //focuses on finding coordinates of diagnol lines
          for(int v = 0; v< (int)Steps; v++){       
                //there are four main cases that need to be handled
                      if(end.x < start.x && end.y < start.y){
                           x = x - xInc;    y = y - yInc;
                                }
                      else if(end.y < start.y){
                           x = x + xInc;    y = y - yInc;
                                }  
                      else if(end.x < start.x){
                           x = x - xInc;    y = y + yInc;
                                }    
                      else{ 
                           x = x + xInc;    y = y + yInc;
                             }
                             
                    //this add the values to the array if they're in different lines  
                    if(table.getInt(i, "id") == table.getInt(i+1, "id")){    
                        if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2)){
                        Coordinates.add(new PVector(x, y));
                        }
                    }           
              }
       //draws the lines, this is just for aesthetic and debugging 
       if(table.getInt(i, "id") == table.getInt(i+1, "id")){
          strokeWeight(2);
          stroke(#1a53ff);
          line(table.getFloat(i, "x"), table.getFloat(i, "y"), table.getFloat(i+1, "x"), table.getFloat(i+1, "y"));
       }
  }
  
  //intialize grid variables, with U as x and V as y renderers
   int U = int(width/scale);
   int V = int(height/scale);
   //this is based off the scale int that is initialized at the top of this sketch 
   int SCALE = scale;
           
       //iterates through and draws the grid
        for (int d=0; d<U; d++) {
            for (int j=0; j<V; j++) {
                float a = (d*SCALE + scale/2);
                float b = (j*SCALE + scale/2);
                
                //this is where I chose to render the grid as ellipses
                stroke(100);
                noFill();
                strokeWeight(.5);
                ellipse(a, b, scale, scale);
               
                //compare grid values to Coordinates and color the grid cells that correspond to the lines 
                 for(int p = 0; p<Coordinates.size()-1; p++){
                      if(abs(a - Coordinates.get(p).x) <= scale*2/3 && abs(b - Coordinates.get(p).y) <= scale*2/3){
                            strokeWeight(.5);
                            stroke(#ffd633);
                            ellipse(a, b, scale, scale);
                      }
                    }
              }
            }
            println(Coordinates.size() + " possible nodes on or tangent to line");
}