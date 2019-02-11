void mouseClicked(){
  clicked = true;
}

void checkStatus(){
  if (clicked && ps.fill > 200) { //turn off if clicked and not full
    clicked = false;
    on = !on;
  }
  else if (clicked){ //turn on if clicked and ful
    clicked = false;
    ps.fill = 300;
    on = !on;   
  }
  if (ps.fill < 200) { //if full turn off and set fill to be over limit 
    on = false;
    ps.fill = 199;
  }
}

void drawGround(){
  pushMatrix();
  beginShape();
  noTint();
  texture(ground);
  vertex(-100, 300, 200, 0, 0);
  vertex(400, 300, 200, 1, 0); 
  vertex(400, 300, -300, 1, 1); 
  vertex(-100, 300, -300, 0, 1); 
  endShape(); 
  popMatrix();
}

void drawHose(){
  pushMatrix();
  noTint();
  tube = new Tube(this, 4, 50);
  tube.setSize(5, 5, 5, 5, 240);
  tube.setWorldPos(-10, 100, -50, -80, 105, -50);
  tube.setTexture("hose.jpg", 2, 1);
  tube.setTexture("water.jpg", S3D.S_CAP);
  tube.setTexture("water.jpg", S3D.E_CAP);
  tube.drawMode(S3D.TEXTURE);
  tube.drawMode(S3D.TEXTURE, S3D.BOTH_CAP);
  tube.draw();
  
  toroid = new Toroid(this, 30, 60);
  toroid.setRadius(4, 4, 2);
  toroid.rotateToZ(radians(80));
  toroid.moveTo(-10, 100, -50);
  toroid.fill(0);
  toroid.draw();
  popMatrix();
}

void updateContainer(){
  pushMatrix();
  drawQuad(ps.fill, 300, 100, 300, -150, 50, #1191F0, 100, true); //water container
  drawQuad(175, 300, 100, 300, -150, 50, #716767, 100, false); //empty container
  popMatrix();
}

float[] randomCircle(int radius){ //generate uniform coordinates within a circle
  float[] values = new float[2];
  float theta = random(1) * 2 * PI;
  float r = sqrt(random(1));
  values[0] = (radius * r) * cos(theta);
  values[1] = (radius * r) * sin(theta);
  return values;
}

float[] centeredCircle(float radius){ //generate coordinates within a circle where most of them are in the middle
  float[] values = new float[2];
  float theta = random(1) * 2 * PI;
  float r = radius*random(1);
  values[0] = r * cos(theta);
  values[1] = r * sin(theta);
  return values;
}

void drawQuad(float top, float bottom, float left, float right, float front, float rear, int col, float opacity, boolean noStroke){
  fill(col, opacity);
  stroke(0);
  if(noStroke){
    noStroke();
  }
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
