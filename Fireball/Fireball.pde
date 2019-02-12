import java.util.Iterator;
import peasy.*;

PeasyCam camera;

ParticleSystem ps;
PShape shield;
float startTime, elapsedTime = 1;
float expStartTime;
boolean on = false;
boolean explode;
float ballvel;
int state; 
int add;

void setup() {
  size(1000, 1000, P3D);
  camera = new PeasyCam(this, -450, 0, 0, 800); 
  //camera.setYawRotationMode(); //turn off for free camera
  shield = loadShape("shield.obj");
  ps = new ParticleSystem(new PVector( -800, 0, 0));
  add = 100;
}

void draw() {
  startTime = millis();
  background(205);
  println("Number of Particles:" + ps.size);
  println("Frame Rate:" + frameRate);
  println("Elapsed Time:" + elapsedTime);
  println("Add:" + add);
  
  println(state);
  drawShield();
  if(state==2 && !explode)
    add = 100;
  else
    add = 10;
  if(on)
    ps.addParticles(add);
  ps.run(elapsedTime);
  checkLife();
  elapsedTime = (millis() - startTime);
}
