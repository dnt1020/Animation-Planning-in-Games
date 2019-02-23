float floor = 800;
float gravity = 10;
float radius = 10;
float stringTopX = 200;
float stringTopY = 50;
float restLenX = 0;
float restLen = 3;
float mass = 50; //TRY-IT: How does changing mass affect resting length?
float k = 100; //TRY-IT: How does changing k affect resting length?
float kv = 50;
float bounce = -.34;
float keyForce = 100;
int numBalls = 15;
int threads = 15;
int[] fixedXValues = new int[threads];
Spring[][] springArray = new Spring[threads][numBalls];

public void settings() {
  size(800, 800, P3D); //Creating window
}

void setup() {
  for(int i=0; i < threads; i++)
  {
    fixedXValues[i] = 200+ 25*i; //set distance of threads from eachother
    for(int j =0; j<numBalls; j++) //intializing springs
    {
      springArray[i][j] =  new Spring(new PVector(fixedXValues[i],200+j), new PVector(0,0), new PVector(0,0)); //starting position, velocity, acceleration
    }
  }
}

void draw() 
{
  println(frameRate);
  background(255,255,255);
  update(.1); 
  fill(0,0,0);
  
  for(int i=0; i < threads; i++)
  {
    for(int j =0; j<numBalls; j++)
    {
      strokeWeight(1);
      if (j == 0) //top thread is connected to a fixed point
      {
        line(fixedXValues[i],stringTopY,springArray[i][j].position.x,springArray[i][j].position.y);
      }
      else
      {
        line(springArray[i][j-1].position.x,springArray[i][j-1].position.y,springArray[i][j].position.x,springArray[i][j].position.y);
      }
      strokeWeight(5);
      point(springArray[i][j].position.x,springArray[i][j].position.y);
    }
  }
}
