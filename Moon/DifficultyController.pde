class Difficulty{

  protected int lastLevel;
  
  //initial props
  protected float bSpeed, bDp;
  protected int bNum;
  
  //changeable props, increase by score
  protected float eInitRatio, eIncRatio, bossIncRatio;
  protected float flyDp, gunnerDp, spiderDp;
  protected float flyHp, gunnerHp, spiderHp;
  
  protected float bossV, bossDp;
  
  protected float scoreRatio;
  
  protected boolean isSet;
  
  Difficulty(){
    this.isSet = false;
    this.flyHp = 10;
    this.gunnerHp = 30;
    this.spiderHp = 20;
    this.flyDp = 5;
    this.gunnerDp = 10;
    this.spiderDp = 8;
    this.bossV = 1;
    this.bossDp = 20;
    
    this.eInitRatio = 1.0;
    this.eIncRatio = 1.1;
    this.scoreRatio = 1.0;
    
    //test
    this.normalMode();
    
  }
  
  public void easyMode(){
    
     //player bullets status
     this.bSpeed = 3;
     this.bDp = 3;   
     this.bNum = 0;
     
     //enemy status
     this.eInitRatio = 0.6;
     this.eIncRatio = 1.1;
     this.scoreRatio = 0.6;
     this.bossIncRatio = 1.1;

     this.flyDp *= eInitRatio;
     this.gunnerDp *= eInitRatio;
     this.spiderDp *= eInitRatio;
     
     this.flyHp *= eInitRatio;
     this.gunnerHp *= eInitRatio;
     this.spiderHp *= eInitRatio;
     
     this.bossV *= eInitRatio;
     this.bossDp *= eInitRatio;
     
  }
  
  public void normalMode(){
    
     //player bullets status
     this.bSpeed = 1.5;
     this.bDp = 1.5;   
     this.bNum = 0;
     
     //enemy status
     this.eInitRatio = 1.0;
     this.eIncRatio = 1.1;
     this.scoreRatio = 1.0;
     this.bossIncRatio = 1.1;

     this.flyDp *= eInitRatio;
     this.gunnerDp *= eInitRatio;
     this.spiderDp *= eInitRatio;
     
     this.flyHp *= eInitRatio;
     this.gunnerHp *= eInitRatio;
     this.spiderHp *= eInitRatio;
     
     this.bossV *= 0.8;
     this.bossDp *= 0.8;
     
  }
  
  public void hardMode(){
    
     //player bullets status
     this.bSpeed = 0;
     this.bDp = 0;   
     this.bNum = 0;
     
     //enemy status
     this.eInitRatio = 1.3;
     this.eIncRatio = 1.2;
     this.scoreRatio = 1.0;
     this.bossIncRatio = 1.2;

     this.flyDp *= eInitRatio;
     this.gunnerDp *= eInitRatio;
     this.spiderDp *= eInitRatio;
     
     this.flyHp *= eInitRatio;
     this.gunnerHp *= eInitRatio;
     this.spiderHp *= eInitRatio;
     
     
     
  }
  
  public void increase(){
     
     this.flyDp *= eIncRatio;
     this.gunnerDp *= eIncRatio;
     this.spiderDp *= eIncRatio;
     
     this.flyHp *= eIncRatio;
     this.gunnerHp *= eIncRatio;
     this.spiderHp *= eIncRatio;
     
     this.bossV *= eIncRatio;
     this.bossDp *= eIncRatio;

  }
  
  public void increaseByTime(Player player){
    int score = player.value;
    int currentLevel = (score + 5000) / 5000; 

    if (currentLevel > lastLevel) {
      this.increase();
      lastLevel = currentLevel; 
    }
  }

}
