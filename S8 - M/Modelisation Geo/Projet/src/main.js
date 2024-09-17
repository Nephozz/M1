let system;
let cam;
let nb_balls = 100;
let carrelage;

function setup() {
  createCanvas(window.innerWidth, window.innerHeight, WEBGL);
  noStroke();

  carrelage = loadImage("../carrelage.webp");

  cam = createCamera();
  cam.camera(0, 1500, 250);

  system = new BouncingBallSystem();
  for (let i = 0; i < nb_balls; i++) {
    system.addBall(random(-200, 200), random(-200, 200), random(200, 450));
  }
}

function draw() {
  // Permet le mouvement de camera
  orbitControl();
  var bg_color = [135, 206, 235];
  background(bg_color);
  directionalLight(200, 200, 200, -1, -1, -1);
  ambientLight(100, 100, 100);

  push();
  translate(0, 0, -6);
  texture(carrelage);
  plane(2 * width, 2 * height);
  pop();

  system.run();
}