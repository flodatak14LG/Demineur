/*
 *lost/win screen -> restart
 *indications bombs bottom
 => UI
 *click on number = discover all around
*/

int cell_size,world_width,world_height;

Cell[][] cells;
Cell currCell;
int bombs_to_set;
int bombs_to_find;
int nb_cells_width;
int nb_cells_height;

int longPress;

boolean started,lost;

void setup() {
  world_width = width;
  cell_size = world_width/9;
  world_height = cell_size*15;
  bombs_to_set = 13;
  bombs_to_find = 5;
  nb_cells_width = world_width/cell_size;
  nb_cells_height = world_height/cell_size;
  cells = new Cell[nb_cells_width][nb_cells_height];
  for(int x = 0; x<nb_cells_width; x++) {
    for(int y = 0; y<nb_cells_height; y++) {
      /*boolean b = false;
      if((int)random(2) == 1 && bombs_to_set !=0){
        bombs_to_set--;
        b = true;
      }*/
      cells[x][y] = new Cell(x,y,cell_size,cell_size,false);
      //rect(x*cell_size,y*cell_size,cell_size,cell_size);
    }
  }
  //initBombs(bombs_to_set);
  //println(cells[0].length);
}

void draw() {
  background(200);
  rectMode(CENTER);
  for(int x = 0; x<world_width/cell_size; x++) {
    for(int y = 0; y<world_height/cell_size; y++) {
      cells[x][y].show();
    }
  }
  fill(0);
  textSize(100);
  text(str(bombs_to_set - flags()),100,height-100);
}

void mousePressed() {
  longPress = millis();
}

void mouseReleased() {
  if(!started) {
    initBombs(bombs_to_set,mouseX/cell_size,mouseY/cell_size);
    started = true;
  }
  
  if(mouseY<world_height && mouseX<world_width) {
    Cell currCell = cells[mouseX/cell_size][mouseY/cell_size];
    if(!lost) {
      if(millis()-longPress>=500 && !currCell.show) {
        currCell.flag = !currCell.flag;
      } else {
        if(currCell.bomb) lost = true;
        else if(!currCell.flag) currCell.show = true;
      }
      
      /*if(currCell.neighbors() == 0) {
      for(int xx = currCell.x-1; xx<= currCell.x+1; xx++) {
        for(int yy = currCell.y-1; yy<= currCell.y+1; yy++) {
          if(xx>0 && xx<nb_cells_width && yy>0 && yy<nb_cells_height)cells[xx][yy].show = true;
        }
      }
      
      }*/
    }
  }
}

void initBombs(int nb_bombs,int exceptX,int exceptY) {
  int[] ex = {exceptX-1,exceptX,exceptX+1}; 
  int[] ey = {exceptY-1,exceptY,exceptY+1};
  for(int i = 0; i<nb_bombs;i++){
    int x = (int)random(nb_cells_width);
    int y = (int)random(nb_cells_height);
    if(!hasValue(ex,x) && !hasValue(ey,y) && !cells[x][y].bomb) {
      cells[x][y].bomb = true; 
    } else i--;
  }
}