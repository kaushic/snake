# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 1 "myLib.h" 1




typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
# 64 "myLib.h"
extern unsigned short *videoBuffer;
# 85 "myLib.h"
typedef struct {
 u16 tileimg[8192];
} charblock;


typedef struct {
 u16 tilemap[1024];
} screenblock;



void setPixel3(int col, int row, unsigned short color);
void drawRect3(int col, int row, int width, int height, volatile unsigned short color);
void fillScreen3(volatile unsigned short color);
void drawImage3(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage3(const unsigned short *image);


void setPixel4(int col, int row, unsigned char colorIndex);
void drawRect4(int col, int row, int width, int height, volatile unsigned char colorIndex);
void fillScreen4(volatile unsigned char colorIndex);
void drawImage4(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage4(const unsigned short *image);


void waitForVBlank();
void flipPage();





typedef struct {
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
} OBJ_ATTR;



extern OBJ_ATTR shadowOAM[];
# 157 "myLib.h"
void hideSprites();
# 178 "myLib.h"
extern unsigned short oldButtons;
extern unsigned short buttons;
# 189 "myLib.h"
typedef volatile struct {
    volatile const void *src;
    volatile void *dst;
    volatile unsigned int cnt;
} DMA;


extern DMA *dma;
# 229 "myLib.h"
void DMANow(int channel, volatile const void *src, volatile void *dst, unsigned int cnt);




int collision(int colA, int rowA, int widthA, int heightA, int colB, int rowB, int widthB, int heightB);
# 2 "main.c" 2

# 1 "start.h" 1
# 22 "start.h"
extern const unsigned short startTiles[1536];


extern const unsigned short startMap[1024];


extern const unsigned short startPal[256];
# 4 "main.c" 2
# 1 "paused.h" 1
# 22 "paused.h"
extern const unsigned short pausedTiles[368];


extern const unsigned short pausedMap[1024];


extern const unsigned short pausedPal[256];
# 5 "main.c" 2
# 1 "bg.h" 1
# 22 "bg.h"
extern const unsigned short bgTiles[32];


extern const unsigned short bgMap[1024];


extern const unsigned short bgPal[256];
# 6 "main.c" 2
# 1 "win.h" 1
# 22 "win.h"
extern const unsigned short winTiles[1728];


extern const unsigned short winMap[1024];


extern const unsigned short winPal[256];
# 7 "main.c" 2
# 1 "lose.h" 1
# 22 "lose.h"
extern const unsigned short loseTiles[3712];


extern const unsigned short loseMap[1024];


extern const unsigned short losePal[256];
# 8 "main.c" 2
# 1 "snake.h" 1
# 21 "snake.h"
extern const unsigned short snakeTiles[4096];


extern const unsigned short snakePal[256];
# 9 "main.c" 2
# 1 "game.h" 1
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




extern int vOff;
extern int hOff;
extern int applesLeft;
extern int hitWall;
extern SNAKE snake[20];
extern APPLE apple[1];
extern int snakeLength;
extern int snakeCount;
extern int appleLoc;
extern OBJ_ATTR shadowOAM[128];
enum {UP, DOWN, LEFT, RIGHT};



void initGame();
void updateGame();
void drawGame();
void initSnake();
void updateSnake();
void drawSnake();
void initApple();
void updateApple();
void drawApple();
# 10 "main.c" 2


void initialize();


void goToStart();
void start();
void goToGame();
void game();
void goToPause();
void pause();
void goToWin();
void win();
void goToLose();
void lose();


enum {START, GAME, PAUSE, WIN, LOSE};
int state;






unsigned short buttons;
unsigned short oldButtons;




int main() {

    initialize();

    while(1) {


        oldButtons = buttons;
        buttons = (*(volatile unsigned short *)0x04000130);


        switch(state) {

            case START:
                start();
                break;
            case GAME:
                game();
                break;
            case PAUSE:
                pause();
                break;
            case WIN:
                win();
                break;
            case LOSE:
                lose();
                break;
        }

    }
}


void initialize() {
    (*(volatile unsigned short*)0x4000008) = ((0)<<2) | ((28)<<8) | (0<<7) | (3<<14);
    (*(unsigned short *)0x4000000) = 0 | (1<<8) | (1<<12);


    goToStart();
}


void goToStart() {
    (*(volatile unsigned short *)0x04000012) = 0;
    DMANow(3, startPal, ((unsigned short *)0x5000000), 256);
    DMANow(3, startTiles, &((charblock *)0x6000000)[0], 3072/2);
    DMANow(3, startMap, &((screenblock *)0x6000000)[28], 1024);
    state = START;
}


void start() {
    if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3))))) {
        goToGame();
        initGame();
    }
}


void goToGame() {
    DMANow(3, bgPal, ((unsigned short *)0x5000000), 256);
    DMANow(3, bgTiles, &((charblock *)0x6000000)[0], 3072/2);
    DMANow(3, bgMap, &((screenblock *)0x6000000)[28], 1024);
    state = GAME;
}


void game() {
    updateGame();
    waitForVBlank();
    drawGame();


    if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
        goToPause();
    else if (applesLeft == 0)
        goToWin();
    else if (snake[0].hitWall == 1 || snake[0].hitSnake == 1)
        goToLose();
}


void goToPause() {
    (*(volatile unsigned short *)0x04000012) = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, pausedTiles, &((charblock *)0x6000000)[0], 736/2);
    DMANow(3, pausedMap, &((screenblock *)0x6000000)[28], 2048/2);
    DMANow(3, pausedPal, ((unsigned short *)0x5000000), 512/2);
    DMANow(3, shadowOAM, ((OBJ_ATTR*)(0x7000000)), 256);
    state = PAUSE;
}


void pause() {

    waitForVBlank();

    if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
        goToGame();
    else if ((!(~(oldButtons)&((1<<2))) && (~buttons & ((1<<2)))))
        goToStart();
}


void goToWin() {
    (*(volatile unsigned short *)0x04000012) = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, shadowOAM, ((OBJ_ATTR*)(0x7000000)), 256);
    DMANow(3, winPal, ((unsigned short *)0x5000000), 512/2);
    DMANow(3, winTiles, &((charblock *)0x6000000)[0], 3456/2);
    DMANow(3, winMap, &((screenblock *)0x6000000)[28], 2048/2);
    state = WIN;
}


void win() {

    waitForVBlank();

    if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
        goToStart();
}


void goToLose() {
    (*(volatile unsigned short *)0x04000012) = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, shadowOAM, ((OBJ_ATTR*)(0x7000000)), 256);
    DMANow(3, losePal, ((unsigned short *)0x5000000), 512/2);
    DMANow(3, loseTiles, &((charblock *)0x6000000)[0], 7424/2);
    DMANow(3, loseMap, &((screenblock *)0x6000000)[28], 2048/2);

    state = LOSE;
}


void lose() {

    waitForVBlank();

    if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
        goToStart();
}
