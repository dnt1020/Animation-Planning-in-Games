void mouseClicked(){
  clicked = !clicked;
}

void drawGround(){ 
  pushMatrix();
  strokeWeight(2);
  stroke(0);
  translate(0, 0, 0);
  rotateX(radians(-90));
  fill(153);
  rect(-250, -250, 500, 500);
  popMatrix();
}

void drawFireplace(){ //draw fireplace base obj
  pushMatrix();
  translate(10, 0, -20);
  rotateX(PI);
  scale(25);
  shape(fireplace);
  popMatrix();
}

float[] centeredCircle(int radius){ //generate coordinates within a circle where most of them are in the middle
  float[] values = new float[2];
  float theta = random(1) * 2 * PI;
  float r = radius*random(1);
  values[0] = r * cos(theta);
  values[1] = r * sin(theta);
  return values;
}
