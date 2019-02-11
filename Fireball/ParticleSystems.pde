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
      particles.add(new Particle(origin.add(ballvel, 0, 0))); //changes based on state
    }
  }
  
  void run(float time){
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

class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector origin;
  float lifespan;
  boolean explosive = false;
  int radius;
  
  Particle(PVector location){ //default constructor to set up a single particle
    origin = location.copy(); //have to use this because PVector globally changes values
    radius = 50; //size of fireball
    if(!explode){ //normal mode before shield hit
      PVector temp = origin.copy();
      float[] cord = centeredSphere(radius);
      temp.add(cord[0], cord[1], cord[2]); 
      position = temp.copy(); //initial position
      velocity = new PVector(0, 0, 0); //initial velocity
      acceleration = new PVector(0, 0, 0); //acceleration 
      lifespan = random(200, 400); //how long the particle lasts
      BounceCheck();
    }
    else{ 
      explode();
    }
}
  
  void explode(){ //once shield is hit set to new values
    explosive = true; //attribute of particle for drawing
    PVector temp = origin.copy(); //have to use this because PVector globally changes values
    float[] cord = centeredCircle(radius);
    position = temp.add(0, cord[0], cord[1]); //set initial points to be random in circle
    float[] vel = centeredSphere(0.5);
    velocity = new PVector(-abs(vel[0]), vel[1], vel[2]); //set velocity to be random and not in positive x direction
    acceleration = new PVector(0, 0, 0);
    lifespan = random(100, 400); 
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
  
  void BounceCheck(){ //check to see if bounce off shield
    if(sq(position.x)+sq(position.y)+sq(position.z) < sq(20+100)){
      ballvel = 0; //particle system stays at one spot
      explode = true; //set particles to explode
      expStartTime = millis(); //start timer to know when to stop particle system
    }
    
  }
  
  void displayParticle(){ //display of particle
    pushMatrix();
    displayPoint();
    popMatrix();
  }
  
  void displayPoint(){
    strokeWeight(8);
    float disttoorigin = sqrt(sq(position.x-origin.x)+sq(position.y-origin.y)+sq(position.z-origin.z));
    stroke(255, 255 - (disttoorigin*8), 0, (1/disttoorigin)*2000); //display based on distanct to origin, more transparent on outside
    if(explosive){ //color if shield hit
      stroke(255, random(0, 255), 0, lifespan*3);
    }
    if(lifespan < 100){ //turn to smoke
      stroke(150, 150, 150, lifespan*3);
      acceleration.y = -.001;
    }
    point(position.x, position.y, position.z);
  } 
  
  boolean isDead(){ //returns if the particle is alive
    return (lifespan < 0.0);
  }
}
