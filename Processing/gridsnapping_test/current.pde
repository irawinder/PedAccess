
//  Table table;
//  int scale = 12;

//void setup(){
//  size(500, 500);
//  table = loadTable("data/lines.csv", "header");
//}

//void draw(){
//  background(0);
  
//  ArrayList<PVector> Coordinates = new ArrayList<PVector>();
//  float Steps, x, y;


//  stroke(255);
//  for(int i = 0; i<table.getRowCount()-1; i++){
//       if(table.getInt(i, "id") == table.getInt(i+1, "id")){
//        stroke(255);
//       line(table.getFloat(i, "x"), table.getFloat(i, "y"), table.getFloat(i+1, "x"), table.getFloat(i+1, "y"));
//       }
       
//        float x1 = table.getFloat(i, "x");
//        float x2 = table.getFloat(i+1, "x");
//        float y1 = table.getFloat(i, "y");
//        float y2 = table.getFloat(i+1, "y");
        
//        if(x2 < x1 && y2 < y1){
//               x2 = table.getFloat(i, "x");
//               x1 = table.getFloat(i+1, "x");
//               y2 = table.getFloat(i, "y");
//               y1 = table.getFloat(i+1, "y");
//        }
        
//          float dx = abs(x2-x1);
//          float dy = abs(y2-y1);
          
//              if(dx > dy){
//                Steps = dx;
//              }
//              else{
//                Steps = dy;        
//              }
              
//          float xInc = (dx)/(Steps);
//          float yInc = (dy)/(Steps);

//          x = x1;
//          y = y1;
          
//          for(int v = 0; v< (int)Steps; v++){
//              if(y2 < y1){
//                 x = x + xInc;
//                 y = y - yInc;
//              }
              
//             else if(x2 < x1){
//                 x = x - xInc;
//                 y = y + yInc;
//              }
  
//             else{ 
//              x = x + xInc;
//              y = y + yInc;
//             }
              
//              noFill();
//              if(x <= max(x1, x2) && y<= max(y1, y2)){
//              Coordinates.add(new PVector(x, y));
//              }
//    }
//  }
  
//  //draw grid
//   int U = int(width/scale);
//   int V = int(height/scale);
//   int SCALE = scale;
//    //draw grid
//    for (int i=0; i<U; i++) {
//      for (int j=0; j<V; j++) {
//        float a = (i*SCALE + scale/2);
//        float b = (j*SCALE + scale/2);
        
//        stroke(100);
//        noFill();
//        ellipse(a, b, 12, 12);
        
//         for(int p = 0; p<Coordinates.size(); p++){
//          if(abs(a - Coordinates.get(p).x) <= scale/2 && abs(b - Coordinates.get(p).y) <= scale/2){
//          stroke(#ffff00);
//          ellipse(a, b, 12, 12);
//          }
//        }
//      }
//    }
//}