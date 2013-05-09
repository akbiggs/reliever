Diamond[] diamond = new Diamond[50];
int timer = 0;
int interval = 0;
void setup() {
  size(900, 300);
  resetTimer();
}

void draw() {
  background(0);
  updateDiamondTimer();
  adjustInterval();
  if (shouldSpawnDiamond()) {
    spawnDiamond();
    resetTimer();
  }
  updateAndDrawDiamonds();
}

void updateDiamondTimer() {
  timer++;
}

void adjustInterval() {
  interval = mouseY;
}

boolean shouldSpawnDiamond() {
  return timer >= interval;
}

void spawnDiamond() {
  
}

class Point {
  float xpos, ypos;
  Point(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
}

class Diamond {
  Point origin;
  int lineSize, lineWeight, lineOffset;
  
  Diamond (Point origin, int lineSize, int lineWeight, int lineOffset) {
    this.origin = origin;
    this.lineSize = lineSize;
    this.lineWeight = lineWeight;
    this.lineOffset = lineOffset;
  }
  
  void update() {
    this.lineSize = mouseY;
  }
  
  void render() {
    setupStyle();
    setupPosition();
    
    renderSides();
    
    cleanStyle();
    cleanPosition();
  }
  
  void renderSides() {
    line(-lineSize/2, -lineSize/2, lineSize/2, -lineSize/2);
    line(lineSize/2 + lineOffset, -lineSize/2 + lineOffset,
      lineSize/2 + lineOffset, lineSize/2 + lineOffset);
    line(lineSize/2, lineSize/2 + 2*lineOffset, -lineSize/2, lineSize/2 + 2*lineOffset);
    line(-lineSize/2 - lineOffset, lineSize/2 + lineOffset, -lineSize/2 - lineOffset,
      -lineSize/2 + lineOffset);
  }
  
  private void setupStyle() {
    pushStyle();
    stroke(255);
    strokeWeight(this.lineWeight);
  }
  
  private void setupPosition() {
    pushMatrix();
    moveToOrigin();
    rotate(PI/4);
  }
  
  private void cleanStyle() {
    popStyle();
  }
  
  private void cleanPosition() {
    popMatrix();
  }
  
  private void moveToOrigin() {
    translate(origin.xpos, origin.ypos);
  }
}

