class Cell {
  int x,y,w,h;
  boolean show = false;
  boolean flag = false;
  boolean bomb;
  Cell(int xc,int yc,int wc,int hc,boolean bomb_case) {
    x=xc;
    y=yc;
    w=wc;
    h=hc;
    bomb = bomb_case;
  }
  
  int neighbors() {
    int count = 0;
    for(int xrow = (x==0? 0:x-1); xrow<=(x==cells.length-1? x:x+1);xrow++) {
      //println(x);
      //println(xrow);
      for(int yrow = (y==0? 0:y-1); yrow<=(y==cells[0].length-1? y:y+1);yrow++) {
        if(cells[xrow][yrow].bomb) count++;
      }
    }
    return count;
  }
  
  boolean isPressed() {
    if(abs(mouseX-x)<w/2 && abs(mouseY-y)<h/2) {
      return true;
    }
    return false;
  }
  
  void show() {
    if(bomb && lost) fill(255,0,0);
    else if(flag) fill(0,255,0);
    else fill(255);
    rect(x*w+w/2,y*h+h/2,w,h);
    if(this.show) {
      //if(bomb) fill(255,0,0);
      //println(this.neighbors());
      textAlign(CENTER);
      textSize(h);
      fill(0);
      text(this.neighbors(),x*w+w/2,y*h+h/4*3);
      if(this.neighbors() == 0) {
        for(int xx = x-1; xx<= x+1; xx++) {
          for(int yy = y-1; yy<= y+1; yy++) {
            if(xx>=0 && xx<nb_cells_width && yy>=0 && yy<nb_cells_height)cells[xx][yy].show = true;
          }
        }
      }
    }
  }
  
}