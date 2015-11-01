
class ThetaSphere {
  // k : latitude
  // s : longitude

  PVector[][] vertices3D;   // 3D vertices of hemisphere
  PVector[][] t_vertices1;  // 2D texture vertices of hemisphere (1 of 2)
  PVector[][] t_vertices2;  // 2D texture vertices of hemisphere (2 of 2)

  // constructor(initialize)
  ThetaSphere(int k_div, int s_div, int sphere_r, int xc1, int yc1, int xc2, int yc2, int img_r) {
    vertices3D =  calcHemisphereVertices( k_div, s_div, sphere_r );
    t_vertices1 = calcHemisphereTextureVertices( k_div, s_div, xc1, yc1, img_r );
    t_vertices2 = calcHemisphereTextureVertices( k_div, s_div, xc2, yc2, img_r );
  }


  // draw textured sphere
  void draw(PImage t_img) {
    drawHemisphere( vertices3D, t_vertices1, t_img );
    rotateY(PI); 
    drawHemisphere( vertices3D, t_vertices2, t_img );
  }


  // draw textured hemisphere
  void drawHemisphere(PVector[][] vertices, PVector[][] t_vertices, PImage t_img) {

    int k_div = vertices.length-1;
    int s_div = vertices[0].length-1;

    for (int k=1; k<=k_div; k++) {
      for (int s=0; s<s_div; s++) {
        if ( k==1 ) {
          PVector p0 = vertices[0][0];
          PVector p1 = vertices[k][s];
          PVector p2 = vertices[k][s+1];
          PVector t0 = t_vertices[0][0];
          PVector t1 = t_vertices[k][s];
          PVector t2 = t_vertices[k][s+1];
          beginShape(TRIANGLE);
          texture(t_img);
          vertex( p1.x, p1.y, p1.z, t1.x, t1.y );
          vertex( p2.x, p2.y, p2.z, t2.x, t2.y );
          vertex( p0.x, p0.y, p0.z, t0.x, t0.y );
          endShape();
        } else {
          PVector p1 = vertices[k][s];
          PVector p2 = vertices[k-1][s];
          PVector p3 = vertices[k][s+1];
          PVector p4 = vertices[k-1][s+1];
          PVector t1 = t_vertices[k][s];
          PVector t2 = t_vertices[k-1][s];
          PVector t3 = t_vertices[k][s+1];
          PVector t4 = t_vertices[k-1][s+1];

          beginShape(TRIANGLE_STRIP);
          texture(t_img);        
          vertex( p1.x, p1.y, p1.z, t1.x, t1.y );
          vertex( p2.x, p2.y, p2.z, t2.x, t2.y );
          vertex( p3.x, p3.y, p3.z, t3.x, t3.y );
          vertex( p4.x, p4.y, p4.z, t4.x, t4.y );
          endShape();
        }
      }
    }
  }


  // calculate 3D vertices of hemisphere
  PVector[][] calcHemisphereVertices(int k_div, int s_div, int r) {

    PVector[][] vertices = new PVector[k_div+1][s_div+1];

    for (int k=0; k<=k_div; k++) {
      float theta_k = k * (PI/2)/k_div;
      float slice_r = r * sin(theta_k);

      for (int s=0; s<=s_div; s++) {
        float theta_s = s * (2*PI)/s_div;
        float x = slice_r * cos(theta_s);
        float y = slice_r * sin(theta_s);
        float z = r * cos(theta_k);
        vertices[k][s] = new PVector(x, y, -z);
      }
    }

    return vertices;
  }


  // calculate 2D texture vertices of hemisphere
  PVector[][] calcHemisphereTextureVertices(int k_div, int s_div, int xc, int yc, int r) {
    
    PVector[][] t_vertices = new PVector[k_div+1][s_div+1];

    for (int k=0; k<=k_div; k++) {
      float theta_k = k * (PI/2)/k_div;
      float slice_r = r * sin(theta_k);

      for (int s=0; s<=s_div; s++) {
        float theta_s = s * (2*PI)/s_div;
        float x = slice_r * cos(theta_s) + xc;
        float y = slice_r * sin(theta_s) + yc;
        t_vertices[k][s] = new PVector(x, y);
      }
    }

    return t_vertices;
  }
}

