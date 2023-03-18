/**
* @author imyuanxiao
* All blocks, such as wall, portal...
*/
class Block extends BasicProp{
  
    protected int[] pos;
    protected int[] portal;
    
    public Block(int size){
       this.portal = new int[2];
       this.pos = new int[2];
       this.w = size;
       this.h = size;
    }
    
    public int[] getPos(){
       return pos;
    }
    
    public void setPos(int i, int j){
       this.pos[0] = i;
       this.pos[1] = j;
    }
    
    public int[] getPortal(){
       return portal;
    }
    
    public void setPortal(int i, int j){
       this.portal[0] = i;
       this.portal[1] = j;
    }
    
}
