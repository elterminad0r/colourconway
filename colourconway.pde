Boolean[][] grid, old;
int[][] durs;
int unit;

void setup() {
  //frameRate(10);
  unit = 4;
  size(1280, 720);
  old = new Boolean[(int)(width / unit)][(int)(height / unit)];
  grid = new Boolean[(int)(width / unit)][(int)(height / unit)];
  durs = new int[(int)(width / unit)][(int)(height / unit)];
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[0].length; y++) {
      durs[x][y] = 0;
      if (x == 0 | y == 0 | x == grid.length - 1 | y == grid[0].length - 1) {
        grid[x][y] = false;
      } else{
        if (random(1) < 0.5) {
          grid[x][y] = false;
        } else {
          grid[x][y] = true;
        }
      }
    }
  }
  stroke(255);
}

void draw() { 
  background(0);
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[0].length; y++) {
      old[x][y] = grid[x][y];
      if (grid[x][y]) {
        stroke(255, 255 - durs[x][y], 0);
        fill(255, 255 - durs[x][y], 0);
      } else {
        stroke(255 - durs[x][y]);
        fill(255 - durs[x][y]);
      }
      rect(x * unit, y * unit, unit, unit);
    }
  }
  
  
  
  for(int x = 1; x < grid.length - 1; x++) {
    for (int y = 1; y < grid[0].length - 1; y++) {
      Boolean[] neighbours = {old[x - 1][y + 1], old[x    ][y + 1], old[x + 1][y + 1],
                              old[x - 1][y    ],                    old[x + 1][y    ],
                              old[x - 1][y - 1], old[x    ][y - 1], old[x + 1][y - 1]};
                             
                              
      int totNe = 0;
      
      for (Boolean i : neighbours) {
        if (i) {
          totNe++;
        }
      }
      
      if (old[x][y]) {
        if (totNe < 2 | totNe > 3) {
          grid[x][y] = false;
          durs[x][y] = 0;
        } else {
          if (durs[x][y] < 255) {
            durs[x][y]++;
          }
        }
      } else {
        if (totNe == 3) {
          grid[x][y] = true;
          durs[x][y] = 0;
        } else {
          if (durs[x][y] < 255) {
            durs[x][y]++;
          }
        }
      }
    }
  }
  
}