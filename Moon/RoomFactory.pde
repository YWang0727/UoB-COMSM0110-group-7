import java.util.*;

/**
* @author Edsat, imyuanxiao
* Factry for room generation. When player enter a new room, this class will generate a new room with different structure.
*/
public class RoomFactory extends Factory{    
    
    //protected EnemyFactory enemyFactory;
    protected BlockFactory blockFactory;
    protected final int sectionSize=9;
    protected String[] level;
    protected List<Integer> sectionIndex = new ArrayList<>(14);
    protected boolean portal;
    protected int[] portalCoordinates = new int[4];
   
    public RoomFactory(BlockFactory b){
      //this.enemyFactory = e;
      this.blockFactory = b;
      for(int i=0; i<14; i++){
        sectionIndex.add(i);
      }
    }
    
    public int getSectionIndex(int i){
      return sectionIndex.get(i);
    }
    
    public Room newRoom(int type){
        Room r;
        if(type == Type.ROOM_START){
           r =  generateStart(this.id);
        }else if(type == Type.ROOM_UP){
           r =  generateUp(this.id);
        }else if(type == Type.ROOM_DOWN){
           r =  generateDown(this.id);
        }else{
           r =  generateLR(this.id);
        }
        r.tint = random(360);
        this.increaseId();
        return r;
        
    }
    
    protected Room generateStart(int id){
        int i = (int)random(5);//0~4
        Room r;
        if(i == 0){
           r = roomType0();
        }else if(i == 1){
           r = roomType1();
        }else if(i == 2){
           r = roomType2();
        }else if(i == 3){
           r = roomType3();
        }else{
           r = roomType4();
        }
        r.index = id;
        return r;
    }
    
