Diamond[] diamonds = new Diamond[2000];
int nextDiamondIndex = 0;
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
    pushDiamond();
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

void pushDiamond() {
  Point origin = new Point(width/2, height/2);
  diamonds[nextDiamondIndex++] = new Diamond(origin, 5, 4, 6);
}

void updateAndDrawDiamonds() {
  for (int i=0; i < nextDiamondIndex; i++) {
    Diamond diamond = diamonds[i];
    diamond.update();
    diamond.render();
  }
}
void resetTimer() {
  timer = 0;
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
    this.lineSize += 5;
  }
  
  void render() {
    setupStyle();
    setupPosition();
    
    renderSides();
    
    cleanStyle();
    cleanPosition();
  }
  
  void renderSides() {
    line(-lineSize/2, -lineSize/2, lineSize/2, -lineSize/2); // top (upper left)
    line(lineSize/2 + lineOffset, -lineSize/2 + lineOffset,
      lineSize/2 + lineOffset, lineSize/2 + lineOffset); // right (upper right)
    line(lineSize/2, lineSize/2 + 2*lineOffset, 
      -lineSize/2, lineSize/2 + 2*lineOffset); // bottom (bottom right)
    line(-lineSize/2 - lineOffset, lineSize/2 + lineOffset, -lineSize/2 - lineOffset,
      -lineSize/2 + lineOffset); // left (bottom left)
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

