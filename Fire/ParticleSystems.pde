class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int size;
  
  ParticleSystem(PVector root){ //default constructor
    size = 0;
    origin = root.copy(); //set root of particles
    particles = new ArrayList<Particle>(); //list to store particles 
  }
  
  void addParticles(int num){ //adding num particles
    size += num;
    for(int i=0; i < num ;i++)
    {
      particles.add(new Particle(origin));
    }
  }
  
  void run(float time){
    Collections.sort(particles); //comment out if using displayPoint()
    Iterator<Particle> it = particles.iterator(); //used to iterate particles
    
    while(it.hasNext()){ //iterate while you still have next
      Particle p = it.next(); //set particle to next
      p.run(time); //run particle
      if(p.isDead()){
        it.remove(); //remove if dead
        size -= 1;
      }
    }
  }
}

class Particle implements Comparable<Particle>{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector location){ //default constructor to set up a single particle
    PVector temp = location.copy(); //have to use this because PVector globally changes values
    int radius = 100; //radius of sampled circle origin
    float[] cord = centeredCircle(radius); 
    temp.add(cord[0], 0, cord[1]); 
    position = temp.copy(); //initial position
    float disttocenter = sqrt(sq(position.x)+sq(position.z));
    velocity = new PVector( (((-position.x)/abs(position.x))*disttocenter)/random(200, 500), random(-1, 0),
      (((-position.z)/abs(position.z))*disttocenter)/random(200, 500)); //initial velocity upwards based on distance to center and aim to move towards center
    acceleration = new PVector(0, -0.0025, 0); //acceleration in vertical direction up 
    lifespan = 300.0; //how long the particle lasts
  }
  
  void run(float time){ //function to help access a single particle
    updatePhysics(time);
    displayParticle();
  }
  
  void updatePhysics(float time){ //update physics of particle
    PVector accel = acceleration.copy(); //have to use this because PVector globally changes values
    velocity.add(accel.mult(time));
    PVector vel = velocity.copy(); //have to use this because PVector globally changes values
    position.add(vel.mult(time));
    lifespan -= 2.0;
  }
  
  void displayParticle(){ //display of particle
    pushMatrix();
    displayTexturedQuad();
    //displayPoint(); //if using displayPoint() comment out Collections.sort(particles) and change .addParticles to 150
    popMatrix();
  }
  
  void displayPoint(){
    strokeWeight(10);
    stroke(255, 280 - abs(abs(position.x)+abs(position.y)+abs(position.z)), 0, lifespan);
    if(lifespan < 100){
      stroke(150, 150, 150, lifespan * 3);
    }
    point(position.x, position.y, position.z);
  }
  
  void displayTexturedQuad(){
    float size = 3;
    translate(position.x, position.y, position.z);
    beginShape();
    noStroke();
    if(lifespan > 100){ //if particle is fire
      texture(fire);
      tint(255, 280 - abs(abs(position.x)+abs(position.y)+abs(position.z)), 0, lifespan);
      vertex(-size, -size, 0, 0, 0);
      vertex(size, -size, 0, fire.width, 0);
      vertex(size, size, 0, fire.width, fire.height);
      vertex(-size, size, 0, 0, fire.height);
    }
    else{ //(lifespan < 100) if particle is smoke
      texture(smoke);
      tint(150, 150, 150, lifespan * 3);
      vertex(-size, -size, 0, 0, 0);
      vertex(size, -size, 0, smoke.width, 0);
      vertex(size, size, 0, smoke.width, smoke.height);
      vertex(-size, size, 0, 0, smoke.height);
    }
    endShape();    
  }
  
  boolean isDead(){ //returns if the particle is alive
    return (lifespan < 0.0);
  }
  
  @Override
  int compareTo(Particle p1){ //used to sort particle based on distance in z-axis
    int z;
    float comp = position.z - ((Particle)p1).position.z;
    if(comp < 0){
      z = -1;
    }
    else if(comp == 0){
      z = 0;
    }
    else{ //(comp < 0){
      z = 1;
    }
    return z;
  }
}
