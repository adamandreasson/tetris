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
	/* PORT E */
	portE.moder = 0x55555555; /* all bits outputs */
	portE.otyper = 0x00000000; /* outputs are push/pull */
	portE.ospeedr = 0x55555555; /* medium speed */
	portE.pupdr = 0x55550000; /* inputs are pull up */
}

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
	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
		pixel(x, y, 1);
	}
	
	y = courtStartY + blockWidth*courtHeight;
	for(uint8 x = courtStartX-2; x < courtStartX+blockWidth*courtWidth; x++){
		pixel(x, y, 1);
	}
	
	
	uint8 x = courtStartX-2;
	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
		pixel(x, y, 1);
	}
	
	x = courtStartX + blockWidth*courtWidth;
	for(uint8 y = courtStartY-2; y < courtStartY+blockWidth*courtHeight; y++){
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

int main(void) {
	init_app();
	graphic_initalize();
	graphic_clear_screen();
	clearBuffers();

	setBlock(0,0,true);
	setBlock(1,0,true);
	setBlock(1,1,true);
	setBlock(1,2,true);
	
	while(1){
		clearBuffer(0);
		
		drawCourt();
		drawBlocks();
		
		swapBuffers();
		delay_milli(50);
	}


	return 0;
}
