/**
* @author participants, imyuanxiao
* Factory for enemy generation.
* If gifs are needed, you need to build another function similar to addplayerGifs() in Moon_MVC.pde
* If no gifs, only PImage, you can add imgs in this class, just like ItemFactory.class
*/
public class EnemyFactory extends Factory{    
    
    protected ArrayList<ArrayList<PImage[]>> enemyGifs;

    public EnemyFactory(){
       enemyGifs = new ArrayList(); //<>//
    }
    
   public void addEnemyGifs(ArrayList<PImage[]>... gifs){ //<>//
      for(ArrayList<PImage[]> gif : gifs){
          enemyGifs.add(gif);      
      }
   }

    public void addEnemiesToRoom(Room r){
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
         for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
            Enemy tmp = newEnemy(Type.ENEMY_GUNNER);
            boolean flag = legalPosition(r, tmp, new int[]{i,j});
            if(flag){
              int rd = (int)random(20);
              rd = 19;
              if(rd > 15){
                Enemy e = tmp;
                e.location.x = Type.BOARD_GRIDSIZE * j;
                e.location.y = Type.BOARD_GRIDSIZE * i;
                r.enemies.add(e);
              }
            }
         }
       }
    }
    
    //check position according target position and enemy's size
    //pos[0] = i, pos[1] = j
    public boolean legalPosition(Room r, BasicProp o, int[] pos){
      if(pos[0] <=3 || pos[0] >= Type.BOARD_MAX_HEIGHT - 3 || pos[1] <=3 || pos[1] >= Type.BOARD_MAX_WIDTH - 3){
        return false;
      }
      float s = Type.BOARD_GRIDSIZE;
      float x = pos[1] * s, y = pos[0] * s;
      float h = o.h, w = o.w;
      
      //left/right empty
      int left = (int)(x/s) - 1;
      int right = (int)((x + w)/s) + 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      for(int i = U; i <= D; i++){
          for(int j = left; j <= right; j++){
            if(cantThrough(r.getBlockType(i,j))){
               return false;
            }
          }
      }
      //up empty, down not empty
      int upper = (int)(y/s) - 1;
      int below = (int)((y + h)/s) + 1;
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      //all blocks above are !blockCannotThrough(), o can through
      for(int i = L; i <= R && upper >= 0; i++){
         if(cantThrough(r.getBlockType(upper,i))){
            return false;
         }
      }
      for(int i = L - 1; i <= R + 1 && below < Type.BOARD_MAX_HEIGHT; i++){
         if(!cantThrough(r.getBlockType(below,i))){
            return false;
         }
      }
      return true;
    }
    
    public boolean cantThrough(int type){
     if(type == Type.BLOCK_EMPTY || type == Type.BLOCK_CRATE || type == Type.BLOCK_SPIKE){
       return false;
     }
     return true;
   }
    
    
    public Enemy newEnemy(int type){
       //Enemy e; 
       //if(type == Type.ENEMY_GHOST){
       //    e = new Ghost(); //<>//
       //}else if(type == Type.ENEMY_WORM){
       //    e = new Worm();
       
       //}else if(type == Type.ENEMY_GUNNER){
       //    e = new Gunner();
       //}else{
       //    e = new Enemy();
       //} //<>//
       Enemy e = new Gunner(25);
       e.addGifsImgs(this.enemyGifs.get(e.type));
       e.fall = true;
       e.id = this.id;
       this.increaseId();
       return e;
    }
    
}
