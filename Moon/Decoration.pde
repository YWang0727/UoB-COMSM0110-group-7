public class Decoration{
   
  protected PImage[] imgs;
  protected float count;
  protected int[] pos;
  protected boolean once, canRemove;
  protected Timer timer;
  protected int cd;
  protected float speed; 
  protected boolean beforePlayer;
  
  public Decoration(int[] pos){
      this.pos = pos;
      this.speed = Type.GIF_PLAY_SPEED;
  }
  
  public Decoration(int[] pos, boolean once, int cd, float speed, boolean before){
      this.pos = pos;
      this.once = once;
      this.cd = cd;
      this.timer = new Timer();
      this.speed = speed;
      this.beforePlayer = before;
  }
  
  public void display(){
       if(once && !canRemove){
           timer.schedule(new TimerTask(){
              @Override
              public void run() {
                canRemove = true;
              }
           }, cd);
       }
      image(imgs[(int)count], pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
       this.count = (this.count + this.speed) % (float)imgs.length;
  }
  
  public void setImgs(PImage[] imgs){
       this.imgs = imgs;
       this.count = imgs.length;
  }
  

}
