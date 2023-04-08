//need install: tools > manage tools> libraries > GifAnimation
import gifAnimation.*;
import ddf.minim.*;

Controller controller;
View view;

IntList pkeys = new IntList(); 

// Menu
Minim minim;
AudioPlayer bgMusic, click, shoot, enemyHurt,  trampoline, portal, stab, 
playerHurt, mining, enemyShoot, touchGround, ding;

// SoundFile bgMusic;
PImage bgImg, optionImg, optionMuteImg, rankImg, gameoverImg;
PImage inGameHome, inGameMute, inGamePause;

Difficulty dif;

/**
* Initialize all project, run once
*/
void setup(){
    
    size(1160,800);
    dif = new Difficulty();
        
    Model model = new Model();
    
    EnemyFactory e = new EnemyFactory();
    GifsToEenemyFactory(e);
    model.enemyFactory = e;
    //model.addBossToMap();
    ItemFactory t = new ItemFactory();
    Player p = new Player();
    p.weapons[0] = t.weaponPistol();
    p.weapons[1] = t.weaponMinergun();
    GifsToPlayer(p);
    
    DecorationFactory d = new DecorationFactory();
    GifsToDecorationFactory(d);
    d.addDecorationToRoom(model.map.rooms.get(0));
    model.addPlayer(p);
    model.itemFactory = t;
    model.decorationFactory = d;
    
    initMenu();
    if (model.isMusicPlaying){
      bgMusic.play();
    }
    
    controller = new Controller(model);
    //Collision c = new Collision(g);
    //controller.collision = c;
    view = new View(model);

}


/**
* Code inside will run by order in each frame
*/
void draw(){
    
    mouseListener();
    keyListener();

    controller.display();
    view.paint();
  
}

public void GifsToPlayer(Player p){
     PImage[] playerStand = Gif.getPImages(this, "imgs/player/playerStand.gif");
     PImage[] playerRun = Gif.getPImages(this, "imgs/player/playerRun.gif");
     PImage[] playerJump = Gif.getPImages(this, "imgs/player/playerJump.gif");

     p.addGifsImgs(playerStand, playerRun, playerJump);
     
     PImage[] hpGif = Gif.getPImages(this, "imgs/player/hp.gif");
     for(PImage hp : hpGif){
         hp.resize(Type.BOARD_GRIDSIZE *2/3, Type.BOARD_GRIDSIZE *2/3);
     }
     p.hpGif = hpGif;
     
}

/**
* Load all gifs for enemies
*/
public void GifsToEenemyFactory(EnemyFactory e){
     //gifs for gunner
     ArrayList<PImage[]> gunnerGifs = new ArrayList();
     PImage[] gunner = Gif.getPImages(this, "imgs/enemy/gunner.gif");
     PImage[] gunnerDeath = Gif.getPImages(this, "imgs/enemy/gunnerDeath.gif");

     gunnerGifs.add(gunner);
     gunnerGifs.add(gunnerDeath);

     ArrayList<PImage[]> alienFlyGifs = new ArrayList();
     PImage[] alienFly = Gif.getPImages(this, "imgs/enemy/fly1.gif");
     PImage[] alienFlyDeath = Gif.getPImages(this, "imgs/enemy/fly2.gif");
     alienFlyGifs.add(alienFly);
     alienFlyGifs.add(alienFlyDeath);
     
     ArrayList<PImage[]> alienSpiderGifs = new ArrayList();
     PImage[] alienSpider = Gif.getPImages(this, "imgs/enemy/spider.gif");
     PImage[] alienSpiderDeath = Gif.getPImages(this, "imgs/enemy/spider.gif");
     alienSpiderGifs.add(alienSpider);
     alienSpiderGifs.add(alienSpiderDeath);

     ArrayList<PImage[]> alienKillerGifs = new ArrayList();
     PImage[] alienKiller = Gif.getPImages(this, "imgs/enemy/boss1.gif");
     PImage[] alienKillerDeath = Gif.getPImages(this, "imgs/enemy/boss1.gif");
     alienKillerGifs.add(alienKiller);
     alienKillerGifs.add(alienKillerDeath);

     //gifs for others...

     e.addEnemyGifs(gunnerGifs, alienFlyGifs, alienSpiderGifs, alienKillerGifs);
}

