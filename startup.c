/*
 * 	startup.c
 *
 */
#include "delay.h"
#include "gpio.h"

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

#define B_E 0x40 /* Enable */
#define B_RST 0x20 /* Reset */
#define B_CS2 0x10 /* Controller Select 2 */
#define B_CS1 8 /* Controller Select 1 */
#define B_SELECT 4 /* ASCII or Graphics select */
#define B_RW 2 /* Read/Write */
#define B_DI 1 /* Data or Instruction : 1 data, 0 Instr */

#define LCD_ON 0x3F /* Display på */
#define LCD_OFF 0x3E /* Av */
#define LCD_SET_ADD 0x40 /* Set X adress (0 – 63) */
#define LCD_SET_PAGE 0xB8 /* Set Y adress (0 – 7) */
#define LCD_DISP_START 0xC0 /* Start adress i display minne */
#define LCD_BUSY 0x80 /* läsa ut busy status. R/W skall vara hög */

typedef unsigned char uint8;
typedef enum { false, true } bool;

static void graphic_ctrl_bit_set( unsigned char x ){
	portE.odrLow |= ( ~B_SELECT & x );
}
static void graphic_ctrl_bit_clear( unsigned char x ){
	portE.odrLow &= ( ~B_SELECT & ~x );
}
static void select_controller(unsigned char controller){
	
	switch(controller){
		case 0:
		graphic_ctrl_bit_clear(B_CS1|B_CS2);
		break;
		case B_CS1 :
		graphic_ctrl_bit_set(B_CS1); graphic_ctrl_bit_clear(B_CS2);
		break;
		case B_CS2 :
		graphic_ctrl_bit_set(B_CS2); graphic_ctrl_bit_clear(B_CS1);
		break;
		case B_CS1|B_CS2 :
		graphic_ctrl_bit_set(B_CS1|B_CS2);
		break;
	}
}

static void graphic_wait_ready(void){
	unsigned char c;
	graphic_ctrl_bit_clear( B_E );
	portE.moder = 0x00005555;
	/* b15-8 are inputs,
	b7-0 are outputs */
	graphic_ctrl_bit_clear( B_DI );
	graphic_ctrl_bit_set( B_RW );
	delay_500ns();
	while(1){
		graphic_ctrl_bit_set( B_E );
		delay_500ns();
		c = portE.idrHigh & 0x80;
		if( c == 0 )break;
		graphic_ctrl_bit_clear( B_E );
		delay_500ns();
	}
	portE.moder = 0x55555555;
	/* all bits outputs */
	graphic_ctrl_bit_set( B_E );
}

static unsigned char display_read(unsigned char controller){
	unsigned char c;
	portE.moder = 0x00005555;
	/* b15-8 are inputs, 7-0 are outputs */
	select_controller( controller );
	graphic_ctrl_bit_clear( B_E );
	graphic_ctrl_bit_set( B_DI | B_RW );
	delay_500ns();
	graphic_ctrl_bit_set( B_E );
	delay_500ns();
	c = portE.idrHigh;
	graphic_ctrl_bit_clear( B_E );
	portE.moder = 0x55555555;
	/* all bits outputs */
	
	if( controller & B_CS1 ){
		select_controller( B_CS1);
		graphic_wait_ready();
	}
	if( controller & B_CS2 ){
		select_controller( B_CS2);
		graphic_wait_ready();
	}
	
	return c;
}

//read display twice because hardware is stupid
static unsigned char graphic_read(unsigned char controller){
	display_read(controller);
	return display_read(controller);
}

static void graphic_write(unsigned char val, unsigned char controller){
	portE.odrHigh = val;
	select_controller( controller );
	delay_500ns();
	graphic_ctrl_bit_set( B_E );
	delay_500ns();
	graphic_ctrl_bit_clear( B_E ); 
	if( controller & B_CS1 ){
		select_controller( B_CS1);
		graphic_wait_ready();
	}
	if( controller & B_CS2 ){
		select_controller( B_CS2);
		graphic_wait_ready();
	}
	portE.odrHigh = 0;
	graphic_ctrl_bit_set( B_E );
	select_controller( 0 );
}

static void graphic_writeCommand(unsigned char commandToWrite, unsigned char controller){
	graphic_ctrl_bit_clear( B_E );
	graphic_ctrl_bit_clear( B_DI | B_RW );
	graphic_write(commandToWrite, controller);
}

