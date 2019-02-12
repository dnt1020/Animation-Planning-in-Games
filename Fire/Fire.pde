import java.util.Iterator;
import java.util.Collections;
import peasy.*;

PeasyCam camera;

ParticleSystem ps;
PImage fire, smoke;
PShape fireplace;
float startTime, elapsedTime = 1;
boolean clicked = false;
int mode; 

void setup() {
  size(1000, 1000, P3D);
  camera = new PeasyCam(this, 0, -200, 0, 800); 
  camera.setYawRotationMode(); //turn off for free camera
  fire = loadImage("fire.png");
  smoke = loadImage("smoke.png");
  fireplace = loadShape("fireplace.obj"); //if doesn't load change path in .mtl file
  ps = new ParticleSystem(new PVector( 0, -20, 0));
}

void draw() {
  startTime = millis();
  background(240);
  println("Number of Particles:" + ps.size);
  println("Frame Rate:" + frameRate);
  println("Elapsed Time:" + elapsedTime);
  drawGround();
  drawFireplace();
  if(clicked)
  {
    ps.addParticles(30); //Textured Quad
    //ps.addParticles(130); //Particles also change things in particlesystems file
  }
  ps.run(elapsedTime);
  elapsedTime = (millis() - startTime)/12; 
}
