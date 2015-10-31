// CAUTION!
// This is very dirty code. It needs refactoring.

PCapture cam;
PImage img;

PVector[][] vertex;
PVector[][] t_vertex1;
PVector[][] t_vertex2;

void setup() {
  size(800, 600, P3D);
  
  int cam_id = 2;
  cam = new PCapture( cam_id, 1280, 720 );
  
  int k_div = 20;
  int s_div = 50;
  int R = 300;
  
  vertex = new PVector[k_div+1][s_div];
  t_vertex1 = new PVector[k_div+1][s_div];
  t_vertex2 = new PVector[k_div+1][s_div];
  
  for (int k=1; k<=k_div; k++) {
    for (int s=0; s<s_div; s++) {
      vertex[k][s] = getPoint3D( k, s, R, k_div, s_div );
      t_vertex1[k][s] = getPoint2D( k, s, R, 310, 320, k_div, s_div );
      t_vertex2[k][s] = getPoint2D( k, s, R, 960, 320, k_div, s_div );
    }
  }
}


void draw() {
  background(0);
  img = cam.getImage();

  translate( width/2, height/2, 600 );
  rotateY( radians( frameCount*5) );

  noStroke();
  drawHalfSphere( vertex, t_vertex1, 20, 50, 300, 300, 310, 320 );
  rotateY(PI); 
  drawHalfSphere( vertex, t_vertex2, 20, 50, 300, 300, 960, 320 );
}


void drawHalfSphere(PVector[][] vertex, PVector[][] t_vertex, int k_div, int s_div, int R, int img_R, int xc, int yc) {

  for (int k=1; k<=k_div; k++) {
    for (int s=0; s<s_div; s++) {
      int s2 = (s+1==s_div) ? 0 : s+1;  // next
      if ( k==1 ) {
        PVector p1 = vertex[k][s];
        PVector p2 = vertex[k][s2];
        PVector t1 = t_vertex[k][s];
        PVector t2 = t_vertex[k][s2];
        beginShape();
        texture(img);        
        vertex( p1.x, p1.y, p1.z, t1.x, t1.y );
        vertex( p2.x, p2.y, p2.z, t2.x, t2.y );
        vertex( 0, 0, R, xc, yc );
        endShape(TRIANGLE);
      } else {
        PVector p1 = vertex[k][s];
        PVector p2 = vertex[k-1][s];
        PVector p3 = vertex[k][s2];
        PVector p4 = vertex[k-1][s2];

        PVector t1 = t_vertex[k][s];
        PVector t2 = t_vertex[k-1][s];
        PVector t3 = t_vertex[k][s2];
        PVector t4 = t_vertex[k-1][s2];

        beginShape();
        texture(img);        
        vertex( p1.x, p1.y, p1.z, t1.x, t1.y );
        vertex( p3.x, p3.y, p3.z, t3.x, t3.y );
        vertex( p2.x, p2.y, p2.z, t2.x, t2.y );
        endShape(TRIANGLE);

        beginShape();
        texture(img);        
        vertex( p2.x, p2.y, p2.z, t2.x, t2.y );
        vertex( p3.x, p3.y, p3.z, t3.x, t3.y );
        vertex( p4.x, p4.y, p4.z, t4.x, t4.y );
        endShape(TRIANGLE);
      }
    }
  }
}


PVector getPoint3D(int k, int s, int R, int k_div, int s_div ) {  
  float theta_k = (PI/2)/k_div * k;
  float r = R*sin( theta_k );
  float theta_s = (2*PI)/s_div * s;
  float x = r*cos(theta_s);
  float y = r*sin(theta_s);
  float z = R * cos(theta_k);
  PVector vec = new PVector(x, y, z);
  return vec;
}

PVector getPoint2D(int k, int s, int R, int xc, int yc, int k_div, int s_div ) {
  float theta_k = (PI/2)/k_div * k;
  float r = R*sin( theta_k );
  float theta_s = (2*PI)/s_div * s;
  float x = r*cos(theta_s) + xc;
  float y = r*sin(theta_s) + yc;
  PVector vec = new PVector(x, y);
  return vec;
}

