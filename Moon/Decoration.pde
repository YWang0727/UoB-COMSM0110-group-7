public class Decoration{
   
  protected PImage[] imgs;
  protected float count;
  protected PVector location;
  protected boolean once, canRemove;
  protected Timer timer;
  protected int cd;
  protected float speed; 
  protected boolean beforePlayer;
  
  public Decoration(int[] pos){
      this.location = new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
      this.speed = Type.GIF_PLAY_SPEED;
  }
  
  public Decoration(int[] pos, boolean once, int cd, float speed, boolean before){
      this.location = new PVector(pos[0] * Type.BOARD_GRIDSIZE, pos[1] * Type.BOARD_GRIDSIZE);
      this.once = once;
      this.cd = cd;
      this.timer = new Timer();
      this.speed = speed;
      this.beforePlayer = before;
  }
  
  public Decoration(ActionProp o, int cd, PImage[] imgs){
      this.location = o.location.copy();
      this.once = true;
      this.cd = cd;
      this.timer = new Timer();
      this.imgs = imgs;
      this.speed = Type.GIF_PLAY_SPEED * 5;
      resizeGif(o);
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
      image(imgs[(int)count], location.x, location.y);
       this.count = (this.count + this.speed) % (float)imgs.length;
  }
  
  public void setImgs(PImage[] imgs){
       this.imgs = imgs;
       this.count = imgs.length;
  }
  
  public void resizeGif(ActionProp o){
     for(PImage img : imgs){
         img.resize(o.w * 2, o.h * 2);
     }
  }
  

}
