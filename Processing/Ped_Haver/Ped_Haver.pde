//////////
//Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
//Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu
/////////

/* 
 For this simple demo all that's required is to chose a left corner as an origin 
 Then I use the Haversine formula to take lat lon to Cartesian coordinates
 
 I used an online tool developed by Chris Veness for some of the math and to check my own
 http://www.movable-type.co.uk/scripts/latlong.html
 
 The brensenham algorithm is used to create a smart snap mesh for the agents to navigate
 */

////////
//Controls: 
// currently not up and running, need to consolidate with only running once a frame
//    l = line toggle
//    g = grid toggle
//    p = POI toggle
//    f = print framerate
////////

/*
To Do
 2. Clean Haversine calculation to be from center and scalable
 3. Export Snap nodes and render the grids differently (SOOOOO SLOW)
 quicker to add stuff to other arraylists and compare? 
 4. Add agents going from POIs and using the Snap grid as nodes
 5. Make swarms on different demographics with different values based on population
 6. Handle elevated pedestrian paths with z coords 
 */

//upper left corner for region
//PVector Upper_left = new PVector(1.33043, 103.74836);
PVector Upper_left = new PVector(1.34229, 103.73598);
//PVector Upper_left = new PVector(1.34366, 103.74997);
//PVector Upper_left = new PVector(1.339963, 103.745826);

bresenham brez = new bresenham();
Haver hav = new Haver();
Grid grid = new Grid();

import java.util.Set;
import java.util.HashSet;

// used to initialize objects when application is first run or reInitialized
boolean initialized = false;

 int Canvaswidth = 500; 
 float Canvasheight = Canvaswidth*(22.0/18.0);

void setup() {
  
      size(Canvaswidth, int(Canvasheight), P3D);
      
        //initData();
    
      //runs haversine calculation on any csv file to get xy coords from lat lon
      hav.calc("data/temp-nodes.csv", xy_amenities);
      //hav.center("data/temp-nodes.csv", xy_amencenter);
      hav.calc("data/EZ-nodes.csv", xy_bus);
      hav.calc("data/pednetv2nodes.csv", xy_peds);
      hav.calc("data/bridges_links.csv", xy_bridges);
      hav.calc("data/2ndmerc.csv", xy_second);
    
//      //initializes data
    initData();
    
      //runs a version of breseham's algorithm on chosen network(s)
      brez.bresenham("data/pednetv2nodes.csv", xy_peds);
      brez.bresenham("data/bridges_links.csv", xy_bridges);
      brez.bresenham("data/2ndmerc.csv", xy_second);
      brez.clean(Coordinates);

      //grid scale given by user with dimensions and cell width 
      //grid.render(2, 40);


}

void draw() {
      //these only run once
          if (!initialized) {
              background(0);
              drawLines();
              //drawPOI();
              //brez.draw_grid();
              grid.render(4, 40);
              println("Initialized");
              initialized = true;
          }
    
      //these run multiple times
          if (showFrameRate) {
            println(frameRate);
          }
            
}
