PImage map;
JSONArray nodes;

// Change this number to 5, 10, 20, or 40m per grid unit
int scale = 5;

int gridU = 40/scale*72;
int gridV = 40/scale*88;

String data5 = "nodes5_meters_288_by_352.json";
String data10 = "nodes10_meters_144_by_176.json";
String data20 = "nodes20_meters_72_by_88.json";
String data40 = "nodes40_meters_72_by_88.json";

void setup() {
  size(int(10*gridU*(scale/40.0)), int(10*gridV*(scale/40.0)));
  
  // Loads Raster Images into memory with variable alpha()
  importRaster();
  
  // Resamples each raster image into a grid of nodes
  for (int i=0; i<6; i++) {
    processRaster(networkRaster[i], gridU, gridV, i);
  }
  
  // saves the JSONArray to file
    switch(scale) {
    case 5:
      saveJSONArray(rasterNodes, "data/" + data5);
      break;
    case 10:
      saveJSONArray(rasterNodes, "data/" + data10);
      break;
    case 20:
      saveJSONArray(rasterNodes, "data/" + data20);
      break;
    case 40:
      saveJSONArray(rasterNodes, "data/" + data40);
      break;
  }
  
  // Loads Node Network from JSON
  importNodes();
  
  // Loads a map of singapore that is 3,520m x 2,880m, centered at (1.33342 lat, 103.74234 lon)
  map = loadImage("singapore_40.png");
  map.resize(width, height);
  image(map, 0, 0);
  
  // Draws the Node Network
  drawNodes(nodes, gridU);
  
}

void drawNodes(JSONArray nodes, int arrayWidth) {
  
  // Calculates grid pixel width based upon canvas size and array size:
  float gridWidth = float(width) / arrayWidth;
  
  JSONObject node;
  int u, v;
  
  for (int i=0; i<nodes.size(); i++) {
    node = nodes.getJSONObject(i);
    u = node.getInt("u");
    v = node.getInt("v");
    
    noFill();
    
    color road = #D6D6D6;
    color ped_ground = #FFFA95;
    color ped_xing = #FF9A3B;
    color ped_linkway = #3BFFF4;
    color ped_bridge = #FF453B;
    color ped_2nd = #4BCB2F;
    
    if (node.getString("type").equals("road")) {
      stroke(road);
    }
    if (node.getString("type").equals("ped_ground")) {
      stroke(ped_ground);
    }
    if (node.getString("type").equals("ped_xing")) {
      stroke(ped_xing);
    }
    if (node.getString("type").equals("ped_linkway")) {
      stroke(ped_linkway);
    }
    if (node.getString("type").equals("ped_bridge")) {
      stroke(ped_bridge);
    }
    if (node.getString("type").equals("ped_2nd")) {
      stroke(ped_2nd);
    }
    
    ellipse (u*gridWidth, v*gridWidth, gridWidth, gridWidth);
  }
}
