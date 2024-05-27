import processing.net.*;  // Import the net library
import java.util.concurrent.*;  // Import for concurrent utilities

Server myServer;  // Declare a Server object
int serverPort = 12345;  // Define the server port

ExecutorService executor = Executors.newCachedThreadPool();  // Thread pool for managing threads

PImage carImage;
PImage lockImage;
PImage loopImage;
PImage openLockImage;
PImage perfumeImage;
PImage weatherStatusImage;

PImage upArrowImage;
PImage downArrowImage;
PImage leftArrowImage;
PImage rightArrowImage;

PImage homeImage;
PImage navImage;
PImage phoneImage;
PImage batteryImage;
PImage settingsImage;

PImage fastChargingImage;

PFont font;
PFont fontBold;

// Global color variables
color darkGrayishBlue = #1f232d;  
color veryDarkGrayishBlue = #16181e;
color glowBlue = #069DD4;
color green = #34a979;
color purple = #785EC9;
color pink = #CF2626;
color mainColor =  glowBlue;
color white = #ffffff;

boolean ldLock = false;
boolean rdLock = true;
boolean hLock = true;
int batteryLevel = 90;
int remainingKm = 600;
int travelledKm = 100;

int degree = 25;
boolean closedLoop = true;
boolean auto = true;
boolean frag = true;
int fanLevel = 1;

int temp = 35;
int humidity = 40;
int windSpeed = 2;
int condition = 1;

int lOrR = 0;
float upperAngle=90.0;
float animatedUpperAngle = 90.0;
int lowerAngle=8;
boolean warmer = false;
boolean massage = true;



void setup() {
  myServer = new Server(this, serverPort);
  println("Server started on port " + serverPort);
  // Start the thread for accepting clients
  thread("acceptClients");
  
  fullScreen();
  loadResources();
  
}

void draw() {  
  background(darkGrayishBlue);
  
  // Draw UI cards
  drawClimateControlCard(700, 125, degree, closedLoop, auto, frag, fanLevel);
  drawCarAccessCard(1170, 125, ldLock, rdLock, hLock, batteryLevel, remainingKm, travelledKm);
  drawWeatherCard(700, 555, temp, humidity, windSpeed, condition);
  drawComfortCard(230, 125, lOrR, upperAngle, lowerAngle,warmer,massage);
  drawProfileCard(230, 835);

  //// Draw grid
  //drawGrid();
  
  //fill(0);
  //rect(0, 0, 200, 100);
  //fill(white);
  //text(mouseX + " : " + mouseY, 50, 50);
  
  //text("LD Lock: " + ldLock, 10, 50);
  //text("RD Lock: " + rdLock, 10, 70);
  //text("H Lock: " + hLock, 10, 90);
  //text("Battery Level: " + batteryLevel, 10, 110);
  //text("Remaining Km: " + remainingKm, 10, 130);
  //text("Travelled Km: " + travelledKm, 10, 150);
}

void loadResources() {
  carImage = loadImage("car.png");
  lockImage = loadImage("closedLock2.png");
  openLockImage = loadImage("open-lock.png");
  loopImage = loadImage("loop.png");
  perfumeImage = loadImage("perfume.png");
  weatherStatusImage = loadImage("night.png");
  
  upArrowImage = loadImage("up-arrow.png");
  downArrowImage = loadImage("down-arrow.png");
  leftArrowImage = loadImage("left-arrow.png");
  rightArrowImage = loadImage("right-arrow.png");
  
  homeImage = loadImage("home.png");
  navImage = loadImage("navigation.png");
  phoneImage = loadImage("phone.png");
  batteryImage = loadImage("battery.png");
  settingsImage = loadImage("settings.png");
  
  fastChargingImage = loadImage("electricity.png");
  
  font = createFont("OpenSans_Condensed-Light.ttf", 24);
  fontBold = createFont("OpenSans_Condensed-Bold.ttf", 24);
}

void drawGrid() {
  strokeWeight(0.1);
  stroke(white);
  for (int i = 0; i < width; i += 10) {
    line(i, 0, i, height);
  }
  for (int j = 0; j < height; j += 10) {
    line(0, j, width, j);
  }
}