/**
* Load all gifs for enemies
*/
public void GifsToDecorationFactory(DecorationFactory d){
     //gifs for gunner
     PImage[] jumpEffect = Gif.getPImages(this, "imgs/effect/jump_effect.gif");
     PImage[] portalEffect = Gif.getPImages(this, "imgs/effect/portal_effect.gif");
     PImage[] blood = Gif.getPImages(this, "imgs/effect/blood.gif");
     PImage[] pressE = Gif.getPImages(this, "imgs/effect/pressE.gif");
     PImage[] crystal = Gif.getPImages(this, "imgs/decoration/d1.gif");
     PImage[] hp = Gif.getPImages(this, "imgs/decoration/d2.gif");
     PImage[] d3 = Gif.getPImages(this, "imgs/decoration/d3.gif");
     PImage[] arrow_down = Gif.getPImages(this, "imgs/decoration/arrow_down.gif");
     PImage[] arrow_left = Gif.getPImages(this, "imgs/decoration/arrow_left.gif");
     PImage[] arrow_right = Gif.getPImages(this, "imgs/decoration/arrow_right.gif");
     PImage[] arrow_up = Gif.getPImages(this, "imgs/decoration/arrow_up.gif");
     
     d.addDecorationGifs(jumpEffect, portalEffect, blood, pressE, crystal, hp, d3, arrow_down, arrow_left, arrow_right, arrow_up);
}


public void initMenu(){

    // Menu
    bgImg = loadImage("Data/imgs/menu/background.png");
    optionImg = loadImage("Data/imgs/menu/option.png");
    gameoverImg = loadImage("Data/imgs/menu/gameover.png");
    optionMuteImg = loadImage("Data/imgs/menu/option_mute.png");
    rankImg = loadImage("Data/imgs/menu/rank.png");
    inGameHome = loadImage("Data/imgs/menu/home.png");
    inGameMute = loadImage("Data/imgs/menu/music.png");
    inGamePause = loadImage("Data/imgs/menu/pause.png");
    minim = new Minim(this);
    bgMusic = minim.loadFile("Data/music/bgmusic.mp3");
    bgMusic.setGain(-10);
    click = minim.loadFile("Data/music/click.mp3");
    click.setGain(-8);
    shoot = minim.loadFile("Data/music/shoot.mp3");
    shoot.setGain(-18);
    portal = minim.loadFile("Data/music/portal.wav");
    portal.setGain(-5);
    enemyHurt = minim.loadFile("Data/music/enemyHurt.wav");
    //enemyHurt.setGain(-5);
    playerHurt = minim.loadFile("Data/music/playerHurt.wav");
    playerHurt.setGain(-5);
    mining = minim.loadFile("Data/music/mining.wav");
    enemyShoot = minim.loadFile("Data/music/enemyShot.wav");
    touchGround = minim.loadFile("Data/music/touchGround.wav");
    ding = minim.loadFile("Data/music/ding.wav");
    stab = minim.loadFile("Data/music/stabbed.mp3");
    stab.setGain(-3);
    trampoline = minim.loadFile("Data/music/trampoline.wav");

}

/**
* Processing can not record two keys at one time,
* so we have to use a list to record keys
*/
public void keyListener(){

    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
  
    if(pkeys.size()== 0) return;
    
    for(int i=pkeys.size()-1; i>=0; i--){
      if(validKey(pkeys.get(i))){
        if(pkeys.hasValue(Type.KEY_S) && pkeys.hasValue(Type.KEY_SPACE)){
          controller.controlPlayer(Type.KEY_S_SPACE);
        }else{
          controller.controlPlayer(pkeys.get(i));
        }
        
      }      
    }
    
}

public boolean validKey(int value){
  if(value == Type.KEY_D 
  || value == Type.KEY_A 
  || value == Type.KEY_SPACE
  || value == Type.KEY_W
  || value == Type.KEY_S
  ){
  return true;
  }
  return false;
}


public void keyPressed(){
  
    //only work when game starts
    if(!controller.getGameStart()){
        return;
    }
    
    //use WASD to move
    if(!pkeys.hasValue(int(key))) {
      pkeys.append(int(key));
    }
    
}

