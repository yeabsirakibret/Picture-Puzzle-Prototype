class Block{
  float x, y, w, h;
  
  boolean hovered = false, isActive;
  String id;
  PImage img;
  
  Block(float x, float y, float w, float h, boolean isActive, PImage img, String id){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isActive = isActive;
    this.img = img;
    this.id = id;
  }
  
  void show(){
    if(isActive){
      
      if(hovered)
        tint(100,255,100);
      else
        tint(255);
        
      image(img, x+1, y+1);
    }else{
      fill(255, 255, 127);
      rect(x, y, w, h);
    }
    
    
   // rect(x, y, w, h);
    fill(255,0,0);
    text(id, x+w/5, y+h/1.5);
  }
  
  
  
}
