ArrayList<Block> blocks;
float s = 100;

float imx = -1, imy= -1;
Block curLocked, curBlank;
PImage img;

ArrayList<PImage> img_pieces = new ArrayList<PImage>();

void setup(){
  size(700, 700);
  img = loadImage("mesob.jpg");
  img.resize(500,500);
  

  
  addBlocks();
}

void addBlocks(){
  blocks = new ArrayList<Block>();
  
  String rCors = "";
  
  while(rCors.split(" ").length != 25){
    
    String r_id = int(random(0,(width/s)-2)) + "," + int(random(0,(height/s)-2));
  
    if(!rCors.contains(r_id))
      rCors += r_id+" ";
    
  }
  
  println(rCors);
  
  //rCors = "0,0 0,1 0,2 0,3 0,4 1,0 1,1 1,2 1,3 1,4 2,0 2,1 2,2 2,3 2,4 3,0 3,1 3,2 3,3 3,4 4,0 4,1 4,2 4,3 4,4";
  println(rCors);
     
  String[] r_cors = rCors.split(" ");
  int i = 0;
  
  
  for(int r=1; r<(width/s)-1; r++){
    for(int c=1; c<(height/s)-1; c++){
      
      int rand_r = int(r_cors[i].charAt(0)+""), rand_c = int(r_cors[i].charAt(2)+"");
      
      boolean active = !(r == (width/s)-2 && c == (height/s)-2);
      PImage part_img = img.get(int(s*rand_c), int(s*rand_r), int(s-2), int(s-2));
      
      blocks.add(new Block(s*c, s*r, s, s, active, part_img, r_cors[i]));
      
      i++;
      
     }
  }
  
  swipeVals();
  
}

void swipeVals(){
  
 for(Block b:blocks){
   if(!b.isActive){
     for(Block ba:blocks){
       
       if(ba.isActive && ba.id.equals("4,4")){
         PImage img_temp = ba.img;

         ba.img = b.img;
         ba.id = b.id;
         b.id = "4,4";
         b.img = img_temp;
         
         break;
         
       }
       
     }
     
     break;
   }
   
 }
 
}

void showBlocks(){
  for(Block b:blocks){
    b.show();
    
    if(b.isActive == false)
      curBlank = b;
    
    if(int(mouseX/s) == int(b.x/s) && int(mouseY/s) == int(b.y/s) && mousePressed && curLocked==null){
      
      b.hovered = true;
      curLocked = b;
      
    }else if(curLocked==null){
      b.hovered = false;
    }
   
    
    
  }
}

void draw(){
  background(0);
  fill(255);
  textSize(50);
  showBlocks();
  println(isSolved());
  
  
  

  if(mousePressed && int(mouseX/s) < 6 && int(mouseX/s) > 0 &&  int(mouseY/s) < 6 && int(mouseY/s) > 0){
    
    if(abs(mouseX-imx) > abs(mouseY-imy)){
     
      if((mouseX-imx) > 0){
        
        //println("to Right");
        
        if(isBlankAt(int(curLocked.y/s), int(curLocked.x/s)+1) && abs(mouseX-imx) > 10)
          swipeBlank('H');
          
          
      }else if((mouseX-imx) < 0){
        //println("to Left");
        if(isBlankAt(int(curLocked.y/s), int(curLocked.x/s)-1) && abs(mouseX-imx) > 10)
          swipeBlank('H');
      }
      
    }else if(abs(mouseX-imx) < abs(mouseY-imy)){
      
      if((mouseY-imy) > 0){
        //println("to Down");
        if(isBlankAt(int(curLocked.y/s)+1, int(curLocked.x/s)) && abs(mouseY-imy) > 10)
          swipeBlank('V');
        
      }else if((mouseY-imy) < 0){
        //println("to Up");
        if(isBlankAt(int(curLocked.y/s)-1, int(curLocked.x/s)) && abs(mouseY-imy) > 10)
          swipeBlank('V');
      }
      
    }
    
  }
  
  
}


boolean isBlankAt(int r, int c){
 

   if(int(curBlank.x/s) == c && int(curBlank.y/s) == r)
     return true;

 
 return false; 
}

void swipeBlank(char pos){
  if(pos == 'H'){
    float tempX = curLocked.x;
  
    curLocked.x = curBlank.x;
    curBlank.x = tempX; 
  }else if(pos == 'V'){
    float tempY = curLocked.y;
  
    curLocked.y = curBlank.y;
    curBlank.y = tempY; 
  }
  
  
  
}

void solve(){
  for(Block b:blocks){
   
    int br = int(b.y/s), bc = int(b.x/s);
    int br_r = int(b.id.charAt(0)+""), br_c = int(b.id.charAt(2)+"");
    
    b.x = (br_c+1) * s;
    b.y = (br_r+1) * s;
    
  }
  
}

boolean isSolved(){
  for(Block b:blocks){
   
    int br = int(b.y/s), bc = int(b.x/s);
    int br_r = int(b.id.charAt(0)+""), br_c = int(b.id.charAt(2)+"");
    
    if(br != br_r+1 || bc != br_c+1)
      return false;
    
  }

  return true;
}

void keyPressed(){
  if(key == 'r')addBlocks(); 
  else if(key =='s') solve();
}

void mousePressed(){
  imx = mouseX;
  imy = mouseY;
}

void mouseReleased(){
  imx = -1;
  imy = -1;
  curLocked = null;
}
