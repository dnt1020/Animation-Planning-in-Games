void mouseClicked(){
  state += 1;
  if(state>2){
    state = 1;
  }
  checkState();
}

void checkState(){ //different states of simulation controlled by mouse
  if(state == 1){ //reset particle system
    on = true;
    ps = new ParticleSystem(new PVector( -800, 0, 0));
    ballvel = 0;
    explode = false;
  }
  else if(state == 2){ //send fireball
    ballvel = 0.5;
    add = 50;
  }
}

void checkLife(){ //how long explosion lasts
  if(millis() - expStartTime > 500 && explode){
    on = false;
  } 
}

void drawShield(){ //draw shield obj
  pushMatrix(); 
  translate(-90, 0, 0);
  rotateY(-PI/2);
  scale(5);
  shape(shield);
  popMatrix();
}

float[] centeredSphere(float radius){ //generate coordinates within a sphere where most of them are in the middle
  float[] values = new float[3];
  float theta = random(1) * 2 * PI;
  float phi = random(1) * PI;
  float r = radius*random(1);
  values[0] = r * cos(theta) * sin(phi);
  values[1] = r * sin(theta) * sin(phi);
  values[2] = r * cos(phi);
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
