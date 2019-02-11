class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float size; 
  float fill; 
  
  ParticleSystem(PVector root){ //default constructor
    size = 0; 
    fill =  300;
    origin = root.copy(); //set root of particles
    particles = new ArrayList<Particle>(); //list to store particles 
  }
  
  void addParticles(int num){ //adding num particles
    size += num;
    for(int i=0; i < num ;i++){
      particles.add(new Particle(origin));
    }
  }
  
  void run(float time){
    Iterator<Particle> it = particles.iterator();
    
    Particle p = it.next();
    p.displayConfig(); //config before to render better
    
    while(it.hasNext()){ //iterate while you still have next
      p.run(fill, time); //run particle      
      if(p.isDead()) 
      {
        size -= 1;
        fill -= .0008;  //once a particle is removed fill goes down
        it.remove(); //remove if dead
      }
      p = it.next(); //set particle to next
    }
  }
}

class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float depth; 
  
  Particle(PVector location){ //default constructor to set up a single particle
    PVector temp = location.copy(); //have to use this because PVector globally changes values
    int radius = 5; //radius of sampled circle origin
    float[] cord = randomCircle(radius);
    temp.add(0, cord[0], cord[1]); 
    position = temp.copy(); //initial position
    float[] vel = centeredCircle(0.5);
    velocity = new PVector(random(3.0, 3.5), vel[0], vel[1]); //initial velocity horizontally to the right and based on sampled circle
    acceleration = new PVector( 0, 0.08, 0); //acceleration in vertical direction down
    lifespan = 300.0; //how long the particle lasts
    depth = 300; 
  }
  
  void run(float fill, float time){ //function to help access a single particle
    updatePhysics(time);
    displayParticle();
    depth = fill; //how far particle goes before bouncing
  }
  
  void updatePhysics(float time){ //update physics of particle
    PVector accel = acceleration.copy(); //have to use this because PVector globally changes values
    velocity.add(accel.mult(time));
    PVector vel = velocity.copy(); //have to use this because PVector globally changes values
    position.add(vel.mult(time));
    lifespan -= 2.0;
    checkBounce();
  }
  
  void displayConfig(){ //made seperate to speed up rendering
    strokeWeight(5);
  }
  
  void displayParticle(){ //display of particle
    pushMatrix();
    displayPoint();
    popMatrix();
  }
  
  void displayPoint(){
    stroke( #1191FF, lifespan/2);
    point(position.x, position.y, position.z);
  }
  
  boolean isDead(){ //returns if the particle is alive
    return (lifespan < 0.0);
  }
  
  void checkBounce(){
    if(position.y > depth) //hits ground
    {
      position.y = depth; //update position
      velocity.set(random(0, .3), random(30, 40), random(-1, 1));
      lifespan -= 1; 
    }
  }
}
