
//boolean isLive = true;
boolean isLive = false;

ThetaSphere tsphere;
PImage img;
PCapture cam;
int camera_id = 0;

int angleX = 0;
int angleY = 0;


void setup() {
  size(800, 600, P3D);

  // live capture or image file
  if ( isLive ) {
    cam = new PCapture( camera_id, 1280, 720 );
  } else {
    img = loadImage("test.jpg");
  }

  // sphere setup
  int k_div = 40;      // division
  int s_div = 40;      // division
  int sphere_r = 600;  // sphere radius
  int xc1 = 310, yc1 = 320;  // circle position in the image
  int xc2 = 960, yc2 = 320;  // circle position in the image
  int r = 283;               // circle radius

  tsphere = new ThetaSphere(k_div, s_div, sphere_r, xc1, yc1, xc2, yc2, r);
}


void draw() {
  background(0);
  
  // capture live image
  if ( isLive ) {
    img = cam.getImage();
  }

  // position of the sphere
  translate( width/2, height/2, 600 );

  // rotation by key input
  rotateX( radians(angleY) );
  rotateY( radians(angleX) );

  // when THETA stands vertically
  rotateZ(PI/2);

  // draw sphere
  noStroke();
  tsphere.draw(img);
}


void keyPressed() {
  if ( keyCode==LEFT ) {
    angleX-=5;
  }
  if ( keyCode==RIGHT ) {
    angleX+=5;
  }
  if ( keyCode==UP ) {
    angleY+=5;
  }
  if ( keyCode==DOWN ) {
    angleY-=5;
  }
}

