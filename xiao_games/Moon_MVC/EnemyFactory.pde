/**
* @author participants, imyuanxiao
* Factory for enemy generation.
* If gifs are needed, you need to build another function similar to addplayerGifs() in Moon_MVC.pde
* If no gifs, only PImage, you can add imgs in this class, just like ItemFactory.class
*/
public class EnemyFactory extends Factory{    
    
    public EnemyFactory(){
       this.setImgs(new ArrayList());
       this.setId(0);
       //this.init(); //<>// //<>// //<>//
    }
    
    //private void init(){
    //   this.addImg(loadImage("imgs/enemy/ghost.png")); //<>// //<>// //<>//
    //   this.addImg(loadImage("imgs/enemy/worm.png"));
    //   this.addImg(loadImage("imgs/enemy/gunner.png"));
    //}
    
    //scan a room, add enemy spawn or enemies to this room
    //enemy can'be generated on blocks without two blocks next to it
    public void addEnemiesToRoom(Room r){
       for(int i = 0; i < 19; i++){
         for(int j = 0; j < 29; j++){
            if(r.getBlockType(i , j) == Type.BLOCK_EMPTY){
              if((int)random(70) == 1){
                Enemy e = newEnemy(Type.ENEMY_WORM);
                e.setX(Type.BOARD_GRIDSIZE * j);
                e.setY(Type.BOARD_GRIDSIZE * i);
                r.addEnemy(e);
              }
            }
         }
       }
    
    }
    
    
    public Enemy newEnemy(int type){
       Enemy e; 
       if(type == Type.ENEMY_GHOST){
           e = new Ghost((int)(Type.BOARD_GRIDSIZE * 1.5), (int)(Type.BOARD_GRIDSIZE * 1.5)); //<>// //<>// //<>//
       }else if(type == Type.ENEMY_WORM){
           e = new Worm((int)(Type.BOARD_GRIDSIZE), (int)(Type.BOARD_GRIDSIZE));
           e.setHp(20);
           e.setDp(10);
           e.setX(width * 3/4);
           e.setY(height/2);
       }else if(type == Type.ENEMY_GUNNER){
           e = new Gunner((int)(Type.BOARD_GRIDSIZE), (int)(Type.BOARD_GRIDSIZE * 1.5));
           e.setX(width * 2/3);
           e.setY(height/2);
       }else{
           e = new Enemy();
       }  //<>// //<>// //<>//
       e.setFall(true);
       e.setId(this.getId());
       //e.setImg(this.getImgs().get(type));
       //e.getImg().resize(e.getWidth(), e.getHeight());
       this.increaseId();
       return e;
    }
    
    
    
    
}
