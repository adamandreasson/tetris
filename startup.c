/*
 * Tetris game lul
 * 
 * GPIO D8-15: Keypad
 * GPIO E: LCD display
 * 
*/

#include "types.h"
#include "delay.h"
#include "gpio.h"
#include "lcd.h"
#include "keypad.h"

#define min(a,b)	(((a)<(b)?(a):(b)))
#define max(a,b)	(((a)>(b)?(a):(b)))

void startup(void) __attribute__((naked)) __attribute__((section (".start_section")) );

void startup ( void )
{
asm volatile(
	" LDR R0,=0x2001C000\n"		/* set stack */
	" MOV SP,R0\n"
	" BL main\n"				/* call main */
	".L1: B .L1\n"				/* never return */
	) ;
}

uint8 frameBuffer0[1024], frameBuffer1[1024];		
uint8 *frontBuffer = frameBuffer0;
uint8 *backBuffer =	frameBuffer1;

void init_app(void) {
	/* PORT D */
	portD.moder = 0x55005555; // D0-3 inputs, D4-7 outputs
	portD.otyper = 0x0F00; // D0-3 open drain, D4-7 push-pull
	portD.pupdr = 0x00AA0000; // D0-3 pull-down, D4-7 floating
	
	/* PORT E */
	portE.moder = 0x55555555; /* all bits outputs */
	portE.otyper = 0x0000; /* outputs are push/pull */
	portE.ospeedr = 0x55555555; /* medium speed */
	portE.pupdr = 0x55550000; /* inputs are pull up */
}

typedef enum { i, j, l, o, s, t, z } Type;
const uint8 TYPE_COUNT = 7;

/*
 * 1st key: type index
 * 2nd key: rotation index
 * result: 16 bits, each 1 representing a block in a 4x4 formation
 */
uint16 types[7][4] = {
	{0x0F00, 0x2222, 0x00F0, 0x4444},
	{0x44C0, 0x8E00, 0x6440, 0x0E20},
	{0x4460, 0x0E80, 0xC440, 0x2E00},
	{0xCC00, 0xCC00, 0xCC00, 0xCC00},
	{0x06C0, 0x8C40, 0x6C00, 0x4620},
	{0x0E40, 0x4C40, 0x4E00, 0x4640},
	{0x0C60, 0x4C80, 0xC600, 0x2640}
};

typedef enum { up, right, down, left } Rotation;
const uint8 ROTATION_COUNT = 4;

struct {
	Type type;
	int8 x;
	uint8 y;
	uint8 rotation;
} piece;

uint32 tick = 0;
uint8 courtStartY = 2;
uint8 courtStartX = 3;
uint8 blockWidth = 4;
uint8 courtWidth = 10;
uint8 courtHeight = 14;

uint8 userInput = 0;
Type nextPiece = 3;

char score[] = "00";

bool blocks[10][14];

bool getBlock(int8 x, int8 y) {
	if(x < 0 || x >= courtWidth || y < 0 || y > courtHeight)
		return true;
		
	return blocks[x][y];
}
void setBlock(uint8 x, uint8 y, bool set) {
	blocks[x][y] = set;
}

void drawRectangle(uint8 x, uint8 y, uint8 width, uint8 height){
	
	for(uint8 dx = 0; dx < width; dx++) {
		pixel(x + dx, y, 1);
	}
	
	for(uint8 dx = 0; dx < width; dx++) {
		pixel(x + dx, y + height, 1);
	}
	
	for(uint8 dy = 0; dy < height; dy++) {
		pixel(x, y + dy, 1);
	}
	
	for(uint8 dy = 0; dy < height; dy++) {
		pixel(x + width, y + dy, 1);
	}
	
}

void drawUI() {
	
	drawRectangle(courtStartX-2, courtStartY-2, blockWidth*courtWidth + 2, blockWidth*courtHeight + 2);
	
	drawRectangle(blockWidth*courtWidth + 3, 4, 21, 21);
	
}

void drawBlock(uint8 x, uint8 y) {
	for(uint8 by = 0; by < blockWidth-1; by++){
		for(uint8 bx = 0; bx < blockWidth-1; bx++){
			pixel(courtStartX + x*blockWidth + bx, courtStartY + y*blockWidth + by, 1);
		}
	}
}

void drawBlocks() {
	for(uint8 y = 0; y < courtHeight; y++){
		for(uint8 x = 0; x < courtWidth; x++){
			if(blocks[x][y])
				drawBlock(x,y);
		}
	}
}