void drawCarAccessCard(int x, int y, boolean LDlock, boolean RDlock, boolean Hlock, int bl, int rKm, int tKm) {
  strokeWeight(0);
  fill(veryDarkGrayishBlue);
  rect(x, y, 460, 850, 20);
  fill(mainColor);
  rect(x + 455, y + 50, 5, 200, 20);
  
  if (LDlock) {
    image(lockImage, x + 75, y + 450);
  } else {
    image(openLockImage, x + 75, y + 450);
  }
  if (RDlock) {
    image(lockImage, x + 340, y + 450);
  } else {
    image(openLockImage, x + 340, y + 450);
  }
  if (Hlock) {
    image(lockImage, x + 212, y + 670);
  } else {
    image(openLockImage, x + 212, y + 670);
  }
  
  image(carImage, x + 120, y + 150);
  
  fill(white);
  textFont(fontBold);
  text(rKm, x + 70, y + 770);
  text(bl + "%", x + 215, y + 770);
  text(tKm, x + 355, y + 770);
  
  textFont(font);
  text("Remaining", x + 50, y + 800);
  text("Battery", x + 210, y + 800);
  text("Travelled", x + 340, y + 800);
  
  textSize(32);
  text("Access", x + 20, y + 40);
}

void drawClimateControlCard(int x, int y, int degree, boolean closedLoop, boolean auto, boolean frag, int fanLevel) {
  int w = 460, h = 420;
  strokeWeight(0);
  fill(veryDarkGrayishBlue);
  rect(x, y, w, h, 20);
  fill(mainColor);
  rect(x + 455, y + 50, 5, 100, 20);
  
  fill(white);
  textFont(font);
  textSize(32);
  text("Climate", x + 20, y + 40);
  
  textSize(64);
  text(degree + " °", x + 200, y + 235);
  
  noFill();
  strokeWeight(10);
  stroke(mainColor,150);
  ellipse(x + 225, y + 210, 200, 200);
  stroke(mainColor);
  ellipse(x + 225, y + 210, 180, 180);
  
  fill(white);
  textFont(fontBold);
  text(fanLevel, x + 382, y + 355);
  
  textFont(font);
  text("Fan", x + 375, y + 385);
  text("Auto", x + 155, y + 385);
  
  fill(mainColor);
  strokeWeight(0);
  textSize(28);
  if (auto){
    fill(mainColor,150);
    ellipse(x + 173, y + 350, 10, 10);
    fill(mainColor);
    ellipse(x + 173, y + 350, 5, 5);
  }
  
  image(loopImage, x + 50, y + 365,loopImage.width/1.25,loopImage.height/1.25);
  if (closedLoop){
    fill(mainColor,150);
    ellipse(x + 65, y + 350, 10, 10);
    fill(mainColor);
    ellipse(x + 65, y + 350, 5, 5);
  }
  image(perfumeImage, x + 273, y + 365,perfumeImage.width/1.25,perfumeImage.height/1.25);
  if (frag){
    fill(mainColor,150);
    ellipse(x + 285, y + 350, 10, 10);
    fill(mainColor);
    ellipse(x + 285, y + 350, 5, 5);
  }
}

void drawWeatherCard(int x, int y, int temp, int humidity, int windSpeed, int condition) {
  int w = 460, h = 420;
  strokeWeight(0);
  fill(veryDarkGrayishBlue);
  rect(x, y, w, h, 20);
  fill(mainColor);
  rect(x + 455, y + 50, 5, 100, 20);
  
  fill(white);
  textFont(font);
  textSize(32);
  text("Weather", x + 20, y + 40);
  
  textSize(28);
  text("Outside", x + 50, y + 180);
  text("Humidity", x + 300, y + 180);
  text("Wind Speed", x + 50, y + 370);
  text("Condition", x + 300, y + 370);
  
  textFont(fontBold);
  textSize(32);
  text(temp + "°", x + 70, y + 150);
  text(humidity + "%", x + 320, y + 150);
  text(windSpeed + " km/h", x + 60, y + 335);
  image(weatherStatusImage, x + 320, y + 300);
  
  strokeWeight(10);
  stroke(mainColor,150);
  line(x + 100, y + 240, x + 360, y + 240);
  strokeWeight(2);
  stroke(mainColor);
  line(x + 150, y + 240, x + 310, y + 240);
}

