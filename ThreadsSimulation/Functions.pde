void update(float dt){
  //Force Calculations
  for(int i=0; i < threads; i++)
  {
    for(int j =0; j<numBalls; j++)
    {
      if (j == 0)
      {  //special force calculation for top spring
        springArray[i][j].stretchForce.y = -k*((springArray[i][j].position.y - stringTopY) - restLen);
        springArray[i][j].stretchForce.x = -k*((springArray[i][j].position.x - fixedXValues[i]) - restLenX);
      }
      else
      {
        springArray[i][j].stretchForce.y = -k*((springArray[i][j].position.y - springArray[i][j-1].position.y) - restLen);
        springArray[i][j].stretchForce.x = -k*((springArray[i][j].position.x - springArray[i][j-1].position.x) - restLenX);
      }
      springArray[i][j].dampForce.y = -kv*(springArray[i][j].velocity.y - 0);
      springArray[i][j].overallForce.y = springArray[i][j].stretchForce.y + springArray[i][j].dampForce.y;
      springArray[i][j].dampForce.x= -kv*(springArray[i][j].velocity.x - 0);
      springArray[i][j].overallForce.x = springArray[i][j].stretchForce.x + springArray[i][j].dampForce.x;    
    }
  }
  
  //Integration Calculations
  for(int i=0; i < threads; i++)
  {
    for(int j =0; j<numBalls; j++)
    {
      if(j == numBalls-1)
      { //special acceleration calculations for bottom spring
        springArray[i][j].acceleration.x = .5*springArray[i][j].overallForce.x/mass;
        springArray[i][j].acceleration.y = gravity + .5*springArray[i][j].overallForce.y/mass; 
      }
      else
      {
        springArray[i][j].acceleration.x = .5*springArray[i][j].overallForce.x/mass - .5*springArray[i][j+1].overallForce.x /mass; 
        springArray[i][j].acceleration.y = gravity + .5*springArray[i][j].overallForce.y/mass - .5*springArray[i][j+1].overallForce.y /mass; 
      }
  
      springArray[i][j].velocity.x += springArray[i][j].acceleration.x*dt;
      springArray[i][j].position.x += springArray[i][j].velocity.x*dt;
      springArray[i][j].velocity.y += springArray[i][j].acceleration.y*dt;
      springArray[i][j].position.y += springArray[i][j].velocity.y*dt;
    }
  }
  
  //Collision Detection
  for(int i=0; i < threads; i++)
  {
    for(int j =0; j<numBalls; j++)
    {
      if(springArray[i][j].position.y+radius >floor)
      {
        springArray[i][j].velocity.y *= bounce; 
        springArray[i][j].position.y = floor - radius;
      }
    }
  }
}

void keyPressed() 
{
    for(int i=0; i < threads; i++)
  {
    if (keyCode == RIGHT) {
      springArray[i][numBalls/2].velocity.x += keyForce;
    }
    if (keyCode == LEFT) {
      springArray[i][numBalls/2].velocity.x -= keyForce;
    }
    if (keyCode == UP) {
      springArray[i][numBalls/2].velocity.y -= keyForce;
    }
    if (keyCode == DOWN) {
      springArray[i][numBalls/2].velocity.y += keyForce;
    }
  }
}
