/**
* @author participants, imyuanxiao
* Class for Gunner, who can shot toward player
* When bullets touch player, player hp decrease, this can be realized by adding a new ArrayList in Room.class and another collision detection in Controller.class
*/
public class Gunner extends Enemy{

    public Gunner(int hp){
      this.type = Type.ENEMY_GUNNER;
      this.velocity = new PVector(Type.ENEMY_SPEED_X_NORMAL, 0);
      this.w = (int)(Type.BOARD_GRIDSIZE - 5);
      this.h = (int)(Type.BOARD_GRIDSIZE + 10);
      this.hp = hp;
      this.maxHp = hp;
      this.dp = 10;
      this.value = 100;
    }
    
    
}