void drawComfortCard(int x, int y, int lOrR, float upperAngle, int lowerAngle, boolean warmer, boolean massage) {
  int w = 460, h = 700;
  strokeWeight(0);
  fill(veryDarkGrayishBlue);
  rect(x, y, w, h, 20);
  fill(mainColor);
  rect(x + 455, y + 50, 5, 150, 20);
  
  fill(white);
  textFont(font);
  textSize(32);
  text("Comfort", x + 20, y + 40);
  
  image(leftArrowImage, x + 320, y + 530, leftArrowImage.width / 2, leftArrowImage.height / 2);
  text((int)animatedUpperAngle + "°", x + 355, y + 550);
  image(rightArrowImage, x + 400, y + 530, rightArrowImage.width / 2, rightArrowImage.height / 2);
  
  image(upArrowImage, x + 45, y + 495, upArrowImage.width / 2, upArrowImage.height / 2);
  text(lowerAngle + "°", x + 50, y + 550);
  image(downArrowImage, x + 45, y + 555, downArrowImage.width / 2, downArrowImage.height / 2);
  
  textSize(24);
  text("Warmer",x + 90, y + 650);
  text("Massage",x + 300, y + 650);
  
  if(warmer){
    fill(mainColor,150);
    ellipse(x + 120, y + 620, 10, 10);
    fill(mainColor);
    ellipse(x + 120, y + 620, 5, 5);
    
  }
  
  if(massage){
    fill(mainColor,150);
    ellipse(x + 335, y + 620, 10, 10);
    fill(mainColor);
    ellipse(x + 335, y + 620, 5, 5);
    
  }
  
  strokeWeight(5);
  textFont(fontBold);
  textSize(32);
  if (lOrR == 0) {
    fill(white, 255);
    text("L", x + 50, y + 150);
    fill(white, 100);
    text("R", x + 400, y + 150);
    stroke(255);
    line(x + 50, y + 160, x + 62, y + 160);
    stroke(255,150);
    line(x + 402, y + 160, x + 414, y + 160);
  } else {
    fill(white, 255);
    text("R", x + 400, y + 150);
    fill(white, 100);
    text("L", x + 50, y + 150);
    stroke(255,150);
    line(x + 50, y + 160, x + 62, y + 160);
    stroke(255);
    line(x + 402, y + 160, x + 414, y + 160);
  }
  
  drawCarSeat(x - 30, y - 30, upperAngle, lowerAngle, color(mainColor),1);
}

void drawCarSeat(float x, float y, float upperAngle, int lowerAngle, color c, float scale) {
  colorMode(HSB, 360, 100, 100);
  fill(c,150);
  strokeWeight(0);
  
  pushMatrix();
  translate(x + 320, y + 512);
  if((int)animatedUpperAngle < (int)upperAngle){
    animatedUpperAngle += 0.1;
  }
  else if((int)animatedUpperAngle > (int)upperAngle){
    animatedUpperAngle -= 0.1;
  }
  rotate(radians(map(animatedUpperAngle, 90, 120, 0, 25)));
  
  scale(scale);
  beginShape();
  vertex(33, -256);
  bezierVertex(25, -284, 37, -208, -1, -173);
  bezierVertex(-3, -171, -84, -67, 0, 0);
  bezierVertex(0, 0, 96, -134, 33, -256);
  endShape();
  
  scale(scale*0.6);
  fill(c);
  beginShape();
  vertex(33, -256);
  bezierVertex(25, -284, 37, -208, -1, -173);
  bezierVertex(-3, -171, -84, -67, 0, 0);
  bezierVertex(0, 0, 96, -134, 33, -256);
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(x + 309, y + 525); 
  
  scale(scale);
  fill(c,150);
  beginShape();
  vertex(-209, -42);
  bezierVertex(-209, -42, -121, 33, 0, 0);
  bezierVertex(0, 0, -24, -81, -126, -45);
  bezierVertex(-126, -45, -147, -30, -209, -42);
  endShape();
  
  scale(scale*0.6);
  fill(c);
  beginShape();
  vertex(-209, -42);
  bezierVertex(-209, -42, -121, 33, 0, 0);
  bezierVertex(0, 0, -24, -81, -126, -45);
  bezierVertex(-126, -45, -147, -30, -209, -42);
  endShape();
  
  popMatrix();
  
}

void drawProfileCard(int x, int y) {
  int w = 460, h = 140;
  fill(veryDarkGrayishBlue);
  rect(x, y, w, h, 20);
  //fill(mainColor);
  //rect(x + 455, y + 20, 5, 50, 20);
  
  //image(fastChargingImage,x,y+20);
  
  //textFont(fontBold);
  //textSize(32);
  //fill(white);
  //text("Fast-X Charger",x+100,y+50);
  
  //textFont(font);
  //text("Explore the new fast charger\npreorder now",x+100,y+85);
  
  fill(white);
  textFont(font);
  textSize(32);
  text("Health", x + 20, y + 40);
}

