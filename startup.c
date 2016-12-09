/*
 * Tetris game lul
 * 
 * GPIO D0-7: Keypad
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
	portD.moder = 0x00005500; // D0-3 inputs, D4-7 outputs
	portD.otyper = 0x000F; // D0-3 open drain, D4-7 push-pull
	portD.pupdr = 0x000000AA; // D0-3 pull-down, D4-7 floating
	
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
	uint8 x;
	uint8 y;
	uint8 rotation;
} piece;

uint32 tick = 0;
uint8 courtStartY = 3;
uint8 courtStartX = 3;
uint8 blockWidth = 4;
uint8 courtWidth = 10;
uint8 courtHeight = 20;
bool blocks[10][20];

bool getBlock(uint8 x, uint8 y) {
	return blocks[x][y];
}
void setBlock(uint8 x, uint8 y, bool set) {
	blocks[x][y] = set;
}

void drawCourt() {
	
	uint8 y = courtStartY-2;
	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++) {
		pixel(x, y, 1);
	}
	
	y = courtStartY + blockWidth*courtHeight;
	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++) {
		pixel(x, y, 1);
	}
	
	
	uint8 x = courtStartX-2;
	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++) {
		pixel(x, y, 1);
	}
	
	x = courtStartX + blockWidth*courtWidth;
	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++) {
		pixel(x, y, 1);
	}
	
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

void rotatePiece() {
	// % operator doesn't work here for whatever reason
	piece.rotation = piece.rotation + 1 == ROTATION_COUNT ? 0 : piece.rotation + 1;
}

void movePiece(uint8 dx, uint8 dy) {
	piece.x = max(1, min(courtWidth, piece.x + dx));
	piece.y = max(1, min(courtHeight, piece.y + dy));
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
	
	if (piece.y + y == courtHeight) {
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
	piece.type = i; // tick % TYPE_COUNT
	piece.x = 3;
	piece.y = 1;
	piece.rotation = up;
}

int modulo(int x, int y) {
    int result = x;   
    while (result >= y)
        result -= y;

    return result;
}

int main(void) {
	init_app();
	graphic_initalize();
	graphic_clear_screen();
	clearBuffers();
	
	spawnPiece();
	
	while(1) {
		// LOGIC
		tick++;
		
		// move down once per second
		if (!modulo(tick, 10)) {
			movePiece(0, 1);
		}
		
		if (hasLanded()) {
			// TODO turn into solid blocks
			
			// new piece at the top
			spawnPiece();
		}
		
		// GRAPHICS
		clearBuffer(0);
		
		drawCourt();
		drawBlocks();
		drawPiece();
		
		swapBuffers();
		
		delay_milli(50);
	}


	return 0;
}
