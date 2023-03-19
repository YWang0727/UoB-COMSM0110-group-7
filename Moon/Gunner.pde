/**
* @author participants, imyuanxiao
* Class for Gunner, who can shot toward player
* When bullets touch player, player hp decrease, this can be realized by adding a new ArrayList in Room.class and another collision detection in Controller.class
*/
public class Gunner extends Enemy{

    PVector targetLocation;
   
    private int lastShootTime = 0; 
   private int shootInterval = 3000;

  
    public Gunner(int hp){
      this.type = Type.ENEMY_GUNNER;
      this.velocity = new PVector(Type.ENEMY_SPEED_X_NORMAL, 0);
      this.w = (int)(Type.BOARD_GRIDSIZE + 10);
      this.h = (int)(Type.BOARD_GRIDSIZE + 10);
      this.hp = hp;
      this.maxHp = hp;
      this.dp = 10;
      this.value = 100;
    }
    
    
    //200 = attack range
    public void move(PVector playerLocation, Room r){
        float distance = PVector.dist(location, playerLocation);
        
        int currentTime = millis();
        if(distance <= 200  && currentTime - lastShootTime >= shootInterval){
          PVector velocity = PVector.sub(playerLocation, location);
          velocity.normalize().mult(5);
          shot(velocity, r);
          left = playerLocation.x < location.x;
          lastShootTime = currentTime; 
        }else{
           super.move();
        }
        
        if(this.velocity.x > 0){
           this.left = false;
        }
        if(this.velocity.x < 0){
           this.left = true;
        }
        float x = this.location.x;
        float y = this.location.y;
        if(x <= 0 || x + this.w >= width){
           this.velocity.x = - this.velocity.x;
           this.left = x <= 0 ? false : true;
        }
        if(y <= 0 || y + this.h >= height){
           this.velocity.y = - this.velocity.y;
        }
   }
   
   public void shot(PVector velocity, Room r){
       PVector newLocation = location.copy();
       newLocation.x += this.w/2;
       newLocation.y += this.h/2;
       Bullet b = new Bullet(newLocation, velocity.copy(), 10, 10, 10);
       r.enemyBullets.add(b);
   }
   
    
}
