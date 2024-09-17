class BouncingBallSystem {
  gravity = createVector(0, 0, -9.81);
  m = 1;
  P = this.gravity.mult(this.m);

  constructor() {
    this.bouncingBalls = [];
    this.box = new BoxFrame(1000, 1000, 500);
  }

  addBall(x, y, z) {
    this.bouncingBalls.push(new BouncingBall(x, y, z, this.m));
  }

  run() {
    this.box.display();
    for (let i = 0; i < this.bouncingBalls.length; i++) {
      let b = this.bouncingBalls[i];
      b.applyForce(this.P);
      this.bounceBoundaries(b);
      this.checkCollision(b);
      b.run();
    }
  }

  checkCollision(b) {
    for (let j = 0; j < this.bouncingBalls.length; j++) {
      let other = this.bouncingBalls[j];
      let dist = p5.Vector.dist(b.position, other.position);
      if (dist < b.radius + other.radius) {
        this.resolveCollision(b, other);
        break;
      }
    }
  }

  resolveCollision(b1, b2) {
    let collisionNormale = p5.Vector.sub(b2.position, b1.position).normalize();
    let vitesseRelative = p5.Vector.sub(b2.vitesse, b1.vitesse);
    let vitLongNormale = p5.Vector.dot(vitesseRelative, collisionNormale);
  
    if (vitLongNormale > 0) {
      return;
    }
  
    let restitution = 0.3;
  
    let impulsAmp = -(1 - restitution) * vitLongNormale;
    let impulsion = collisionNormale.copy().mult(impulsAmp);
    let invMasse = 1 / this.m;
    
    b1.vitesse.sub(impulsion.copy().mult(invMasse));
    b2.vitesse.add(impulsion.copy().mult(invMasse));
  }

  bounceBoundaries(b) {
    if (b.position.z <= b.radius) {
      b.vitesse.z *= -b.amortissement;
      b.position.z = max(b.position.z, b.radius);
    }

    if (b.position.z >= this.box.h - b.radius) {
      b.vitesse.z *= -b.amortissement;
      b.position.z = min(b.position.z, this.box.h - b.radius);
    }

    if (b.position.x <= -this.box.w/2 + b.radius) {
      b.vitesse.x *= -b.amortissement;
      b.position.x = max(b.position.x, -this.box.w/2 + b.radius);
    }

    if (b.position.x >= this.box.w/2 - b.radius) {
      b.vitesse.x *= -b.amortissement;
      b.position.x = min(b.position.x, this.box.w/2 - b.radius);
    }

    if (b.position.y <= -this.box.d/2 + b.radius) {
      b.vitesse.y *= -b.amortissement;
      b.position.y = max(b.position.y, -this.box.d/2 + b.radius);
    }

    if (b.position.y >= this.box.d/2 - b.radius) {
      b.vitesse.y *= -b.amortissement;
      b.position.y = min(b.position.y, this.box.d/2 - b.radius);
    }
  }
}

class BoxFrame {
  constructor(w, d, h) {
    this.w = w;
    this.h = h;
    this.d = d;
  }

  display() {
    push();
    noFill();
    stroke(0, 0, 0, 150);
    strokeWeight(5);
    translate(0, 0, this.h/2);
    box(this.w, this.d, this.h);
    pop();
  }
}