public static class Collision{

   /**
   * Collision detection between two BasicProp obj
   * Only useful when two objects are rect
   */
   public static boolean detect(BasicProp a, BasicProp b){
       if(a.location.x + a.w > b.location.x &&
          a.location.x < b.location.x + b.w &&
          a.location.y + a.h > b.location.y &&
          a.location.y < b.location.y + b.h){
          return true;   
       }
       return false;
   }
   
   /**
   * Collision detection between one BasicProp obj and one block
   * block's position can be calculated by i and j
   */
   public static boolean detect(BasicProp a, int i, int j){
       int s = Type.BOARD_GRIDSIZE;
       if(a.location.x + a.w > j * s &&
          a.location.x < j * s + s &&
          a.location.y + a.h > i * s &&
          a.location.y < i * s + s){
          return true;   
       }
       return false;
   }
   
   //added this boolean so that we can turn off collision detection for blocks other than the background
   //if return false, player can through these type of blocks
   //when player, throughDown = p.getThroughDown(), others, checkDown = false && throughDown = true
   public static boolean cantThrough(int type, boolean checkDown, ActionProp o){
     if(type == Type.BLOCK_EMPTY || type == Type.BLOCK_CRATE || type == Type.BLOCK_SPIKE){
       return false;
     }
     
     if(type == Type.BLOCK_PLATFORM){
        // o == null - o is bullet or o is fly, can through
        if(o == null || o.fly){
           return false;
        }
        if(checkDown && !o.throughDown){
           return true;
        }else{
           return false;
        }
     }
     return true;
   }
  
