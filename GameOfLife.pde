import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 20;
int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

void setup () {
  size(400, 400);
  frameRate(8);
  // make the manager
  Interactive.make(this);

  //your code to initialize buttons goes here
  buttons = new Life [NUM_ROWS][NUM_COLS];
  for (int i = 0; i < NUM_ROWS; i++)
  {
    for (int j = 0; j < NUM_COLS; j++)
    {
      buttons[i][j] = new Life(i, j);
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background(0);
  
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for (int i = 0; i < NUM_ROWS; i++)
  {
    for (int j = 0; j < NUM_COLS; j++)
    {
      if (countNeighbors(i, j) == 3)
        buffer[i][j] = true;
      else if (countNeighbors(i, j) == 2 && buttons[i][j].getLife())
        buffer[i][j] = true;
      else
        buffer[i][j] = false;
      buttons[i][j].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if (key == ' ')
    running = !running;
}

public void copyFromBufferToButtons() {
  //your code here
  for (int i = 0; i< NUM_ROWS; i++)
  {
    for (int j = 0; j < NUM_COLS; j++)
    {
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for (int i = 0; i< NUM_ROWS; i++)
  {
    for (int j = 0; j < NUM_COLS; j++)
    {
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  //your code here
  if (r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
    return true;
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  //your code here
  if (isValid(row+1, col))
  {
    if (buttons[row+1][col].getLife())
      neighbors += 1;
  }
  if (isValid(row, col+1))
  {
    if (buttons[row][col+1].getLife())
      neighbors += 1;
  }
  if (isValid(row+1, col+1))
  {
    if (buttons[row+1][col+1].getLife())
      neighbors += 1;
  }
  if (isValid(row-1, col-1))
  {
    if (buttons[row-1][col-1].getLife())
      neighbors += 1;
  }
  if (isValid(row+1, col-1))
  {
    if (buttons[row+1][col-1].getLife())
      neighbors += 1;
  }
  if (isValid(row-1, col+1))
  {
    if (buttons[row-1][col+1].getLife())
      neighbors += 1;
  }
  if (isValid(row-1, col))
  {
    if (buttons[row-1][col].getLife())
      neighbors += 1;
  }
  if (isValid(row, col-1))
  {
    if (buttons[row][col-1].getLife())
      neighbors += 1;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; 
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
    fill( 255 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive = living;
  }
}

