/**
* @author imyuanxiao, Edsat
* Class for rooms, each room consists of 9 sections which are generated randomly.
*/
public class Room extends HandleEnemies{
    protected int type;
    protected int index;
    protected int[] adjacent;
    protected int[][] blockType;
    protected String[] sections;
    protected ArrayList<Block> blocks;
    protected ArrayList<Bullet> playerBullets;
    protected ArrayList<Bullet> enemyBullets;
    protected ArrayList<Item> items;

    public Room(){
        this.blockType = new int[Type.BOARD_MAX_HEIGHT][Type.BOARD_MAX_WIDTH];
        this.adjacent = new int[4];
         this.enemies = new ArrayList();
        this.playerBullets = new ArrayList();
        this.enemyBullets = new ArrayList();
        this.blocks = new ArrayList();
        this.items = new ArrayList();
        
        for(int i = 0; i < 4; i++){
            this.adjacent[i] = Type.NO_ROOM;
        }
        sections = new String[14];
        sections[0]="levels/section1.csv";
        sections[1]="levels/section2.csv";
        sections[2]="levels/section3.csv";
        sections[3]="levels/section4.csv";
        sections[4]="levels/section5.csv";
        sections[5]="levels/section6.csv";  
        sections[6]="levels/section7.csv";
        sections[7]="levels/section8.csv";
        sections[8]="levels/section9.csv";
        sections[9]="levels/section10.csv";
        sections[10]="levels/section11.csv";
        sections[11]="levels/section12.csv";
        sections[12]="levels/section13.csv";
        sections[13]="levels/section14.csv";
    }
    
    
    public String getSection(int i){
      return sections[i];
    }
    
    public void setAdjacent(int[] newIndex){
       for(int i = 0; i < 4; i++){
           if(newIndex[i] != Type.NO_ROOM){
              this.adjacent[i] = newIndex[i];
           }
       }
    }
    
    public int[] getAdjacent(){
       return this.adjacent;
    }
    
    public ArrayList<Block> getBlocks(){
       return this.blocks;
    }
    
    public void addBlock(Block block){
       this.blocks.add(block);
    }
    
    public int getBlockType(int i, int j){
       return blockType[i][j];
    }
    
    public void setBlockType(int i, int j, int type){
       this.blockType[i][j] = type;
    }
    

    public Block getBlockByPos(int i, int j){
       for(int k = 0; k < blocks.size(); k++){
         int[] pos = blocks.get(k).getPos();
         if( pos[0] == i && pos[1] == j){
            return blocks.get(k);
         }
       }
       return null;
    }


    
    public void addBullet(ArrayList<Bullet> bullets){
      for(Bullet b :bullets){
          this.playerBullets.add(b);
          //println(b.velocity);
      }
    }
    
    public void  display(){

        //draw enemies
        for(int i = 0; i < enemies.size(); i++){
            Enemy e = enemies.get(i);
            e.move();
            e.display();
        }
        
        //draw items
        for(int i = 0; i < items.size(); i++){
           items.get(i).display();
        }
        
        
        //for(int i = 0; i < playerBullets.size(); i++){
        //   Bullet b = playerBullets.get(i);
        //   b.move();
        //   b.paint();
        //}
        
        Iterator<Bullet> iterator = playerBullets.iterator();
        while(iterator.hasNext()) {
           Bullet b = iterator.next();
           b.move();
           b.paint();
           println("velocity" + b.id + ","+ b.velocity);
           println("location" + b.id + ","+ b.location);
        }
                
        for(int i = 0; i < enemyBullets.size(); i++){
           Bullet b = enemyBullets.get(i);
           b.move();
           b.paint();
        }
      
    }
    

}