    protected Room generateUp(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType3();
        }else{
           r = roomType4();
        }
        r.index = id;
        return r;
    }
    
   protected Room generateDown(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r =  roomType0();
        }else if(i >= 3 && i < 6){
           r = roomType1();
        }else if(i >=6 && i < 9){
           r = roomType4();
        }else{
           r = roomType5();
        }
        r.index = id;
        return r;
    }
    
    protected Room generateLR(int id){
        int i = (int)random(10);//0~9
        Room r;
        if(i >= 0 && i < 3){
           r = roomType1();
        }else if(i >= 3 && i < 6){
           r = roomType2();
        }else{
           r = roomType4();
        }
        r.index = id;
        return r;
    }
    
    protected void generateLevel(Room r){
      this.level = new String[6];
      Collections.shuffle(sectionIndex);
      for(int i=0; i<6; i++){
        int section = getSectionIndex(i);
        level[i]=r.sections[section];
      }
    }
    
    protected void addSection(String filename, Room r, int rowNum, int colNum)
    {
      setPortal(false);
      String[] lines = loadStrings(filename);
      for(int row=0; row<sectionSize; row++){
        String[] values=split(lines[row],",");
        for(int col=0; col<sectionSize; col++){
          switch(values[col].codePointAt(0)){
            case '1':
              if(blockOrCrystal()){
                r.blockType[rowNum+row][colNum+col] = Type.BLOCK_CRYSTAL;
            }else if(!blockOrCrystal()){
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_WALL;
            }
              break;
            case '2':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_BOUNCE;
              break;
            case '3':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PLATFORM;
              break;
            case '4':
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_SPIKE;
              break;
            case 'p':
              setPortal(true);
              setPortalCoordinates(rowNum+row,colNum+col,'p');
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PORTAL;
              break;
            case 'q':
              setPortalCoordinates(rowNum+row,colNum+col,'q');
              r.blockType[rowNum+row][colNum+col] = Type.BLOCK_PORTAL;
              break;
          }
        }
      }
      makePortal(r);
    }
    
    
    public boolean blockOrCrystal(){
      int i = (int)random(20);
      if(i<1){
        return true;
      }
      return false;
    }
    
    
    public void setPortal(boolean p){
      portal = p;
    }
    
    
    public void setPortalCoordinates(int row, int col, char portal){
      switch(portal){
        case 'p':
          portalCoordinates[0]=row;
          portalCoordinates[1]=col;
          break;
        case 'q':
          portalCoordinates[2]=row;
          portalCoordinates[3]=col;
          break;
      }
    }
    
    
    public void makePortal(Room r){
      if(!portal){
        return;
      }
      Block b1 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b1.setPos(portalCoordinates[0], portalCoordinates[1]);
      b1.setPortal(portalCoordinates[2], portalCoordinates[3]);
      r.blocks.add(b1);
      Block b2 = blockFactory.newBlock(Type.BLOCK_PORTAL);
      b2.setPos(portalCoordinates[2], portalCoordinates[3]);
      b2.setPortal(portalCoordinates[0], portalCoordinates[1]);
      r.blocks.add(b2);
    }
    
    //adds crates to room - probability can be adjusted
    protected void addCrates(Room r)
    {
      for(int i=0; i<20; i++){
          for(int j=0; j<29; j++){
            int c = (int)random(30);
            if(!borderCheck(i,j) && r.blockType[i][j] == Type.BLOCK_EMPTY){
              if(r.blockType[i+1][j] == Type.BLOCK_WALL && c<1 && !lineCheck(r, i)){
                r.blockType[i][j] = Type.BLOCK_CRATE; 
              }
            }
          }
      }
    }
    
    
    protected boolean lineCheck(Room r, int rowNum){
      for(int j=0; j<Type.BOARD_MAX_WIDTH; j++){
        if(r.blockType[rowNum][j] == Type.BLOCK_CRATE){
          return true;
        }
      }
      return false;
    }
    
    
    protected void addBorders(Room r)
    {
      for(int i=0; i<20; i++){
          for(int j=0; j<29; j++){
            if(borderCheck(i,j)){
              r.blockType[i][j] = Type.BLOCK_BORDER;
            }
          }
          r.blockType[6][0] = Type.BLOCK_EMPTY;
          r.blockType[7][0] = Type.BLOCK_EMPTY;
          r.blockType[8][0] = Type.BLOCK_EMPTY;
          r.blockType[6][28] = Type.BLOCK_EMPTY;
          r.blockType[7][28] = Type.BLOCK_EMPTY;
          r.blockType[8][28] = Type.BLOCK_EMPTY;
          r.blockType[15][0] = Type.BLOCK_EMPTY;
          r.blockType[16][0] = Type.BLOCK_EMPTY;
          r.blockType[17][0] = Type.BLOCK_EMPTY;
          r.blockType[15][28] = Type.BLOCK_EMPTY;
          r.blockType[16][28] = Type.BLOCK_EMPTY;
          r.blockType[17][28] = Type.BLOCK_EMPTY;
          r.blockType[0][15] = Type.BLOCK_EMPTY;
          r.blockType[0][16] = Type.BLOCK_EMPTY;
          r.blockType[19][15] = Type.BLOCK_EMPTY;
          r.blockType[19][16] = Type.BLOCK_EMPTY;
        }
    }
    
    
    protected boolean borderCheck(int r, int c){
      if(r==0 || c==0){
        return true;
      }
      if(r==19 || c==28){
        return true;
      }
      return false;
    }
    
    
    protected void fillLevel(Room r){
      generateLevel(r);
      addSection(level[0],r,1,1);
      addSection(level[1],r,1,10);
      addSection(level[2],r,1,19);
      addSection(level[3],r,10,1);
      addSection(level[4],r,10,10);
      addSection(level[5],r,10,19);
      addCrates(r);
    }
    
    
    //0 - Only up and down exits
    protected Room roomType0(){
        Room r = new Room();
        r.type = 0;
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[6][28] = Type.BLOCK_BORDER;
        r.blockType[7][28] = Type.BLOCK_BORDER;
        r.blockType[8][28] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[15][28] = Type.BLOCK_BORDER;
        r.blockType[16][28] = Type.BLOCK_BORDER;
        r.blockType[17][28] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }
    
    // 1 - all exits
    protected Room roomType1(){
        Room r = new Room();
        r.type = 1;
        addBorders(r);
        fillLevel(r);
        return r;
    }
   
    // 2 - only left and right exits
    protected Room roomType2(){
        Room r = new Room();
        r.type = 2;
        addBorders(r);
        r.blockType[0][15] = Type.BLOCK_BORDER;
        r.blockType[0][16] = Type.BLOCK_BORDER;
        r.blockType[19][15] = Type.BLOCK_BORDER;
        r.blockType[19][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

    // 3 - only bottom exits
    protected Room roomType3(){
        Room r = new Room();
        r.type = 3;
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[6][28] = Type.BLOCK_BORDER;
        r.blockType[7][28] = Type.BLOCK_BORDER;
        r.blockType[8][28] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[15][28] = Type.BLOCK_BORDER;
        r.blockType[16][28] = Type.BLOCK_BORDER;
        r.blockType[17][28] = Type.BLOCK_BORDER;
        r.blockType[0][15] = Type.BLOCK_BORDER;
        r.blockType[0][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

    // 4 - all exits
    protected Room roomType4(){
        Room r = new Room();
        r.type = 4;
        addBorders(r);
        fillLevel(r);
        return r;
    }
    
    // 5 - only top and right exit
    protected Room roomType5(){
        Room r = new Room();
        r.type = 5;
        addBorders(r);
        r.blockType[6][0] = Type.BLOCK_BORDER;
        r.blockType[7][0] = Type.BLOCK_BORDER;
        r.blockType[8][0] = Type.BLOCK_BORDER;
        r.blockType[15][0] = Type.BLOCK_BORDER;
        r.blockType[16][0] = Type.BLOCK_BORDER;
        r.blockType[17][0] = Type.BLOCK_BORDER;
        r.blockType[19][15] = Type.BLOCK_BORDER;
        r.blockType[19][16] = Type.BLOCK_BORDER;
        fillLevel(r);
        return r;
    }

}
