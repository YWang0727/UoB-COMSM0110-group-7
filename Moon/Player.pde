/**
* @author imyuanxiao, participants
* Class for player
* 'useItem()' - change status of player, should be updated
*/
public class Player extends ActionProp{
  
  protected int blinkCount; 
  
  protected int bWidthInc, bHeightInc, bSpeed, bDp, bNum;
    
  protected ArrayList<Item> items;
  protected Item[] weapons;
  protected int currentWeaponIndex;
  protected int currentItemIndex;
  protected boolean isShoot;
  
  protected Timer portalTimer;
  
  public Player(int w, int h){
    this.type = Type.PLAYER;    
    this.location = new PVector(width/2, height/2);
    this.w = w;
    this.h = h;
    this.hp = 100;
    this.bNum = 0;
    //Timer and blink effects
    this.invincibleTimer = new Timer();
    this.knockBackTimer = new Timer();
    this.blinkCount = 0;
    
    //weapons and items
    this.weapons = new Item[2];
    this.items = new ArrayList();

    this.transported = true;
    
    //img of heart
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
     println("change items: " + currentItemIndex);
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
          tint(255, 50);
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
  }
  
  
  public void drawWeapon(){
     Item w = weapons[currentWeaponIndex];
     int offset = this.left ? 1 : 0;
     image(w.imgs[1 - offset], this.location.x - w.w * offset + this.w/2, this.location.y + this.h/3);
  }
 
  
  
  public void drawHp(){
     translate(0, 0);
     for(int j = 0; j <= this.hp; j += Type.PLAYER_HEART){
         image(this.img, Type.BOARD_GRIDSIZE/2 + (j/10) * Type.BOARD_GRIDSIZE * 4/5, Type.BOARD_GRIDSIZE/2);
      }
  }
  
  public void drawPlayerAndWeapon(){

    pushMatrix();   
    drawGif();
    popMatrix(); 
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
       int offset = this.left ? 0 : 1;
       int gifType = Type.GIF_RUN_L + offset;
       PImage[] imgs = this.gifsImgs.get(gifType);
       image(imgs[(int)this.gifsImgsCount[gifType]], location.x,location.y);
       this.gifsImgsCount[gifType] = (this.gifsImgsCount[gifType] + Type.GIF_PLAY_SPEED) % (float)imgs.length;
  }
  
}
