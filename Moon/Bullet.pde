/**
* @author imyuanxiao
* Class for bullets. Each weapon should overload shot() method when generationg new bullet object
* Next stage: add damage here. Damage should be set when weapon is generated. Damage to enemies should be added with potion effects probably?
*/
public class Bullet extends ActionProp{
    
    //cause damage if alive
    //maybe two gifs, fly and die
   
    Bullet(PVector location, PVector velocity, int w, int h, int dp){
       this.isAlive = true;
       this.w = w;
       this.h = h;
       this.dp = dp;
       this.location = location;
       this.velocity = velocity;
       this.type = Type.BULLET_TYPE_CIRCLE;
    }
        
    /**
    * Currently, bullet can only move left and right
    * we can change this method to let it move in all directions
    * by changing speedY
    */
    public void move(){
         this.location.add(this.velocity);
    }
     
    public void paint(){
      
      if(this.type == Type.BULLET_TYPE_CIRCLE){
           fill(255);
           ellipse(this.location.x, this.location.y, this.w, this.h);
           noFill();
      }
      else if(this.type == Type.BULLET_TYPE_MINER){
           
           fill(255);
           ellipse(this.location.x, this.location.y, 5, 25);
           noFill();
       
      }      
      else{
           stroke(255);
           strokeWeight(5);
           line(this.location.x, this.location.y, this.location.x + this.getFullVelocityX() * 3, this.location.y +  this.getFullVelocityY() * 3);
           noStroke();      
      }
    }
}