void drawNextPiece() {
	uint8 startX = courtWidth+1, startY = 2;
	uint16 blocks = types[nextPiece][up];
	//uint16 blocks = 0x6C00;
	uint8 x = 0, y = 0;
	
	// iterate over each block (bit) in the formation
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		if (blocks & bit) {
			drawBlock(startX + x, startY + y);
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
}

void drawPiece() {
	uint8 x = 0, y = 0;
	uint16 blocks = types[piece.type][piece.rotation];
	
	// iterate over each block (bit) in the formation
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		if (blocks & bit) {
			drawBlock(piece.x + x, piece.y + y);
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
}

int modulo(int x, int y) {
    int result = x;   
    while (result >= y)
        result -= y;

    return result;
}

bool canRotate() {
	uint8 x = 0, y = 0;
	uint16 blocks = types[piece.type][modulo(piece.rotation + 1, ROTATION_COUNT)];
	
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		if (blocks & bit) {
			if (getBlock(piece.x + x, piece.y + y)) {
				return false;
			}
			if (piece.x + x < 0 || piece.x + x > courtWidth) {
				return false;
			}
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
	
	return true;
}

void rotatePiece() {
	if (!canRotate())
		return;
	
	piece.rotation = modulo(piece.rotation + 1, ROTATION_COUNT);
}

bool canMove(int8 dx, int8 dy){
	uint8 x = 0, y = 0;
	uint16 blocks = types[piece.type][piece.rotation];
	
	//loop through individual blocks in the piece
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		
		//if theres a block at this position, check if there is one next to it on the map
		if (blocks & bit) {
			if (getBlock(piece.x + dx + x, piece.y + dy + y)) {
				return false; //the piece cannot move in this direction
			}
			if (piece.x + dx + x < 0 || piece.x + dx + x > courtWidth) {
				return false;
			}
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
	
	return true;
}

void movePiece(int8 dx, int8 dy) {
	if(!canMove(dx, dy))
		return;
	
	piece.x = piece.x + dx;
	piece.y = piece.y + dy;
}

bool hasLanded() {
	uint8 x = 3, y = 3;
	uint16 blocks = types[piece.type][piece.rotation];
	
	// get bottom y coordinate
	for (uint16 bit = 0x0001; bit > 0; bit <<= 1) {
		if (blocks & bit) {
			break;
		}
		
		if (x-- == 0) {
			x = 3;
			y--;
		}
	}
	
	if (piece.y + y + 1 == courtHeight) {
		return true;
	}
	
	x = 0;
	y = 0;
	
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		if (blocks & bit) {
			// check for block one step below
			if (getBlock(piece.x + x, piece.y + y + 1)) {
				return true;
			}
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
	return false;
}

void spawnPiece() {
	piece.type = nextPiece;
	piece.x = 3;
	piece.y = 0;
	piece.rotation = up;
	
	nextPiece = modulo(tick, TYPE_COUNT);
}

void addPieceToBlocks(){
	
	uint16 pBlocks = types[piece.type][piece.rotation];
	uint8 x = 0, y = 0;
	//loop thru piece matrix
	for (uint16 bit = 0x8000; bit > 0; bit >>= 1) {
		if (pBlocks & bit) {
			// add block to board matrix
			setBlock(piece.x + x, piece.y + y, 1);
		}
		
		if (++x == 4) {
			x = 0;
			y++;
		}
	}
}

bool hasFullRow(uint8 row) {
	for (uint8 x = 0; x < courtWidth; x++) {
		if (!getBlock(x, row)) {
			return false;
		}
	}
	return true;
}

void removeRow(uint8 row) {
	for (uint8 y = row; y > 0; y--) {
		for (uint8 x = 0; x < courtWidth; x++) {
			setBlock(x, y, getBlock(x, y - 1));
		}
	}
}

void removeFullRows() {
	for (uint8 row = 0; row < courtHeight; row++) {
		if (hasFullRow(row)) {
			removeRow(row);
		}
	}
}

void resetGame(){
	for(uint8 y=0; y<courtHeight;y++){
		for(uint8 x=0; x<courtHeight;x++){
			setBlock(x,y,0);
		}
	}
}

void incScore() {
	score[1]++;
	if (score[1] > '9') {
		score[1] = '0';
		score[0]++;
		// this probably won't go over 99
	}
}

void resetScore() {
	score[0] = '0';
	score[1] = '0';
}

void printScore() {
	ascii_gotoxy(1, 8);
	ascii_write_string(score);
}

void dropPiece(){
	
		movePiece(0, 1);
		if (hasLanded()) {
			
			if(piece.y < 3){
				resetGame();
				return;
			}
			
			// turn into solid blocks
			addPieceToBlocks();
			
			removeFullRows();
			
			// new piece at the top
			spawnPiece();
			
			incScore();
		}
}

int main(void) {
	init_app();
	
	graphic_initialize();
	graphic_clear_screen();
	clearBuffers();
	
	ascii_init();
	ascii_gotoxy(1, 1);
	ascii_write_string("Let's Play Tetris");
	ascii_gotoxy(2, 1);
	ascii_write_string("Press A to   start");
	
	do {
		userInput = keyb();
	} while (userInput != 0xA);
	
	
	ascii_gotoxy(1, 1);
	ascii_write_string("Score: 00        ");
	ascii_gotoxy(2, 12);
	ascii_write_string("re");
	
	spawnPiece();
	
	while(1) {
		// LOGIC
		tick++;
		
		userInput = keyb();

		switch(userInput){
			case 2:
				rotatePiece();
				break;
			case 4:
				movePiece(-1, 0);
				break;
			case 6:
				movePiece(1, 0);
				break;
			case 8:
				dropPiece();
				break;
			case 0xA:
				resetGame();
				resetScore();
				spawnPiece();
		}
		
		// move down once per second
		if (!modulo(tick, 2)) {
			dropPiece();
		}
		
		// GRAPHICS
		clearBuffer(0);
		
		drawUI();
		drawNextPiece();
		drawBlocks();
		drawPiece();
		
		swapBuffers();
		
		printScore();
		
		delay_milli(50);
	}


	return 0;
}
