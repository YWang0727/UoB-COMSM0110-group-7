/**
* @author imyuanxiao
* Class for bullets. Each weapon should overload shot() method when generationg new bullet object
* Next stage: add damage here. Damage should be set when weapon is generated. Damage to enemies should be added with potion effects probably?
*/
public class Bullet extends ActionProp{
    
    //cause damage if alive
    //maybe two gifs, fly and die
    protected PVector target;
   
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
           fill(60,60,100);
           ellipse(this.location.x, this.location.y, this.w, this.h);
           noFill();
      } else{
           stroke(0, 0, 100);
           strokeWeight(5);
           line(this.location.x, this.location.y, this.location.x + this.getFullVelocityX() * 3, this.location.y +  this.getFullVelocityY() * 3);
           strokeWeight(0);
           noStroke();      
      }
    }
}
