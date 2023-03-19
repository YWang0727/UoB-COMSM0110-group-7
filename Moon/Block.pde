/**
* @author imyuanxiao
* All blocks, such as wall, portal...
*/
class Block extends BasicProp{
  
    protected int[] pos;
    protected int[] portal;
    
    boolean canRemove;
    
    public Block(int size){
       this.portal = new int[2];
       this.pos = new int[2];
       this.w = size;
       this.h = size;
    }
    
    //crystal
    public Block(int type, int[] pos, int value, int maxHp){
       this.type = type;
       this.pos = pos;
       this.w = Type.BOARD_GRIDSIZE;
       this.h = Type.BOARD_GRIDSIZE;
       this.value = value;
       this.maxHp = maxHp;
       this.hp = maxHp;
    }
    
    
    //public int[] getPos(){
    //   return pos;
    //}
    
    public void setPos(int i, int j){
       this.pos[0] = i;
       this.pos[1] = j;
    }
    
    //public int[] getPortal(){
    //   return portal;
    //}
    
    public void setPortal(int i, int j){
       this.portal[0] = i;
       this.portal[1] = j;
    }
    
    void update() {
      mining.play(2);
      hp--;
      if (hp <= 0) {
        canRemove = true;
        println("canRemove");
        hp = 0;
      }
    }
    
    public void drawHp(){
        if(maxHp > 0){
            noStroke();
            fill(0,255,0);
            rect(pos[1] * this.w, pos[0] * this.h + h + 1, (float)hp/ (float) maxHp * w, 2);    
            noFill();
            stroke(255);
            strokeWeight(1);
            rect(pos[1] * this.w, pos[0] * this.h + h, this.w, 4);    
        }

    }
    
}
