/**
* @author imyuanxiao
* Factory for block generation. This factory is reponsible for generating new Block object.
*/
public class BlockFactory extends Factory{
    
    public BlockFactory(){
       this.setImgs(new ArrayList());
       this.id = 0;
       this.init();
    }
    
    /**
    * Return a new Block object according to type passed in
    * test
    */
    public Block newBlock(int type){
       Block b = new Block(Type.BOARD_GRIDSIZE);
       b.type = type; 
       b.id = this.id;
       b.img = this.getImg(type);
       b.img.resize(Type.BOARD_GRIDSIZE,Type.BOARD_GRIDSIZE);
       this.increaseId();
       return b;
    }
    
    /**
    * Preload all imgs for all typee of blocks
    */
    private void init(){
       this.addImg(loadImage("imgs/empty.png"));
       this.addImg(loadImage("imgs/wall.png"));
       this.addImg(loadImage("imgs/crystal.png"));
       this.addImg(loadImage("imgs/bounce_up.png"));
       this.addImg(loadImage("imgs/portal.png"));
       this.addImg(loadImage("imgs/border.png"));
       this.addImg(loadImage("imgs/crate.png"));
       this.addImg(loadImage("imgs/spike.png"));
       this.addImg(loadImage("imgs/platform.png"));
       for(int i = 0; i < this.imgs.size(); i++){
          this.imgs.get(i).resize(Type.BOARD_GRIDSIZE, Type.BOARD_GRIDSIZE);
       }
    }
    
}