   /**
   * Collision detection between:
   * enemies and blocks,
   * enemies and player
   * enemies and bullets
   * bullets and blocks
   * player and blocks
   */
   public static void checkAllAround(Player p, Room r){
     
      //collision detection between enemies and blocks, enemies and player,enemies and bullets
      ArrayList<Enemy> enemies = r.enemies;
      ArrayList<Bullet> bullets = r.playerBullets;
      for(int i = enemies.size() - 1; i >= 0; i--){
         Enemy e = enemies.get(i);
         if(!e.isAlive &&  e.canRemove){
             enemies.remove(i);
         }
         checkAround(e, r);
         if(detect(p,e)){
            p.attacked(e.dp, e);
         }
         for(int j = bullets.size() - 1; j >= 0 ; j--){
             Bullet b = bullets.get(j);
             //if b out of board, remove
             if(b.location.y > Type.SCREEN_WIDTH || b.location.y < 0 || b.location.x > Type.SCREEN_WIDTH || b.location.x < 0){
                bullets.remove(j);
             }
             //check bullets and enemies
             else if(detect(b,e)){
                if(b.type != Type.BULLET_TYPE_MINER){
                    e.attacked(b.dp, b);
                    bullets.remove(j);
                    break;
                }
             }
         }
      }
      
      //collision detection between bullets and blocks
       //if b crash blocks, remove
         for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(cantThrough(r.getBlockType(i,j), false, null)){
                    if(r.getBlockType(i,j) != Type.BLOCK_CRYSTAL){
                        for(int k = bullets.size() - 1; k >= 0 ; k--){
                            Bullet b = bullets.get(k);
                            if(detect(b, i, j)){
                                 bullets.remove(k);
                             }
                       }
                    }else{
                       for(int k = bullets.size() - 1; k >= 0 ; k--){  //minergun bullet meets crystal block: The design could be modified to a more interesting type...
                            Bullet b = bullets.get(k);
                            if(detect(b, i, j)){
                               if(b.type == Type.BULLET_TYPE_MINER){
                                 r.blockType[i][j] = 0;
                               }
                               bullets.remove(k);
                            }
                       }
                    }
                }
            }
         }
      checkAround(p, r);
   }
   
   /**
   * Collision detection between player and blocks
   */
   public static void checkAround(ActionProp o, Room r){
      checkLeft(o, r);
      checkRight(o, r);
      checkUp(o, r);
      checkDown(o, r);
      checkMore(o, r);
   }
   
   /**
   * Collision detection between player and blocks above
   */
    public static void checkUp(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w;
      float s = Type.BOARD_GRIDSIZE;
      int upper = (int)(y/s) - 1;
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      //all blocks above are !cantThrough(), o can through
      boolean canThrough = true;
      for(int i = L; i <= R && upper >= 0; i++){
         if(cantThrough(r.getBlockType(upper,i),false,o) && (y + o.getFullVelocityY() <= upper * s + s)){
            canThrough = false;
         }
      }
      if(!canThrough){
          o.setAllVelocityY(0);
          o.fall = false;
          o.location.y = upper * s + s + 1;
      }
   }
 
   /**
   * Collision detection between player and blocks below
   * Changing properties of player by checking whether player is on special blocks.
   */
    public static void checkDown(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w, h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int below = (int)((y + h)/s) + 1;
      
      int L = (int)(x/s) ;
      int R = (int)((x+w)/s);
      boolean canFall = true, canHighJump = false, canUsePortal = false;
      int portalPos = 0;
      //all blocks below are !cantThrough(), o can through
      for(int i = L; i <= R && below < Type.BOARD_MAX_HEIGHT; i++){
         int bType = r.getBlockType(below,i);
         
         //for all obj
         if(cantThrough(bType,true,o)){
             canFall = false;
         }
         
         //for player
         if(o.type == Type.PLAYER){
             //portal
             if(bType == Type.BLOCK_PORTAL){
                 canUsePortal = true;
                 portalPos = i;
             }
             
             //bounce
             o.highJump = false;
             if(bType == Type.BLOCK_BOUNCE){
                 canHighJump = true;
             }
             
             //spike - basic implemenation for now as we don't yet have a death mechanic
             if(o.fall && (bType == Type.BLOCK_SPIKE)){
                stab.play(2);
                o.attacked(5, null);
             }
         }
         
      }
      
       //if enemies, change direction
       if(o.type != Type.PLAYER){
           //make enemy move to right
           if(L >= 0 && o.left && !cantThrough(r.getBlockType(below,L), false, null)){
              o.left = false;
              o.velocity.x = abs(o.velocity.x);
              o.location.x = L * s + s + 1;
           }
           //make enemy move to left
           if(R < 29 && !o.left && !cantThrough(r.getBlockType(below,R), false, null)){
               o.left = true;
               o.velocity.x = -abs(o.velocity.x);
               o.location.x = R * s - w - 1;
           }
       }
      
      
      if(!canFall && (y + h + o.getFullVelocityY()>= below * s)){
            o.fall = false;
            o.jump = false;
            o.setAllVelocityY(0);
            o.location.y = below * s - h - 1;
             if(o.type == Type.PLAYER){
                   if(o.fallDist > Type.FALL_DAMAGE_DIST){
                       o.attacked(Type.FALL_DAMAGE, null);
                       o.fallDist = 0;
                       playerHurt.play(2);
                   }
             }
            
       }else{
             o.fall = true;
             o.jump = true;
       }
       
       if(canHighJump){
           o.highJump = true;
       }
       
       if(canUsePortal){
           o.onPortal = true;
           if(!o.transported){
               Block b = r.getBlockByPos(below , portalPos);
               usePortal(o, b);
               o.transported = true;
               return;
           }
       }else{
             o.onPortal = false;
       }
         
   }
   
   /**
   * If player use portal, player's position will be changed
   * according to int[] portal of that portal block
   */
   public static void usePortal(ActionProp o, Block b){
       portal.play(2);
       float  s = Type.BOARD_GRIDSIZE;
       int[] portal = b.getPortal(); 
       o.location.y = s * portal[0];
       o.location.x = s * portal[1] + 5;
   }
   
    public static void checkLeft(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int left = (int)(x/s) - 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      
      boolean canMoveForward = true;
      for(int i = U; i <= D && left >= 0; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.getBlockType(i,left);
            if(o.type != Type.PLAYER){
              if(cantThrough(bType,false,null) && (x + o.getFullVelocityX() * 10 <= left * s + s)){
                 canMoveForward = false;
              }
            }else{
                if(cantThrough(bType,false,null) && (x + o.getFullVelocityX() <= left * s + s)){
                   canMoveForward = false;
                }
            }
      }
      
     if(!canMoveForward){
        if(o.type != Type.PLAYER){
           o.changeDir(false);
        }else{
           o.setAllVelocityX(0);
        }
        o.location.x = left * s + s + 1;
      }
   }
   
   public static void checkRight(ActionProp o, Room r){
      float x = o.location.x, y = o.location.y;
      float w = o.w, h = o.h;
      float s = Type.BOARD_GRIDSIZE;
      int right = (int)((x + w)/s) + 1;
      int U = (int)(y/s) ;
      int D = (int)((y+h)/s);
      boolean canMoveForward = true;
      for(int i = U; i <= D && right < Type.BOARD_MAX_WIDTH; i++){
            if(i < 0 || i >= Type.BOARD_MAX_HEIGHT){
               canMoveForward = false;
               break;
            }
            int bType = r.getBlockType(i,right);
            if(o.type != Type.PLAYER){
              if(cantThrough(bType,false,null) && (x + w + o.getFullVelocityX()*10 >= right * s)){
                  canMoveForward = false;
              }
            }else{
              if(cantThrough(bType,false,null) && (x + w + o.getFullVelocityX() >= right * s)){
                  canMoveForward = false;
              }
            }
      }
      
      if(!canMoveForward){
          if(o.type != Type.PLAYER){
             o.changeDir(true);
          }else{
             o.setAllVelocityX(0);
          }
          o.location.x = right * s - w - 1;
      }
      
   }

   //if still collision, player collides with corner of block, need to reset position
   public static void checkMore(ActionProp o, Room r){
        for(int i = 0; i < Type.BOARD_MAX_HEIGHT; i++){
            for(int j = 0; j < Type.BOARD_MAX_WIDTH; j++){
                if(cantThrough(r.getBlockType(i,j) , false, o) && detect(o, i, j)){
                    float s = Type.BOARD_GRIDSIZE;
                    float y = o.location.y, by = i * s;
                    float  h = o.h;
                   if(y > by && y < by + s){
                        o.setAllVelocityY(0);
                        o.location.y = by + s + 1;
                    }else if(y + h > by && y + h < by + s){
                        o.setAllVelocityY(0);
                        o.location.y = by - h - 1;
                    }
                }
            }
         }
   }

}
