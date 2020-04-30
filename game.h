typedef struct {
	int row;
	int col;
    int rdel;
    int cdel;
	int width;
    int height;
    int active;
    int hitWall;
    int hitSnake;
    int prevAniState;
    int curAniState;
}SNAKE;

typedef struct {
    int row;
    int col;
    int width;
    int height;
    int active;
}APPLE;

#define MAXSNAKELENGTH 20
#define MAXAPPLES 1
// Variables
extern int vOff;
extern int hOff;
extern int applesLeft;
extern int hitWall;
extern SNAKE snake[MAXSNAKELENGTH];
extern APPLE apple[MAXAPPLES];
extern int snakeLength;
extern int snakeCount;
extern int appleLoc;
extern OBJ_ATTR shadowOAM[128];
enum {UP, DOWN, LEFT, RIGHT};


//Prototypes
void initGame();
void updateGame();
void drawGame();
void initSnake();
void updateSnake();
void drawSnake();
void initApple();
void updateApple();
void drawApple();