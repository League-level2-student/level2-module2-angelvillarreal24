//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*


class Segment {

  //Add x and y member variables. They will hold the corner location of each segment of the snake.

  int segmentX;
  int segmentY;
  public Segment(int segmentX, int segmentY) {
    this.segmentX = segmentX;
    this.segmentY = segmentY;
  }
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
Segment tailStart;
int foodX;
int foodY;
int direction = RIGHT;
int segmentCounter = 0;
int headX = ((int)random(50)*10);
int headY = ((int)random(50)*10);
ArrayList<Segment> segments = new ArrayList<Segment>();



//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
  head = new Segment(headX, headY);
  frameRate(20);
  dropFood();
}

void dropFood() {
  //Set the food in a new random location
  foodX = ((int)random(50)*10);
  foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(#4D4C4C);
  move();
  drawFood();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  noStroke();
  fill(#39FF1C);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#FF1216);
  rect(headX, headY, 10, 10);
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail
  for (Segment mySegment : segments) {
    rect(mySegment.segmentX, mySegment.segmentY, 10, 10);
    
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tailStart = new Segment(headX, headY);
  segments.add(tailStart);
  segments.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(Segment segundoSegment : segments){
    if(segundoSegment.segmentX == headX && segundoSegment.segmentY == headY){
      segmentCounter = 1;
      segments = new ArrayList<Segment>();
      
      
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == CODED) {
    if (keyCode == UP && direction!=DOWN){
        direction = UP;
    }
    else if (keyCode == DOWN && direction!=UP){
        direction = DOWN;
    }
    else if (keyCode == LEFT && direction!=RIGHT){
        direction = LEFT;
    }
    else if (keyCode == RIGHT && direction!=LEFT){
        direction = RIGHT;
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.


  switch(direction) {
  case UP:
    headY = headY - 10;
    break;
  case DOWN:
    headY = headY + 10;
    break;
  case LEFT:
    headX = headX - 10; 
    break;
  case RIGHT:
    headX = headX + 10;
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
  //If the snake leaves the frame, make it reappear on the other side
  if (headX>=width) {
    headX=0;
  } else if (headX<=-1) {
    headX=width;
  }
  if (headY>=height) {
    headY=0;
  } else if (headY<=-1) {
    headY=height;
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(headX == foodX && headY == foodY){
    segmentCounter++;
    print("food");
      foodX = ((int)random(50)*10);
      foodY = ((int)random(50)*10);
  }
}
