class Spring
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector stretchForce;
  PVector dampForce;
  PVector overallForce;
    
  Spring(PVector pos, PVector vel, PVector accel)
  {
    position = pos;
    velocity = vel;
    acceleration = accel;
    stretchForce = new PVector(0,0);
    dampForce = new PVector(0,0);
    overallForce = new PVector(0,0);
  }
}
