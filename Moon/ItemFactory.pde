/**
* @author YWang0727, imyuanxiao
* Factory for item generation (randomly)
* For weapons, method 'shot()' (and other functions if needed) in this class should be overrided by creating an anonymous inner class in construcotr.
* How bullet moves should be reconsidered. Currently, bullets will move faster if shot upward.
* 
* For consumables such as potions, method 'useItem()' in Player.class should be refactored to change status of player temporarily
* For outfit, whick can permanently change status of player, method 'useItem()' or new method in Player.class should be set
* For coins, which should directly add score instead of being added to any class
*/
public class ItemFactory extends Factory{
    
    protected ArrayList<PImage> weaponImgs;
    protected ArrayList<PImage> potionImgs;
    //protected ArrayList<PImage> outfitImgs;

    public ItemFactory(){
       this.id = 0;
       this.weaponImgs = new ArrayList();
       this.potionImgs = new ArrayList();
       //this.coinImgs = new ArrayList();
       this.init(); 
    }
    
    /**
    * add all imgs of items
    */
    protected void init(){
       // imgs of weapons
       weaponImgs.add(loadImage("imgs/items/weapon/0_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/0_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/0_3.png")); 

       weaponImgs.add(loadImage("imgs/items/weapon/1_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/1_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/1_3.png")); 

   
       weaponImgs.add(loadImage("imgs/items/weapon/2_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/2_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/2_3.png")); 

       
       weaponImgs.add(loadImage("imgs/items/weapon/3_1.png")); 
       weaponImgs.add(loadImage("imgs/items/weapon/3_2.png")); 
       //weaponImgs.add(loadImage("imgs/items/weapon/3_3.png")); 

       // imgs of consumables
       potionImgs.add(loadImage("imgs/items/potion/0.png"));
       potionImgs.add(loadImage("imgs/items/potion/1.png"));
       

    }
    
    
    //all effects of items can be written here
    public void useItemByPlayer(Player p){
        Item t = p.getCurrentItem();
         if(t == null){
            println("no items");
            return;
         }
         
         if(t.category == Type.ITEM_POTION){
            if(t.type == Type.POTION_HP){
                p.hp += Type.POTION_HP_EFFECT;
                println("use potion, id: " + t.id + ", playerHp: " + p.hp);
            }else{
                //speed increment to be added...
                println("use potion, id: " + t.id);
            }
         }
         p.removeCurrentItem();
    }
    
    public Item newItem(int[] pos){
       int r = (int)random(10);
       Item t = null; 
       if(r >= 0 && r <= 3){   
           t = newWeapon();
       }else if(r > 3 && r <= 6){  
            //randomly generate a new potion
           t = newPotion();
       }else{
           t = newCrystal();
       }
       //
       //else if(category == Type.ITEM_PERMANENT){
       //    item = newOutfit();
       //}
       
       if(t != null){
         //t.pos = pos;
         t.location = new PVector(pos[1] * Type.BOARD_GRIDSIZE, pos[0] * Type.BOARD_GRIDSIZE);
         println(t.location);
         t.id = this.id;
         this.increaseId();
       }
       return t;
    }
    
    //new-hand weapon
    public Item weaponPistol(){
       //overload shot method
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 5, 1, 500, Type.BULLET_TYPE_CIRCLE);
       //set category and type
       t.category = Type.ITEM_WEAPON;
       t.type = Type.WEAPON_PISTOL;
       
       //remember to set width and height
       t.w = Type.BOARD_GRIDSIZE/2;
       t.h = Type.BOARD_GRIDSIZE/2;
       //set PImage and resize them
       t.setImgs(weaponImgs.get(t.type * 2),weaponImgs.get(t.type * 2 + 1));

       //setId
       t.id = this.id;
       this.increaseId();
       
       return t;
    }
    
    //new-hand weapon
    public Item weaponMinergun(){  //Player comes with own miner gun initially
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 10, 1, 250, Type.BULLET_TYPE_MINER);
       t.category = Type.ITEM_WEAPON;
       t.type = Type.WEAPON_MINER;

       //Type must be set
       //get PImage and resize them
       t.w = Type.BOARD_GRIDSIZE * 2/3;
       t.h = Type.BOARD_GRIDSIZE/2;
       t.setImgs(weaponImgs.get(t.type * 2),weaponImgs.get(t.type * 2 + 1));
       t.id = this.id;
       this.increaseId();
       return t;
    }
    
    //randomly generate a new weapon
    public Item newWeapon( ){
       //randomly generate a weapon
       int r = (int)random(10);
       
       Item t = null;
       if(r >=0 && r <= 5){     
          t =  weaponShotgun();
       }else{
          t =  weaponLaser();
       } 
       //each wapon may have different size, so this part of code can be moved to their generation function
       
       //set category
       t.category = Type.ITEM_WEAPON;
       return t;
    }
    

    public Item weaponShotgun(){
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 5, 3, 750, Type.BULLET_TYPE_CIRCLE);
       t.type = Type.WEAPON_SHOTGUN;
       t.w = Type.BOARD_GRIDSIZE;
       t.h = Type.BOARD_GRIDSIZE/3;
       t.setImgs(weaponImgs.get(t.type * 2),weaponImgs.get(t.type * 2 + 1));

       return t;
    }
    
    public Item weaponLaser(){
       //basic props of bullets: int bW, int bH, int bSpeed, int bDp, int bNum, int bCd, int bType
       Item t = new Item(5, 5, Type.BULLET_SPEED_SLOW, 10, 1, 300, Type.BULLET_TYPE_LINE);
       t.type = Type.WEAPON_LASER;

       t.w = Type.BOARD_GRIDSIZE;
       t.h = Type.BOARD_GRIDSIZE/3;

       //get PImage and resize them
       t.setImgs(weaponImgs.get(t.type * 2),weaponImgs.get(t.type * 2 + 1));


       return t;
    }
    
    public Item newPotion(){
       //randomly generate a potion
       int r = (int)random(10);
       Item t = null;
       if(r >=0 && r <= 5){
          t =  potionHp();
       }else{
          t =  potionSp();
       } 
       
       //set category
       t.category = Type.ITEM_POTION;
       return t; 
    }
    
    public Item potionHp(){
        Item t = new Item();
        t.type = Type.POTION_HP;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE;
        t.setImgs(potionImgs.get(t.type));

        return t;
    }
    
    public Item potionSp(){
        Item t = new Item();
        t.type = Type.POTION_SP;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE;
        t.setImgs(potionImgs.get(t.type));
        return t;
    }
    
    //randomly generate a new crystal
    public Item newCrystal( ){
        Item t = new Item();
        t.category = Type.ITEM_CRYSTAL;
        t.type = Type.CRYSTAL;
        t.w = Type.BOARD_GRIDSIZE * 2/3;
        t.h = Type.BOARD_GRIDSIZE * 2/3;
        t.value = 500;
        PImage img = loadImage("imgs/items/crystal.png");
        t.setImgs(img);
        return t;
    }
    
    
}