public void keyReleased(){

   if(key == 'p'){
      controller.setGamePause(controller.getGamePause() ? false : true);
    }
  
    //only work when game starts
    if(!controller.getGameStart()  || controller.getGamePause()){
        return;
    }
    //use WASD to move
    for(int i=pkeys.size()-1; i>=0; i--){
      if(pkeys.get(i) == int(key)){
          pkeys.remove(i); 
      }
    }
    
    if((int)key == 32){
        controller.controlPlayer(Type.KEY_RELEASED_SPACE);
    }
    
    if(key == 'a' || key == 'd'){
      controller.controlPlayer(Type.KEY_RELEASED_AD);
    }
    if(key == 'w' || key == 's'){
      controller.controlPlayer(Type.KEY_RELEASED_WS);
    }
    if(key == 'f'){
      controller.controlPlayer(Type.KEY_F);
    }
    if(key == 'e'){
      controller.controlPlayer(Type.KEY_E);
    }
    if(key == 'q'){
      controller.controlPlayer(Type.KEY_Q);
    }
    if(key == 'r'){
      controller.controlPlayer(Type.KEY_R);
    }
    
    
    
}

public void mouseListener(){
   //only work when game starts
   if(controller.getGameStart() && !controller.getGamePause()){
        if(mousePressed == true && mouseButton == LEFT){
           controller.shotBullet();
        }
    }

}

public void mouseReleased(){
    
  if(controller.getMenuHomePage()){
    //check mouse position, if in position and released, change booleans in model
    // Clicked on Start
    if (mouseX > 201 && mouseX < 433 && mouseY > 156 && mouseY < 253) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setGameStart(true);
    }
    // Click Option
    if (mouseX > 201 && mouseX < 433 && mouseY > 281 && mouseY < 378) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setMenuControl(true);
    }
    
    // Click history ranking
    if (mouseX > 201 && mouseX < 433 && mouseY > 406 && mouseY < 503) {
      click.play(2);
      controller.setMenuHomePage(false);
      controller.setGlobalList(true);
    }
    
    // Click Quit
    if (mouseX > 201 && mouseX < 433 && mouseY > 531 && mouseY < 628) {
      click.play(2);
      exit();
    }
    
  } else if(controller.getMenuControl()){
     //there should be a return button in this menu
         
    // Switch Music ON/OFF
    if (mouseX > 485 && mouseX < 676 && mouseY > 306 && mouseY < 386) {
      if (controller.getIsMusicPlaying()) {
        click.play(2);
        bgMusic.pause();
        controller.setIsMusicPlaying(false);
      } else {
        click.play(2);
        bgMusic.play();
        controller.setIsMusicPlaying(true);
      }
      // isOptionMenuOpen = false;
    }
    
    // Return button
    if (mouseX > 485 && mouseX < 676 && mouseY > 414 && mouseY < 494) {
      click.play(2);
      controller.setMenuControl(false);
      controller.setMenuHomePage(true);
    }
    
  }
  else if(controller.getGlobalList()){
     //there should be a return button in this menu
   if (mouseX > 485 && mouseX < 675 && mouseY > 631 && mouseY < 710) {
      click.play(2);
      controller.setGlobalList(false);
      controller.setMenuHomePage(true);
    }
  }
  
  else if(controller.getGamePause()){
      //there should be a restart button in this menu

  }
  
  else if(controller.getGameOver()){
      //there should be a restart button in this menu
      
      // Restart
      if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
        controller.setGameStart(true);
        controller.setGameOver(false);
      }
  }
  //only work when game starts
  else{
    
    // In game menu
    // Homepage button
    if (mouseX > 1100 && mouseX < 1153 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      controller.setGameStart(false);
      controller.setMenuHomePage(true);
    }
    // Pause
    if (mouseX > 1030 && mouseX < 1083 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      if (controller.getGameStart()){
        controller.setGameStart(false);
      } else {
        controller.setGameStart(true);
      }
    }
    // Music ON/OFF
    if (mouseX > 960 && mouseX < 1013 && mouseY > 10 && mouseY < 47) {
      click.play(2);
      if (controller.getIsMusicPlaying()){
        bgMusic.pause();
        controller.setIsMusicPlaying(false);
      } else {
        bgMusic.play();
        controller.setIsMusicPlaying(true);
      }
    }
        
    if(mouseButton == LEFT){
        controller.controlPlayer(Type.MOUSE_LEFT);
        if(mining.isPlaying()){
           mining.pause();
        }
    }
    if(mouseButton == RIGHT){
        controller.controlPlayer(Type.MOUSE_RIGHT);
    }
  }
}

public void mousePressed(){
  
}

void stop(){
  bgMusic.close();
  minim.stop();
  
  super.stop();
}
