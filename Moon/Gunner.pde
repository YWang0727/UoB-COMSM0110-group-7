/**
* @author participants, imyuanxiao
* Class for Gunner, who can shot toward player
* When bullets touch player, player hp decrease, this can be realized by adding a new ArrayList in Room.class and another collision detection in Controller.class
*/
public class Gunner extends Enemy{

    public Gunner(){
      this.setType(Type.ENEMY_GUNNER);
      this.setSpeedX(Type.ENEMY_SPEED_X_NORMAL);
      this.setFall(true);
      this.setWidth((int)(Type.BOARD_GRIDSIZE_SUB5));
      this.setHeight((int)(Type.BOARD_GRIDSIZE_SUB5 * 2));
      this.setHp(20);
      this.setDp(10);
    }
    
    public void loadImags(){
    
     PImage[] gunnerRunL = Gif.getPImages(this, "imgs/enemy/gunner_left.gif");
     PImage[] gunnerRunR = Gif.getPImages(this, "imgs/enemy/gunner_right.gif");
     //Death
     //Know-back 
     this.addGifsImgs(gunnerRunL,gunnerRunR);
    
    }
    
}
