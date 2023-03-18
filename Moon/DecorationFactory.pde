/**
* @author participants, imyuanxiao
* Factory for enemy generation.
* If gifs are needed, you need to build another function similar to addplayerGifs() in Moon_MVC.pde
* If no gifs, only PImage, you can add imgs in this class, just like ItemFactory.class
*/


public class DecorationFactory extends Factory{    
    
    protected ArrayList<PImage[]> decorationGifs;
    
   protected int[] jumpBlock = new int[2];
   protected int[] portalBlock = new int[2];

    public DecorationFactory(){
       decorationGifs = new ArrayList();
    }
    
   public void addDecorationGifs(PImage[]... gifs){
      for(PImage[] gif : gifs){
          for(PImage img : gif){
              img.resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
           }
          decorationGifs.add(gif);      
      }
   }

    public void addDecorationToRoom(Room r){
       for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
         for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
            if(legalPosition(r, new int[]{i,j})){
                    Decoration d = newDecoration(new int[]{j,i});
                    r.decorations.add(d);
              }
            }
         }
    }
    
    //check position according target position and enemy's size
    //pos[0] = i, pos[1] = j
    public boolean legalPosition(Room r, int[] pos){
      if(pos[0] <=3 || pos[0] >= Type.BOARD_MAX_HEIGHT - 3 || pos[1] <=3 || pos[1] >= Type.BOARD_MAX_WIDTH - 3){
        return false;
      }
      for(int i = pos[0] - 1; i <= pos[0] + 1; i++){
            for(int j = pos[1] - 1; j <= pos[1] + 1; j++){
               if(r.blockType[i][j] != Type.BLOCK_EMPTY){
                 return false;
               }
            }
      }
      return true;
    }
    
    public Decoration newDecoration(int[] pos){
       Decoration d = new Decoration(pos);
       d.imgs = this.decorationGifs.get(Type.GIF_TORCH);//2  - torch
       return d;
    }
    
    //  public Decoration(int[] pos, boolean once, int cd){
    public void addPortalGif(Room r, int[] pos){
           pos[1] -= 1;
           Decoration d = new Decoration(pos, true, 750, Type.GIF_PLAY_SPEED * 3, true);
           d.imgs = this.decorationGifs.get(Type.GIF_PORTAL);//torch
           r.decorations.add(d);
    }
    
    public void addJumpGif(Room r){
           Decoration d = new Decoration(new int[]{jumpBlock[0], jumpBlock[1] - 1}, true, 750, Type.GIF_PLAY_SPEED * 3, true);
           d.imgs = this.decorationGifs.get(Type.GIF_BOUNCE);//torch
           r.decorations.add(d);
    }
    
    public void addBulletRemoveGif(Room r){
           Decoration d = new Decoration(new int[]{jumpBlock[0], jumpBlock[1] - 1}, true, 750, Type.GIF_PLAY_SPEED * 3, true);
           d.imgs = this.decorationGifs.get(Type.GIF_BULLET_REMOVE);//torch
           r.decorations.add(d);
    }
    
}
