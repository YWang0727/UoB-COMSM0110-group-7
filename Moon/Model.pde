/**
* @author imyuanxiao, participants
* Contains all data
*/
public class Model{
   protected Map map;
   protected Player player;
   protected ItemFactory itemFactory;
   protected EnemyFactory enemyFactory;
   protected RoomFactory roomFactory;
   protected BlockFactory blockFactory;
   protected DecorationFactory decorationFactory;
   
   protected boolean isMusicPlaying = true;
   protected boolean menuHomePage = true;
   protected boolean menuControl = false;
   protected boolean gameStart = false;
   protected boolean gamePause = false;
   protected boolean gameOver = false;
   protected boolean globalList = false;

   public Model(){
       this.blockFactory = new BlockFactory();
       this.roomFactory = new RoomFactory(blockFactory);
       map = new Map();
       map.addRoom(roomFactory.newRoom(Type.ROOM_START)); //<>// //<>// //<>// //<>// //<>// //<>// //<>//

   }
   
   public void addPlayer(Player p){
      this.player = p;
   }
   
   
   public Item newItem(int[] pos){
      return itemFactory.newItem(pos);
   }
      
   public void addRoom(int type){
      map.addRoom(roomFactory.newRoom(type));
   }
   
   public Room getNewRoom(){
      return map.getNewRoom(roomFactory.id - 1);
   }
   
   public Room getCurrentRoom(){
      return map.getCurrentRoom();
   }
   
   public int getIndexByDirection(int type){
      return map.getIndexByDirection(type);
   }
   
   public void setCurrentRoomIndex(int index){
       map.setCurrentRoomIndex(index);
   }
   
   public void useItemByPlayer(){
      itemFactory.useItemByPlayer(player);
   }
  
   
}
