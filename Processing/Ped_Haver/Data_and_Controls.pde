////////////////
/// CONTROLS 
///////////////
boolean showPOI = true;

boolean showMesh = true;
boolean showlines = true;

void keyPressed() {
     //draws lines
      if (key=='l') {
         showlines = toggle(showlines);
      }
      //draws POI
      else if(key=='p') {
         showPOI = toggle(showPOI);
      }   
      else if(key == 'g'){
         showMesh = toggle(showMesh);
      }

}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}



////////////////////////
//DATA LOAD 
///////////////////////


PImage img;
Table amenities; 
Table ped_nodes;
Table bus_stops;
Table bridges;
Table second;

void initData(){
  amenities = loadTable("data/temp-nodes.csv", "header");
  ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
  bus_stops = loadTable("data/EZ-nodes.csv", "header");
  bridges = loadTable("data/bridges_links.csv", "header");
  second = loadTable("data/2ndmerc.csv", "header");
  img = loadImage("map.jpg");
  
  println("data loaded");
}