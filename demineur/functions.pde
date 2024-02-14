boolean hasValue(int[] list,int element) {
  for(int e : list) {
    if(e==element) return true;
  }
  return false;
}

int flags() {
  int flags = 0;
  for(Cell[] i:cells) {
    for(Cell c:i) {
      if(c.flag) flags++;
    }
  }
  return flags;
}