void drawNavigationCard(int x, int y) {
  int w = 120, h = 850;
  fill(mainColor,125);
  rect(x, y, w, h, 20);
  strokeWeight(3);
  stroke(white);
  
  image(homeImage,x+15,y+50);
  line(x+35,y+150,x+85,y+150);
  
  image(navImage,x+15,y+200);
  image(phoneImage,x+15,y+350);
  image(batteryImage, x+15,y+500);
  image(settingsImage, x+15,y+650);
  
}

void acceptClients() {
  while (true) {
    // Check for incoming clients
    Client thisClient = myServer.available();
    if (thisClient != null) {
      println("Client connected: " + thisClient.ip() );
      // Handle client in a separate thread
      executor.submit(new ClientHandler(thisClient));
    }
    delay(100);  // Sleep briefly to prevent excessive CPU usage
  }
}

class ClientHandler implements Runnable {
  Client client;

  ClientHandler(Client client) {
    this.client = client;
  }

  public void run() {
    try {
      while (true) {
        // Read data from the client
        String input = client.readString();
        if (input != null) {
          input = input.trim();
          println("Received from client: " + input);
          handleData(input);
        }
        delay(100);  // Sleep briefly to prevent excessive CPU usage
      }
    } catch (Exception e) {
      println("Client disconnected");
      client.stop();
    }
  }
}

void stop() {
  executor.shutdown();  // Shut down the thread pool
  super.stop();
}

void handleData(String data) {
  String[] tokens = split(data, ' ');
  for(String s : tokens){
    println("token: "+s+" "+s.length());
  }
  
  if(tokens[0].equals("Lock") && tokens[1].equals("FLD")) ldLock = true;
  if(tokens[0].equals("Unlock") && tokens[1].equals("FLD")) ldLock = false;
  if(tokens[0].equals("Lock") && tokens[1].equals("FRD")) rdLock = true;
  if(tokens[0].equals("Unlock") && tokens[1].equals("FRD")) rdLock = false;
  if(tokens[0].equals("Lock") && tokens[1].equals("HOOD")) hLock = true;
  if(tokens[0].equals("Unlock") && tokens[1].equals("HOOD")) hLock = false;
  if(tokens[0].equals("AC_Loop") && tokens[1].equals("ON")) closedLoop = true;
  if(tokens[0].equals("AC_Loop") && tokens[1].equals("OFF")) closedLoop = false;
  if(tokens[0].equals("AC_Auto") && tokens[1].equals("ON")) auto = true;
  if(tokens[0].equals("AC_Auto") && tokens[1].equals("OFF")) auto = false;
  if(tokens[0].equals("AC_Frag") && tokens[1].equals("ON")) frag = true;
  if(tokens[0].equals("AC_Frag") && tokens[1].equals("OFF")) frag = false;
  if(tokens[0].equals("AC_Fan")){ fanLevel = Integer.valueOf(tokens[1]); println(fanLevel);}
  if(tokens[0].equals("AC_Deg")) degree = Integer.valueOf(tokens[1]);
  if(tokens[0].equals("Comfort_LOrR") && tokens[1].equals("L")) lOrR = 0;
  if(tokens[0].equals("Comfort_LOrR") && tokens[1].equals("R")) lOrR = 1;
  if(tokens[0].equals("Comfort_UA")) upperAngle = Float.valueOf(tokens[2]);
  if(tokens[0].equals("Comfort_LA")) lowerAngle = Integer.valueOf(tokens[2]);
  if(tokens[0].equals("Comfort_Warmer")&& tokens[2].equals("ON")) warmer = true;
  if(tokens[0].equals("Comfort_Warmer")&& tokens[2].equals("OFF")) warmer = false;
  if(tokens[0].equals("Comfort_Massage")&& tokens[2].equals("ON")) massage = true;
  if(tokens[0].equals("Comfort_Massage")&& tokens[2].equals("OFF")) massage = false;
  if(tokens[0].equals("Theme")){
    if(tokens[1].equals("RED")){
      mainColor = pink;
    }
    else if(tokens[1].equals("GREEN")){
      mainColor = green;
    }
    else if(tokens[1].equals("PURPLE")){
      mainColor = purple;
    }
    else if(tokens[1].equals("BLUE")){
      mainColor = glowBlue;
    }
  }
}
