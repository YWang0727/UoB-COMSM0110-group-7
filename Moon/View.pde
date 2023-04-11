/**
* @author imyuanxiao
* @participant arlo
* Class for painting. This class will draw everything for each frame by getting data from Model.class.
* Next stage: finish draw*() methods behind
*/
import controlP5.*;

ControlP5 cp5;
Textfield playerNameInput;
boolean inputFieldCreated = false;

public class View{
  protected Model model;
  Moon_MVC mvc; 
  //PImage help;
  
  public View(Moon_MVC mvc, Model model){
     this.model = model;
     this.mvc = mvc;
     //help = loadImage("imgs/menu/help.png");
     //help.resize(width, height/2);
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
         drawBoss();
         drawPlayer();
         //showAround(model.player);
         drawRoomBeforePlayer();
         // Draw in game menu
         drawInGameMenu();
         //image(this.instructionImg,0,0);
         //drawRoomNumber();
         drawDifficultyLevel();
         
    }
         
  }
  
  public void drawBoss(){
    if(model.map.enemies.size() <= 0) return;
     Enemy boss = model.map.enemies.get(0);
     boss.move(model.player.location);
     boss.display();
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
      //colorMode(RGB);
      r.display(model.player);
      //remove crystal
      r.removeBlockByPos(model.player);
      
      if(r.index == 0){
         addTutorialToStartRoom(r);
      }
      
  }

  public void drawRoomNumber(){
  
      translate(0, 0);
      noTint();
      stroke(0); 
      strokeWeight(1); 
      fill(255);
      textSize(32); 
      textAlign(RIGHT, TOP);
      text("Room Num: " + this.model.roomFactory.id, Type.BOARD_GRIDSIZE * (Type.BOARD_MAX_WIDTH - 1) + Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE *3/2); 
      //if( (this.model.roomFactory.id + 1) == 3){
      //   text("Danger is comming!!" , Type.BOARD_GRIDSIZE * (Type.BOARD_MAX_WIDTH - 1) + Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE * 5/2); 
      //}
      
  
  }
  
  public void drawDifficultyLevel(){
      fill(125, 255, 255);
      textSize(32); 
      textAlign(LEFT, TOP);
      text("Difficulty Level: " + dif.lastLevel, Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE * 5/2); 
      
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
      Item w = p.weapons[p.currentWeaponIndex];
      if(p.isShoot && w.type == Type.WEAPON_MINER){
         w.minerLaser(p.getBulletLocation(), model.getCurrentRoom());
      }
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
     
     // Create input field for entering the player's name
    if (!inputFieldCreated) {
      cp5 = new ControlP5(mvc);
      playerNameInput = cp5.addTextfield("Please input your name")
         .setPosition(width / 2 - 100, height / 2-80)
         .setSize(200, 40)
         .setAutoClear(false)
         .setColorBackground(color(255, 255, 255)) // Set background color to white
         .setColorForeground(color(240, 240, 240)) // Set foreground color to light gray
         .setColorActive(color(200, 200, 200)) // Set active color to gray
         .setColorValue(color(0, 0, 0)) // Set text color to black
         //.setTextAlign(LEFT) // Align text to the left side of the input field
         .setFont(createFont("Arial", 24)) // Set the font to Arial and make it larger (24pt)
         .setVisible(false); // Initially hide the input field
      inputFieldCreated = true;
    }
    
    playerNameInput.setVisible(true); // Show the input field when game over
      
   //// Restart
   //   rect(width/2, height*3/4, 200, 60);
   //   fill(255);
   //   textSize(16);
   //   text("Restart?", width/2, height*3/4);
     

   
   // Check Global Ranking
   
   // Quit
     // Detect click on the "Restart" button
   
   // RESTART
   if (mousePressed && mouseX > 460 && mouseX < 727 && mouseY > 439 && mouseY < 477) {
      // Save the player's name and score to the ranking string
      String playerName = playerNameInput.getText();
      playerNameInput.clear();
      String updatedRankingData = playerName + ":" + "100" + ";";
      //playerName += updatedRankingData;
      setRankingData(updatedRankingData);
      
      controller.setGameOver(false);
      controller.setGameStart(true);
      playerNameInput.setVisible(false); // Hide the input field after restarting
    }
    
    // HOME PAGE
   if (mousePressed && mouseX > 460 && mouseX < 727 && mouseY > 543 && mouseY < 581) {
     // Save the player's name and score to the ranking string
      String playerName = playerNameInput.getText();
      playerNameInput.clear();
      String updatedRankingData = playerName + ":" + "100" + ";";
      //playerName += updatedRankingData;
      setRankingData(updatedRankingData);
      
      controller.setGameOver(false);
      controller.setMenuHomePage(true);
      playerNameInput.setVisible(false); // Hide the input field after restarting
    }
     
    /* 
  if (mousePressed && dist(mouseX, mouseY, width / 2, height * 3 / 4) < 100) {
    // Save the player's name and score to the ranking string
    String playerName = playerNameInput.getText();
    playerNameInput.clear();
    String updatedRankingData = playerName + ":" + "100" + ";";
    //playerName += updatedRankingData;
    setRankingData(updatedRankingData);

    // Restart the game or go to the homepage
    // ...
    controller.setGameOver(false);
    controller.setMenuHomePage(true);
    playerNameInput.setVisible(false); // Hide the input field after restarting
  }
  */
   
   }
   
   // Afer game finished, the marking ranking
   // Also can be accessed from Home Page Menu

   public void drawGlobalList(){
    image(rankImg, 0, 0, width, height);
    
    //String rankingData = "Arlo:100;Cedric:100";
    String[] entries = playerName.split(";");
    
    textAlign(CENTER, CENTER);
    textSize(32); // Increase font size
    fill(255); // Text color
    
    float x = width / 2;
    float startY = height * 0.3f;
    float padding = 10; // Padding around the text

    // Find maximum text width
    float maxTextWidth = 0;
    for (String entry : entries) {
      String[] nameAndScore = entry.split(":");
      String name = nameAndScore[0];
      int score = Integer.parseInt(nameAndScore[1]);
      String text = String.format("%d. %s: %d", 1, name, score);
      float textWidth = textWidth(text);
      if (textWidth > maxTextWidth) {
        maxTextWidth = textWidth;
      }
    }
    
    // Draw rankings
    float currentY = startY;
    for (int i = 0; i < entries.length; i++) {
      String entry = entries[i];
      String[] nameAndScore = entry.split(":");
      String name = nameAndScore[0];
      int score = Integer.parseInt(nameAndScore[1]);
      String text = String.format("%d. %s: %d", i + 1, name, score);
    
      // Calculate text height and line height
      float textHeight = textAscent() + textDescent() + 2 * padding;
      float lineHeight = textHeight * 1.2f; // Add 20% extra space
    
    /*
      // Draw light grey background with half transparency
      fill(220, 220, 220, 127); // Light grey color with half transparency
      noStroke(); // Remove border around the background
      rect(x - (maxTextWidth + 2 * padding) / 2, currentY - textHeight / 2, maxTextWidth + 2 * padding, textHeight, 5);
    */
    
      // Draw text
      fill(255); // Text color
      text(text, x, currentY);
    
      // Update the Y position for the next entry
      currentY += lineHeight;
    }




  }

   
   public void drawInGameMenu(){
     image(inGameHome, 1100, 10, 53, 37);
     image(inGamePause, 1030, 10, 53, 37);
     image(inGameMute, 960, 10, 53, 37);
   }
   
   public void addTutorialToStartRoom(Room r){
       
       for(int i = 1; i < Type.BOARD_MAX_HEIGHT - 1; i++){
           for(int j = 1; j < Type.BOARD_MAX_WIDTH - 1; j++){
              if(r.blockType[i][j] == Type.BLOCK_CRYSTAL && r.blockType[i - 1][j] != Type.BLOCK_SPIKE){
                 fill(120, 255,255);
                 drawHelp(i,j, "crystal");
              }
              else if(r.blockType[i][j] == Type.BLOCK_SPIKE && r.blockType[i][j - 1] != Type.BLOCK_SPIKE){
                 fill(120, 0,255);
                 drawHelp(i,j, "spike");
              }
              else if(r.blockType[i][j] == Type.BLOCK_CRATE){
                 fill(60, 255,255);
                 drawHelp(i,j, "crate");
              }
              else if(r.blockType[i][j] == Type.BLOCK_PORTAL){
                  fill(190, 255,255);
                  drawHelp(i,j, "portal");
              }else if(r.blockType[i][j] == Type.BLOCK_PLATFORM && r.blockType[i][j - 1] != Type.BLOCK_PLATFORM){
                  fill(120, 0,255);
                  drawHelp(i,j, "platfrom");
              }
              
          }
       }
        
    }
    
    
    public void drawHelp(int i, int j, String s){
      //stroke(3,255,255); 
      //strokeWeight(5); 
      //fill(200, 0,255);
      
      textSize(18); 
      textAlign(LEFT, TOP);
      
      text(s, j * Type.BOARD_GRIDSIZE, (i-1)* Type.BOARD_GRIDSIZE); 
      noStroke();
      noFill();
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
