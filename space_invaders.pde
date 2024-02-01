//space invaders
//import processing.sound.*;

PImage ship;
int sz;//ship size
int position;//ship initial position
int control;//left right

ArrayList<Bullet> bullets;

PImage alien1;
PImage alien2;
PImage alien3;
ArrayList<Alien> aliens;

int[] aPosition = {200, 400, 600, 800, 1000, 1200, 1400, 1600};

int score;

//SoundFile f;

void setup() {
  fullScreen();

  ship = loadImage("ship.png");
  sz = 185;
  position = width/2-sz;
  control = 0;

  bullets = new ArrayList<Bullet>();

  alien1 = loadImage("monster1.png");
  alien2 = loadImage("monster2.png");
  alien3 = loadImage("monster3.png");
  aliens = new ArrayList<Alien>();

  score = 0;

  //f = new SoundFile(this, "shoot.wav");
}

void draw() {
  background(0);

  textSize(40);
  fill(255);
  text("Score:" + score, 1600, 40);

  if (millis()%30 == 0) {
    aliens.add(new Alien(aPosition[int(random(8))], 50));
  }

  image(ship, position+control, height-sz, 100, 100);

  for (int j = aliens.size()-1; j >= 0; j--) {
    Alien alien = aliens.get(j);
    alien.create();
    if (alien.y < height) {
      alien.y += 1;
    }
    if (alien.y >= height-sz) {
      aliens.remove(j);
      background(255, 0, 0);
    }

    for (int i = bullets.size()-1; i >=0; i--) {
      Bullet bullet = bullets.get(i);
      bullet.create();
      //f.play();
      if (bullet.y <= 0) {
        bullets.remove(i);
      }
      if (bullet.y > 0) {
        bullet.y-=10;
      }

      if (bullet.y < alien.y && bullet.x-25 == alien.x) {
        if (bullets.size() > 0) {
          bullets.remove(i);
        }
        aliens.remove(j);
        score++;
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {

    if (keyCode == LEFT) {
      if (position+control > sz) {
        control-=200;
      }
    }

    if (keyCode == RIGHT) {
      if (position+control < width-2*sz) {
        control+=200;
      }
    }
  } else if (key == ' ') {
    bullets.add(new Bullet(position+control+50, height-sz));
  }
}

class Bullet {
  int x; 
  int y;

  Bullet(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  void create() {
    fill(255);
    rect(x, y, 3, 50);
  }
}

class Alien {
  int x;
  int y;

  Alien(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  float r = random(3);

  void create() {
    if (r < 1) {
      image(alien1, x, y, 50, 50);
    } else if (r >= 1 && r < 2) {
      image(alien2, x, y, 50, 50);
    } else if (r >= 2 && r < 3) {
      image(alien3, x, y, 50, 50);
    }
  }
}
