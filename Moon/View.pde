/**
* @author imyuanxiao
* @participant arlo
* Class for painting. This class will draw everything for each frame by getting data from Model.class.
* Next stage: finish draw*() methods behind
*/
public class View{
  protected Model model;
  PImage help;
  
  public View(Model mod){
     this.model = mod;
     help = loadImage("imgs/menu/help.png");
     help.resize(width, height/2);
  }
  
  /**
  * Includes all methods to run in each frame
  */
  public void paint(){
    if(model.menuHomePage){
       drawMenuHomePage();
    }else if(model.menuControl){
       drawMenuControl();
    }else if(model.globalList){
       drawGlobalList();
    }else if(model.gamePause){
       drawGamePause();
    }else if(model.gameOver){
      drawGameOver();
    }else if(model.gameStart){
         drawRoom();
         //drawGhost();
         drawPlayer();
         //showAround(model.player);
         drawRoomBeforePlayer();
         // Draw in game menu
         drawInGameMenu();
         //image(this.instructionImg,0,0);
         
    }
         
  }
 
  /**
  * Draw blocks, enemies, and bullets in current room
  */
  public void drawRoom(){
     Room r = model.getCurrentRoom();  
    colorMode(HSB, 360, 100, 100);
    float hue = sin(r.tint) * 180 + 180;
     ArrayList<PImage> imgs = model.blockFactory.imgs;
     //draw room
     for(int i = 0; i < 20; i++){
        for(int j = 0; j < 29; j++){
          int type = r.blockType[i][j];
          if(emptyBack(type)){
                tint(hue, 100, 100);
             image(imgs.get(Type.BLOCK_EMPTY), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
             noTint();
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }else if(wallBack(type)){
             tint(hue, 100, 100);
             image(imgs.get(Type.BLOCK_WALL), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
             noTint();
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }else{
             tint(hue, 100, 100);
             image(imgs.get(type), j * Type.BOARD_GRIDSIZE, i * Type.BOARD_GRIDSIZE);
          }
        }
      }
      noTint();
      colorMode(RGB);
      r.display();
      if(r.index == 0){
           image(this.help,0,40);
      }
  }

   public void drawRoomBeforePlayer(){
     Room r = model.getCurrentRoom();  
     r.drawGifBeforePlayer();
   }

  public boolean emptyBack(int type){
     if(type == Type.BLOCK_SPIKE || type == Type.BLOCK_PLATFORM
     || type == Type.BLOCK_CRATE || type == Type.BLOCK_CRATE_OPEN ){
       return true;
     }
     return false;
  }

  public boolean wallBack(int type){
     if(type == Type.BLOCK_CRYSTAL || type == Type.BLOCK_BOUNCE
     || type == Type.BLOCK_PORTAL){
       return true;
     }
     return false;
  }


  public void drawPlayer(){
      Player p = model.player;
      p.display();
  }
  
  
     /**
   * Game start menu should be written here
   */
   public void drawMenuHomePage(){
     textAlign(CENTER, CENTER);
     textSize(64);
     // Draw background Image
     image(bgImg, 0, 0, width, height);
     
     /*
      // Draw Head
      fill(255);
      text("Main Menu", width/2, height/4);
      
      // Draw Game Start Button
      rectMode(CENTER);
      fill(0, 255, 0);
      rect(width/2, height*1/2, 200, 60);
      fill(255);
      textSize(32);
      text("Start", width/2, height*1/2);
      
      // Draw Option Button
      rectMode(CENTER);
      fill(0, 255, 0);
      rect(width/2, height*3/4, 200, 60);
      fill(255);
      textSize(32);
      text("Option", width/2, height*3/4);
      */
      
      
     // Tutorial?
     
     // Collection
     
     // History Ranking
     
     // Quit
   }
   
   
   // Appear during game when press "ESC"?
   public void drawMenuControl(){
     textAlign(CENTER, CENTER);
     textSize(64);
      // Draw background Image
      
      if (model.isMusicPlaying){
        image(optionImg, 0, 0, width, height);
      } else {
        image(optionMuteImg, 0, 0, width, height);
      }
     /*
     // Draw Music control Button
      rectMode(CENTER);
      if (model.getIsMusicPlaying()) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rect(width/2, height/4, 200, 60);
      fill(255);
      textSize(16);
      text("Music", width/2, height/4);
      
      // Draw Return Button
      fill(0, 255, 0);
      rect(width/2, height/2, 200, 60);
      fill(255);
      textSize(16);
      text("Return", width/2, height/2);
      */
      
   }
   
   // Menu when game is paused 
   public void drawGamePause(){
   
   }
   
   // When player lose all HP
   public void drawGameOver(){
     
     image(gameoverImg, 0, 0, width, height);
     
   // Restart
     rect(width/2, height/4, 200, 60);
      fill(255);
      textSize(16);
      text("Restart?", width/2, height*3/4);
     

   
   // Check Global Ranking
   
   // Quit
   }
   
   // Afer game finished, the marking ranking
   // Also can be accessed from Home Page Menu
   public void drawGlobalList(){
     image(rankImg, 0, 0, width, height);
   }
   
   public void drawInGameMenu(){
     image(inGameHome, 1100, 10, 53, 37);
     image(inGamePause, 1030, 10, 53, 37);
     image(inGameMute, 960, 10, 53, 37);
   }
   
}
  
  
  
  ///**
  //* Show collision detection range, can be deleted
  //*/
  //public void showAround(BasicProp o){
  //     showLeft(o);
  //     showRight(o);
  //     showUp(o);
  //     showDown(o); 
  // }

  //public void drawRect(float i, float j, float s){
  //   noFill();
  //   strokeWeight(1);
  //   rect(j * s, i * s, s, s);
  //}

  //  public void showUp(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int upper = (int)(y/s) - 1;
      
  //    int L = (int)(x/s) ;
  //    int R = (int)((x+w)/s);
  //    stroke(255);
  //    for(int i = L; i <= R; i++){
  //          drawRect(upper, i, s);
  //    }
  // }
 
  //  public void showDown(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w, h = o.h;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int below = (int)((y + h)/s) + 1;
  //    int L = (int)(x/s) ;
  //    int R = (int)((x+w)/s);
  //    stroke(255);
  //    for(int i = L; i <= R; i++){
  //          drawRect(below, i, s);
  //    }
      
  // }
 
  //  public void showLeft(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float h = o.h;
  //    float s = Type.BOARD_GRIDSIZE;
  //    int left = (int)(x/s) - 1;
      
  //    int U = (int)(y/s) ;
  //    int D = (int)((y+h)/s);
  //    stroke(155);
  //    for(int i = U; i <= D; i++){
  //          drawRect(i, left, s);
  //    }
  // }
   
  // public void showRight(BasicProp o){
  //    float x = o.location.x, y = o.location.y;
  //    float w = o.w;
  //    float s = Type.BOARD_GRIDSIZE;
  //          float h = o.h;

  //    int right = (int)((x + w)/s) + 1;
      
  //    int U = (int)(y/s) ;
  //    int D = (int)((y+h)/s);
  //    stroke(155);
  //    for(int i = U; i <= D; i++){
  //          drawRect(i, right, s);
  //    }
  // }
   
//}
