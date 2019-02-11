import java.util.Iterator;
import java.util.Collections;
import shapes3d.utils.*;
import shapes3d.animation.*;
import shapes3d.*;
import peasy.*;

PeasyCam camera;
Toroid toroid;
Tube tube;

ParticleSystem ps;

PImage ground; 
boolean on = true; 
boolean clicked = false;
float startTime, elapsedTime = 1;

void setup() {
  size(1000, 1000, P3D);
  camera = new PeasyCam(this, 200, 100, -50, 600); 
  //camera.setYawRotationMode(); //turn off for free camera
  ground = loadImage("ground.jpg");
  ps = new ParticleSystem(new PVector(-10, 100, -50)); 
}

void draw() {
  startTime = millis();
  background(204);
  println("Number of Particles:" + ps.size);
  println("Frame Rate:" + frameRate);
  println("Elapsed Time:" + elapsedTime);
  drawHose();
  if(on)
    ps.addParticles(150); //Points
  checkStatus();
  ps.run(elapsedTime);
  updateContainer();
  drawGround();
  elapsedTime = (millis() - startTime)/20; 
}
