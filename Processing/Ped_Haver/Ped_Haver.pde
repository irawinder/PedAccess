//////////
//Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
//Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu
/////////

/* 
For this simple demo all that's required is to chose a left corner as an origin 
Then I use the Haversine formula to take lat lon to Cartesian coordinates

I used an online tool developed by Chris Veness for some of the math and to check my own
http://www.movable-type.co.uk/scripts/latlong.html
*/ 

//int  Width = 1200;
//int  Height = 600;

Network PedNetwork;

//upper left corner for region
PVector Upper_left  = new PVector(1.3258, 103.733);

//103.736862818997537,1.322835158689293
//1.343234, 103.73601
//(1.322835158689293, 103.736862818997537)
//PVector Upper_left = new PVector(1.34197, 103.74440);

void setup(){
        size(1200, 600, P3D);
        
        //initializes data
        initData();
        
        //does haversine calculation to go from lat, lon to Cartesian
        Haversine();
        
        PedNetwork = new Network("miniplz.geojson");
}

void draw(){
     background(0); 
     
     //draws Google map capture of Upper_left at 1.343234, 103.73601 for 1200 by 900 meters
//    image(img, 0, 0);
     
     //draws ped network mesh
     drawMesh();
     
     //draws POI data    
      drawPOI();
     
     //draws a legend at bottom with info on what's on canvas
     drawLegend();
 
 
}