static void graphic_writeData(unsigned char data, unsigned char controller){
	graphic_ctrl_bit_clear( B_E );
	graphic_ctrl_bit_set( B_DI );
	graphic_ctrl_bit_clear( B_RW );
	graphic_write(data, controller);
}

void graphic_initalize(void){
	graphic_ctrl_bit_set( B_E );
	delay_micro(10);
	graphic_ctrl_bit_clear(B_CS1|B_CS2|B_RST|B_E);
	delay_milli( 30 );
	graphic_ctrl_bit_set(B_RST);
	graphic_writeCommand(LCD_OFF, B_CS1|B_CS2);
	graphic_writeCommand(LCD_ON, B_CS1|B_CS2);
	graphic_writeCommand(LCD_DISP_START, B_CS1|B_CS2);
	graphic_writeCommand(LCD_SET_ADD, B_CS1|B_CS2);
	graphic_writeCommand(LCD_SET_PAGE, B_CS1|B_CS2);
	select_controller(0);
}

void graphic_clearScreen(void){
	unsigned char i, j;
	for(j = 0; j < 8; j++){
		graphic_writeCommand(LCD_SET_PAGE | j, B_CS1|B_CS2 );
		graphic_writeCommand(LCD_SET_ADD | 0, B_CS1|B_CS2 );
		for(i = 0; i <= 63; i++){
			graphic_writeData(0, B_CS1|B_CS2);
		}
	}
}


unsigned char frameBuffer0[1024], frameBuffer1[1024];		
unsigned char *frontBuffer = frameBuffer0;	
unsigned char *backBuffer =	frameBuffer1;

void graphic_drawScreen(void){
    unsigned int k = 0;
    bool bUpdateAddr = true;
    for(uint8 c = 0; c < 2; c++) { //	loop	over	both	controllers	(the	two	displays)
		uint8 controller = (c == 0) ? B_CS1 : B_CS2;
		for(uint8 j = 0; j < 8; j++) { //	loop	over	pages
			graphic_writeCommand(LCD_SET_PAGE | j, controller);
			graphic_writeCommand(LCD_SET_ADD | 0, controller);
			for(uint8 i = 0; i <= 63; i++, k++) { //	loop	over	addresses
			//	update	display	only	where	it	is	different	from	last	frame
			if(backBuffer[k] != frontBuffer[k]) {
				if(bUpdateAddr)
				graphic_writeCommand(LCD_SET_ADD | i, controller);
				graphic_writeData(backBuffer[k], controller);
				bUpdateAddr = false; //	Display	hardware	auto-increments	the	address	per	write
			} else
				bUpdateAddr = true; //	No	write	->	we	need	to	update	the
			// x-address	next	write
			}
		}
    }
}


void clearBuffer(unsigned char val){	
	for	(int i=0; i<1024; i++)	
		backBuffer[i] =	val;	
}

void clearBuffers()	{
	for	(int i=0; i<1024; i++)	
		backBuffer[i] =	frontBuffer[i] = 0;	
}

void swapBuffers()	{	
	graphic_drawScreen();
	unsigned char* tmp = frontBuffer;
	frontBuffer	= backBuffer;	
	backBuffer = tmp;
}
void pixel(int x, int y, int set){
    if(!set)
		return;
    if((x > 127) || (x < 0) || (y > 63) || (y < 0))
		return;
		
    unsigned char mask = 1 << (y % 8);
    int index = 0;
    if(x >= 64) {
		x -= 64;
		index = 512;
    }
    index += x + (y / 8) * 64;
    backBuffer[index] |= mask;
}

void init_app(void){
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

bool getBlock(uint8 x, uint8 y){
	return blocks[x][y];
}
void setBlock(uint8 x, uint8 y, bool set){
	blocks[x][y] = set;
}

void drawCourt(){
	
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

void drawBlock(uint8 x, uint8 y){
	for(uint8 by = 0; by < blockWidth-1; by++){
		for(uint8 bx = 0; bx < blockWidth-1; bx++){
			pixel(courtStartX + x*blockWidth + bx, courtStartY + y*blockWidth + by, 1);
		}
	}
}

void drawBlocks(){
	for(uint8 y = 0; y < courtHeight; y++){
		for(uint8 x = 0; x < courtWidth; x++){
			if(blocks[x][y])
				drawBlock(x,y);
		}
	}
}

int main(void){
	init_app();
	graphic_initalize();
	graphic_clearScreen();
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
