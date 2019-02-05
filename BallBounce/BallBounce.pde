int radius = 100;
float x = 200; //starting positions
float y = 200;
float z = -200;
float x_acceleration = 0; //changing this will make it "gravitate" towards left or right 
float y_acceleration = 0.98; //gravity
float z_acceleration = 0; //changing this will make it "gravitate" towards left or right 
float x_velocity=50;
float y_velocity=100; //can be increased to show top boundary
float z_velocity=40;
float xbounce = -0.75;
float ybounce = -0.85;
float zbounce = -0.75;
float friction = 0.98;
float top = 200;
float bottom = 1800;
float left = 200;
float right = 1800;
float front = 200; 
float rear = 1800; 

float elapsedTime, startTime;

void setup() {
  size(2500, 2000, P3D);
  ambientLight(100, 100, 100);
  directionalLight(200, 200, 200, 0, -1, 0);
  startTime = millis();
}

void setupLights(){
  ambientLight( 120, 120, 120);
  lightSpecular( 130, 130, 250);
  pointLight( 180, 180, 180, width/2, -height/2, 0);
}

void draw() {  
  elapsedTime = millis()-startTime;
  updatePhysics(elapsedTime/1000.0);
  
  background(255); //Clear the background to white
  setupLights();
  
  noStroke();
  
  pushMatrix(); //movement of the ball
  fill( 255, 0, 0);
  rotateX(-PI/6);
  rotateY(PI/3);
  translate( x, y, z); 
  specular( 255, 255, 255);
  shininess(10);
  sphereDetail(400);
  sphere(radius);
  popMatrix();
  
  drawCube();
}

void updatePhysics(float time) {  
  x_velocity += x_acceleration * time; 
  y_velocity += y_acceleration * time;
  z_velocity += z_acceleration * time;
  
  x += x_velocity*time; 
  y += y_velocity*time; 
  z += z_velocity*time;
  
  checkBounce();
}

void checkBounce(){
  if((y+radius) > bottom) //bounce of bottom 
  {
    y = bottom - radius;
    y_velocity *= ybounce; 
    x_velocity *= friction; //friction on ground reduces x velocity
    z_velocity *= friction; //friction on ground reduces z velocity
  }
  else if((y-radius) < top) //bounce of top
  {
    y = top + radius;
    y_velocity *= ybounce; 
  }
  
  if((x+radius) > right) //bounce of right
  {
    x = right - radius;
    x_velocity *= xbounce; 
  }
  else if((x-radius) < left) // bounce of left
  {
    x = left + radius;
    x_velocity *= xbounce; 
  }
  
  if((z+radius) > rear) //bounce of rear
  {
    z = rear - radius;
    z_velocity *= zbounce; 
  }
  else if((z-radius) < front) // bounce of front
  {
    z = front + radius; 
    z_velocity *= zbounce; 
  }
}

void drawCube(){
  rotateX(-PI/6);
  rotateY(PI/3);
  fill(100,100,100,50);
  beginShape(QUADS);
  vertex(left, top, rear);
  vertex(right, top, rear);
  vertex(right, bottom, rear);
  vertex(left, bottom, rear);
  
  vertex(right, top, rear);
  vertex(right, top, front);
  vertex(right, bottom, front);
  vertex(right, bottom, rear);
  
  vertex(right, top, front);
  vertex(left, top, front);
  vertex(left, bottom, front);
  vertex(right, bottom, front);
  
  vertex(left, top, front);
  vertex(left, top, rear);
  vertex(left, bottom, rear);
  vertex(left, bottom, front);
  
  vertex(left, top, front);
  vertex(right, top, front);
  vertex(right, top, rear);
  vertex(left, top, rear);
  
  vertex(left, bottom, front);
  vertex(right, bottom, front);
  vertex(right, bottom, rear);
  vertex(left, bottom, rear);
  endShape();
}
