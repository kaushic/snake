#include "myLib.h"
// TODO 1.0: Include your .h files here.
#include "start.h"
#include "paused.h"
#include "bg.h"
#include "win.h"
#include "lose.h"
#include "snake.h"
#include "game.h"

// Prototypes
void initialize();

// State Prototypes
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

// States
enum {START, GAME, PAUSE, WIN, LOSE};
int state;

//apples
//int applesLeft; 

//OBJ_ATTR shadowOAM[128];
// Button Variables
unsigned short buttons;
unsigned short oldButtons;




int main() {

    initialize();

    while(1) {

        // Update button variables
        oldButtons = buttons;
        buttons = BUTTONS;

        // State Machine
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

// Sets up GBA
void initialize() {
    REG_BG0CNT = BG_CHARBLOCK(0) | BG_SCREENBLOCK(28) | BG_4BPP | BG_SIZE_LARGE;
    REG_DISPCTL = MODE0 | BG0_ENABLE | SPRITE_ENABLE; 

    //applesLeft = 1;
    goToStart();
}

// Sets up the start state
void goToStart() {
    REG_BG0VOFF = 0;
    DMANow(3, startPal, PALETTE, 256);
    DMANow(3, startTiles, &CHARBLOCK[0], startTilesLen/2);
    DMANow(3, startMap, &SCREENBLOCK[28], 1024);
    state = START;
}

// Runs every frame of the start state
void start() {
    if (BUTTON_PRESSED(BUTTON_START)) {
        goToGame();
        initGame();
    }
}

// Sets up the game state
void goToGame() {
    DMANow(3, bgPal, PALETTE, 256);
    DMANow(3, bgTiles, &CHARBLOCK[0], startTilesLen/2);
    DMANow(3, bgMap, &SCREENBLOCK[28], 1024);
    state = GAME;
}

// Runs every frame of the game state
void game() {
    updateGame();
    waitForVBlank();
    drawGame();

    // State transitions
    if (BUTTON_PRESSED(BUTTON_START))
        goToPause();
    else if (applesLeft == 0)
        goToWin();
    else if (snake[0].hitWall == 1 || snake[0].hitSnake == 1)
        goToLose();
}

// Sets up the pause state
void goToPause() {
    REG_BG0VOFF = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, pausedTiles, &CHARBLOCK[0], pausedTilesLen/2);
    DMANow(3, pausedMap, &SCREENBLOCK[28], pausedMapLen/2);
    DMANow(3, pausedPal, PALETTE, pausedPalLen/2);
    DMANow(3, shadowOAM, OAM, 256);
    state = PAUSE;
}

// Runs every frame of the pause state
void pause() {
    // Lock the framerate to 60 fps
    waitForVBlank();
    // State transitions
    if (BUTTON_PRESSED(BUTTON_START))
        goToGame();
    else if (BUTTON_PRESSED(BUTTON_SELECT))
        goToStart();
}

// Sets up the win state
void goToWin() {
    REG_BG0VOFF = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, shadowOAM, OAM, 256);
    DMANow(3, winPal, PALETTE, winPalLen/2);
    DMANow(3, winTiles, &CHARBLOCK[0], winTilesLen/2);
    DMANow(3, winMap, &SCREENBLOCK[28], winMapLen/2);
    state = WIN;
}

// Runs every frame of the win state
void win() {
    // Lock the framerate to 60 fps
    waitForVBlank();
    // State transitions
    if (BUTTON_PRESSED(BUTTON_START))
        goToStart();
}

// Sets up the lose state
void goToLose() {
    REG_BG0VOFF = 0;
    waitForVBlank();
    hideSprites();
    DMANow(3, shadowOAM, OAM, 256);
    DMANow(3, losePal, PALETTE, losePalLen/2);
    DMANow(3, loseTiles, &CHARBLOCK[0], loseTilesLen/2);
    DMANow(3, loseMap, &SCREENBLOCK[28], loseMapLen/2);

    state = LOSE;
}

// Runs every frame of the lose state
void lose() {
    // Lock the framerate to 60 fps
    waitForVBlank();
    // State transitions
    if (BUTTON_PRESSED(BUTTON_START))
        goToStart();
}