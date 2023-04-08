/**
* @author imyuanxiao, participants
* Class for player
* 'useItem()' - change status of player, should be updated
*/
public class Player extends ActionProp{
  
  protected int blinkCount; 
  
  protected float bWidthInc, bHeightInc, bSpeed, bDp;
  protected int bNum;

  protected ArrayList<Item> items;
  protected Item[] weapons;
  protected int currentWeaponIndex;
  protected int currentItemIndex;
  protected boolean isShoot;
  
  protected PImage[] hpGif;
  protected float hpGifCount;
  
  protected Timer portalTimer;
  
  public Player(){
    this.type = Type.PLAYER;    
    this.location = new PVector(width/2, height/2);
    this.w = Type.BOARD_GRIDSIZE - 10;
    this.h = Type.BOARD_GRIDSIZE - 5;
    this.hp = 100;
    this.maxHp = hp;
    this.bSpeed = dif.bSpeed;
    this.bDp = dif.bDp;
    this.bNum = dif.bNum;
    
    //Timer and blink effects
    this.invincibleTimer = new Timer();
    this.knockBackTimer = new Timer();
    this.blinkCount = 0;
    
    //weapons and items
    this.weapons = new Item[2];
    this.items = new ArrayList();

    this.transported = true;
    //img of heart_zero
    this.img = loadImage("imgs/player/hp.png");
    this.img.resize(Type.BOARD_GRIDSIZE *2/3, Type.BOARD_GRIDSIZE *2/3);
  }
  
  //add weapon
  public void addItem(Item t){
     if(t.category == Type.ITEM_WEAPON){
        weapons[0] = t;
     /*
     }else if(t.getCategory() == Type.ITEM_CRYSTAL)(  //for crystal, not put into the store section, but add score or sth directly
        add score or crystal to player
     */
     }else{ 
        items.add(t);
     }  
  }
  
  public Item getCurrentItem(){
       if(items.size() == 0){
          return null;
       }
       return items.get(currentItemIndex);
  }
  
  
  public void changeItem(){
     if(items.size() == 0){
        
        println("no items");
        
        
        return;
     }
     this.currentItemIndex = (this.currentItemIndex + 1) % items.size();
     //println("change items: " + currentItemIndex);
     this.items.get(currentItemIndex).showMe = true;
     
  }
  
  public void showCurrentItem(){
     if(this.items.size() <= 0) return;
     this.items.get(currentItemIndex).showMe(this.location);
     
     //for(Item t : items){
     //  if(t.showMe && t.id == this.currentItemIndex){
     //     t.showMe(this.location);
     //  }
     //}
  }
  
  public void removeCurrentItem(){
     this.items.remove(currentItemIndex--);
     if(currentItemIndex<0) currentItemIndex = 0;
  }
  
  public void switchWeapon(){
     this.currentWeaponIndex = (this.currentWeaponIndex + 1) % 2;
  }
  

  public void move(){
     this.location.x += this.velocity.x + this.velocity2.x + velocity3.x;
     if(this.fly){
         this.location.y +=  this.velocity.y + this.velocity2.y + velocity3.y;
     }else{
         if(this.jump){
            this.location.y +=  this.velocity.y + this.velocity2.y + velocity3.y;
            if(this.velocity.y < Type.PLAYER_SPEED_Y) this.velocity.y += Type.PLAYER_SPEED_INCREMENT;
         }
         if(this.velocity.y == 0){
           this.fallDist = 0;
         }
         float tmp = this.velocity.y + this.velocity2.y + velocity3.y;
         if(tmp > 0){
            this.fallDist += tmp;
         }
     }
     
     if(this.isKnockBack){
       knockBackTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            isKnockBack = false;
             velocity3 = new PVector();
          }
       }, 100);
     }
     
     
  }
  
  //if Thorn Potion, e.attacked();
  public void attacked(float dp, ActionProp e){
    if(!isInvincible){
      
       if(e!= null && !e.isAlive){
          return;
       }
       
       //knockback
       if(e != null){
           this.isKnockBack = true;
           PVector direction = PVector.sub(this.location, e.location);
           direction.normalize();
           PVector knockback = direction.mult(10);
           this.velocity3 = knockback;
           playerHurt.play(2);
       }
       
       
       super.attacked(dp);
       println(dp);
        
       //twinkle
       isInvincible = true;
       invincibleTimer.schedule(new TimerTask(){
          @Override
          public void run() {
            isInvincible = false;
          }
       }, 1000);
    }
  }
  
  public void display(){
    if (isInvincible) {
      if (blinkCount < 2) {
        if (frameCount % 6 == 0) {
          tint(255, 240);
          drawPlayerAndWeapon();
          noTint();
          blinkCount++;
        }
      } else {
        drawPlayerAndWeapon();

        blinkCount = 0;
      }
    } else {
          drawPlayerAndWeapon();

    }
    drawHp();
    drawScore();
    showCurrentItem();
  }
  
  
  //public void drawWeapon(){
  //   Item w = weapons[currentWeaponIndex];
  //   int offset = this.left ? 1 : 0;
  //   image(w.imgs[1 - offset], this.location.x - w.w * offset + this.w/2, this.location.y + this.h/3);
  //}
 
  
  
  public void drawHp(){
      translate(0, 0);
      
      for(int j = 0; j <= this.maxHp; j += Type.PLAYER_HEART){
         image(this.img, Type.BOARD_GRIDSIZE/2 + (j/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
      }
     
     for(int j = 0; j <= this.hp; j += Type.PLAYER_HEART){
         image(hpGif[(int)hpGifCount], Type.BOARD_GRIDSIZE/2 + (j/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
         this.hpGifCount = (hpGifCount + 0.01) % (float)hpGif.length;
      }
      
  }
  
   public void drawScore(){
      translate(0, 0);
      noTint();
      stroke(0); 
      strokeWeight(1); 
      fill(255);
      textSize(32); 
      textAlign(LEFT, TOP);
      text("Score: " + this.value, Type.BOARD_GRIDSIZE/2, Type.BOARD_GRIDSIZE *3/2); 
  }
  
  public void drawPlayerAndWeapon(){
    drawGif();
    Item w = weapons[currentWeaponIndex];
     w.display(this);

  }
  
  public float getAngle() {
    float dx = mouseX - (location.x + w/2);
    float dy = mouseY - (location.y + h/2);
    return atan2(dy, dx);
  }
  
  public PVector getBulletLocation() {
    float r = 10 + this.weapons[currentWeaponIndex].w;
    PVector pivot = new PVector(location.x + w /2, location.y + h * 1/4);
    float x = pivot.x + r * cos(getAngle());
    float y = pivot.y + r * sin(getAngle());
    return new PVector(x, y);
  }
  
  public void drawGif(){
       int gifType;
       //println(jump + ","+ fall + "," + getFullVelocityY());
       //if(getFullVelocityY() != 0 && getFullVelocityX() != 0){
       //   gifType = 2;
       //}else 
       if(this.jump && this.fall && abs(getFullVelocityY()) > 1){
          gifType = 2;
       }
       
       else if(getFullVelocityX() == 0){
           gifType = 0;
       }else{
           gifType = 1;
       }
       drawGif(gifType);
  }
  
  

  
  
}
