Diamond[] diamonds = new Diamond[2000];
int nextDiamondIndex = 0;
int timer = 0;
int interval = 0;

void setup() {
  size(900, 300, P3D);
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
  interval = max(5, mouseY);
}

boolean shouldSpawnDiamond() {
  return timer >= interval;
}

void pushDiamond() {
  Point origin = new Point(width/2-200, height/2-200, -1000);
  diamonds[nextDiamondIndex++] = new Diamond(origin, 100, 2, 6);
}

void updateAndDrawDiamonds() {
  for (int i = 0; i < nextDiamondIndex; i++) {
    Diamond diamond = diamonds[i];
    diamond.update();
    diamond.render();
  }
}
void resetTimer() {
  timer = 0;
}

class Point {
  float xpos, ypos, zpos;
  Point(float xpos, float ypos, float zpos) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.zpos = zpos;
  }
}

class Diamond {
  Point origin, startPos;
  int lineSize, lineWeight, lineOffset, lifetime;
  float rotation;
  float rotationDelta, depthDelta;
  
  Diamond (Point origin, int lineSize, int lineWeight, 
    int lineOffset) {
    this.startPos = new Point(origin.xpos, origin.ypos, origin.zpos);
    this.origin = new Point(origin.xpos, origin.ypos, origin.zpos);
    this.origin.xpos = pushTowards(origin.xpos, width/2, 4);
    this.origin.ypos = pushTowards(origin.ypos, height/2, 4);
    
    this.lineSize = lineSize;
    this.lineWeight = lineWeight;
    this.lineOffset = lineOffset;
    
    this.lifetime = 0;
    
    this.rotation = 0;
    this.rotationDelta = PI/128;
  }
  
  void update() {
    moveTowardsViewer();
    spinAround();
    updateLifetime();
  }
  
  void moveTowardsViewer() {
    origin.zpos += 5*(lifetime/100);
    origin.ypos = smoothStep(startPos.ypos, height/2, origin.ypos);
    origin.xpos = smoothStep(startPos.xpos, width/2, origin.xpos);
  }
  
  void spinAround() {
    rotation += rotationDelta;
  }
  
  void updateLifetime() {
    lifetime++;
  }
  
  void render() {
    setupStyle();
    setupPosition();
    
    renderSides();
    
    cleanStyle();
    cleanPosition();
  }
  
  void renderSides() {
    renderTopLeft();
    renderTopRight();
    renderBottomLeft();
    renderBottomRight();
  }
  
  void renderTopLeft() {
    line(-lineSize/2, -lineSize/2, lineSize/2, -lineSize/2);
  }
  
  void renderTopRight() {
    line(lineSize/2 + lineOffset, -lineSize/2 + lineOffset,
      lineSize/2 + lineOffset, lineSize/2 + lineOffset);
  }
  
  void renderBottomLeft() {
    line(-lineSize/2 - lineOffset, lineSize/2 + lineOffset, 
      -lineSize/2 - lineOffset, -lineSize/2 + lineOffset);
  }
  
  void renderBottomRight() {
    line(lineSize/2, lineSize/2 + 2*lineOffset, 
      -lineSize/2, lineSize/2 + 2*lineOffset);
  }
  
  private void setupStyle() {
    pushStyle();
    stroke(255);
    strokeWeight((float)this.lineWeight);
  }
  
  private void cleanStyle() {
    popStyle();
  }
  
  private void moveToOrigin() {
    translate(origin.xpos, origin.ypos, origin.zpos);
  }
  
  private void setupPosition() {
    pushMatrix();
    moveToOrigin();
    rotate(PI/4 + rotation);
  }
  
  private void cleanPosition() {
    popMatrix();
  }
}

float pushTowards(float value, float target, float speed) {
  if (value < target) {
    return min(value+speed, target);
  } else {
    return max(value-speed, target);
  }
}

float smoothStep(float start, float end, float current) {
  println("Start: " + str(start));
  println("Current: " + str(current));
  // see smoothstep wiki article for documentation
  float t = (current-start)/(end-start);
  println("t: " + str(t));
  return lerp(start, end, t*t*(3 - 2*t));
}
