#include <stdlib.h>
#include "myLib.h"
#include "game.h"
#include "bg.h"
#include "snake.h"
#include "start.h"

OBJ_ATTR shadowOAM[128];

SNAKE snake[MAXSNAKELENGTH];
int snakeLength;
int segments;
//Variables
APPLE apple[MAXAPPLES];
int applesLeft;
int appleLoc;

int frameCounter;

void initGame() {
	DMANow(3, bgPal, PALETTE, bgPalLen / 2);
	DMANow(3, bgTiles, &CHARBLOCK[0], bgTilesLen / 2);
	DMANow(3, bgMap, &SCREENBLOCK[28], bgMapLen / 2);
    
    DMANow(3, snakePal, SPRITEPALETTE, 256);
   	DMANow(3, snakeTiles, &CHARBLOCK[4], snakeTilesLen / 2);
   	
   	hideSprites();
    
	initSnake();
	initApple();

	snakeLength = 0;
	segments = 0;
	appleLoc = -1;
	applesLeft = 5;
	frameCounter = 0;
}
void updateGame(){
	frameCounter++;
	segments++;
	updateSnake();
	updateApple();
}

void drawGame(){
	drawSnake();
	drawApple();
	waitForVBlank();
	DMANow(3, shadowOAM, OAM, 128 *4);
}
void initSnake(){
 for (int i = 0; i < MAXSNAKELENGTH; i++){
	snake[i].width = 4; 
	snake[i].height = 4;
	snake[i].row = SCREENHEIGHT/2 + (i * snake[i].height / 2);  
	snake[i].col = SCREENWIDTH/2 - (snake[i].width/2);
	snake[i].rdel = 4; 
	snake[i].cdel = 4;
	snake[i].active = 0;
	snake[i].hitWall = 0;
	snake[i].hitSnake = 0;
	snake[i].prevAniState = 0;
	snake[i].curAniState = 0; 
 }
 snake[0].active = 1;
 snakeLength++;
}

void drawSnake(){
	for (int i = 0; i < MAXSNAKELENGTH; i++){
		if(snake[i].active == 1){
			//snake head
			if (i == 0){
				shadowOAM[i].attr0 = snake[i].row | ATTR0_4BPP | ATTR0_SQUARE;
    			shadowOAM[i].attr1 = snake[i].col | ATTR1_TINY;
    			shadowOAM[i].attr2 = ATTR2_TILEID(3, 1); 
			} else { //snake body
				shadowOAM[i].attr0 = snake[i].row | ATTR0_4BPP | ATTR0_SQUARE;
				shadowOAM[i].attr1 = snake[i].col | ATTR1_TINY;
				shadowOAM[i].attr2 = ATTR2_TILEID(5, 1);
			}
		}
	}
}

void updateSnake() {
	if (frameCounter % 10 == 0){
		for (int i = MAXSNAKELENGTH; i >= 0; i--){ 
			//body of snake put where previous segment was
			if (i > 0){
				snake[i].row = snake[i -1].row;
				snake[i].col = snake[i -1].col;
			}
			if (i == 0){
				switch(snake[0].curAniState) {
					case UP:
						snake[i].row -= snake[i].rdel;
						snake[0].prevAniState = UP;
						break;
					case DOWN:
						snake[i].row += snake[i].rdel;
						snake[0].prevAniState = DOWN;
						break;
					case LEFT:
						snake[i].col -= snake[i].cdel;
						snake[0].prevAniState = LEFT;
						break;
					case RIGHT:
						snake[i].col += snake[i].cdel;
						snake[0].prevAniState = RIGHT;
						break;
				}
			}
		}
	}
	//checking if snake collided with self
	if (snakeLength > 1){
		for (int j = 1; j < MAXSNAKELENGTH; j++){
			if (snake[j].active && collision(snake[0].col, snake[0].row, snake[0].width, snake[0].height, snake[j].col, 
										snake[j].row,snake[j].width, snake[j].height)) {
				snake[0].hitSnake = 1;
			}
		}
	}
	

	if (BUTTON_PRESSED(BUTTON_LEFT) && snake[0].prevAniState != RIGHT) {
		snake[0].curAniState = LEFT;
	} else if (BUTTON_PRESSED(BUTTON_RIGHT) && snake[0].prevAniState != LEFT) {
		snake[0].curAniState = RIGHT;
	} else if (BUTTON_PRESSED(BUTTON_UP) && snake[0].prevAniState != DOWN) {
		snake[0].curAniState = UP;
	} else if (BUTTON_PRESSED(BUTTON_DOWN) && snake[0].prevAniState != UP) {
		snake[0].curAniState = DOWN;
	}
	//snake collided with wall
	if (snake[0].row < -1){
		snake[0].hitWall = 1;
	} else if (snake[0].row + snake[0].height >= 160){
		snake[0].hitWall = 1;
	} else if (snake[0].col < -1){
		snake[0].hitWall = 1;
	} else if (snake[0].col + snake[0].width >= SCREENWIDTH){
		snake[0].hitWall = 1;
	}	
}

void initApple(){
	for (int i = 0; i < MAXAPPLES; i++){
		apple[i].row = 0;
		apple[i].col = 0;
		apple[i].width = 16; // also weird because your apples aren't this big on the screen? fix how youre drawing them and then update this variable
		apple[i].height = 16;
		apple[i].active = 0;
	}
}

void updateApple(){
	for (int i = 0; i < MAXAPPLES; i++){
		if (apple[i].active == 0 && appleLoc == -1){
			apple[i].row = (rand() % (160 - 30)) + 10;
			apple[i].col = (rand() % (240 - 30)) + 10;
			apple[i].active = 1;
			appleLoc = i;
			break;
		}
	}
	//check collision between apple and snake head
	if (snake[0].active == 1){
		if (collision(apple[appleLoc].col, apple[appleLoc].row, apple[appleLoc].width, apple[appleLoc].height,
		snake[0].col, snake[0].row, snake[0].width, snake[0].height)){
				apple[appleLoc].active = 0;
				appleLoc = -1;
				applesLeft--;
				snakeLength++;
				for (int i = 0; i < MAXSNAKELENGTH; i++) {
					if (!snake[i].active) {
						snake[i].active = 1;
						break;
					}
				}
		}
	}
}

void drawApple(){
	for (int i = 0; i < MAXAPPLES; i++){
		if(apple[i].active == 1){
			shadowOAM[30 + i].attr0 = apple[i].row | ATTR0_4BPP | ATTR0_SQUARE;
			shadowOAM[30 + i].attr1 = apple[i].col | ATTR1_SMALL;
			shadowOAM[30 + i].attr2 = ATTR2_TILEID(0,0);
		}
	}
}