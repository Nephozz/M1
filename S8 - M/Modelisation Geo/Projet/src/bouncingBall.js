class BouncingBall {
  amortissement = 0.8;
  img_chad = loadImage("../basketball.png");

  constructor(x, y, z, m) {
    this.position = createVector(x, y, z);
    this.vitesse = createVector(0, 0, 0);
    this.acceleration = createVector(0, 0, 0);
    this.radius = 20;
    this.m = m;
  }

  run() {
    this.update();
    this.display();
  }

  update() {
    this.vitesse.add(this.acceleration.mult(0.05));
    this.position.add(this.vitesse);
    this.acceleration.mult(0);
  }

  display() {
    push();
    translate(this.position.x, this.position.y, this.position.z);
    texture(this.img_chad);
    sphere(this.radius);
    pop();
  }

  applyForce(force) {
    let f = p5.Vector.div(force, this.m);
    this.acceleration.add(f);
  }
}
