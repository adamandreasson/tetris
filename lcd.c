#include "lcd.h"

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

//#define VERTICALSCREEN

void graphic_ctrl_bit_set( uint8 x ) {
	portE.odrLow |= ( ~B_SELECT & x );
}
void graphic_ctrl_bit_clear( uint8 x ) {
	portE.odrLow &= ( ~B_SELECT & ~x );
}
void select_controller(uint8 controller) {
	
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

void graphic_wait_ready(void) {
	uint8 c;
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

uint8 display_read(uint8 controller) {
	uint8 c;
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
uint8 graphic_read(uint8 controller) {
	display_read(controller);
	return display_read(controller);
}

void graphic_write(uint8 val, uint8 controller) {
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

void graphic_write_command(uint8 commandToWrite, uint8 controller) {
	graphic_ctrl_bit_clear( B_E );
	graphic_ctrl_bit_clear( B_DI | B_RW );
	graphic_write(commandToWrite, controller);
}

void graphic_write_data(uint8 data, uint8 controller) {
	graphic_ctrl_bit_clear( B_E );
	graphic_ctrl_bit_set( B_DI );
	graphic_ctrl_bit_clear( B_RW );
	graphic_write(data, controller);
}

void graphic_initialize(void) {
	graphic_ctrl_bit_set( B_E );
	delay_micro(10);
	graphic_ctrl_bit_clear(B_CS1|B_CS2|B_RST|B_E);
	delay_milli( 30 );
	graphic_ctrl_bit_set(B_RST);
	graphic_write_command(LCD_OFF, B_CS1|B_CS2);
	graphic_write_command(LCD_ON, B_CS1|B_CS2);
	graphic_write_command(LCD_DISP_START, B_CS1|B_CS2);
	graphic_write_command(LCD_SET_ADD, B_CS1|B_CS2);
	graphic_write_command(LCD_SET_PAGE, B_CS1|B_CS2);
	select_controller(0);
}

void graphic_clear_screen(void) {
	uint8 i, j;
	for(j = 0; j < 8; j++){
		graphic_write_command(LCD_SET_PAGE | j, B_CS1|B_CS2 );
		graphic_write_command(LCD_SET_ADD | 0, B_CS1|B_CS2 );
		for(i = 0; i <= 63; i++){
			graphic_write_data(0, B_CS1|B_CS2);
		}
	}
}

void graphic_draw_screen(void) {
    unsigned int k = 0;
    bool bUpdateAddr = true;
    for(uint8 c = 0; c < 2; c++) { //	loop	over	both	controllers	(the	two	displays)
		uint8 controller = (c == 0) ? B_CS1 : B_CS2;
		for(uint8 j = 0; j < 8; j++) { //	loop	over	pages
			graphic_write_command(LCD_SET_PAGE | j, controller);
			graphic_write_command(LCD_SET_ADD | 0, controller);
			for(uint8 i = 0; i <= 63; i++, k++) { //	loop	over	addresses
			//	update	display	only	where	it	is	different	from	last	frame
			if(backBuffer[k] != frontBuffer[k]) {
				if(bUpdateAddr)
				graphic_write_command(LCD_SET_ADD | i, controller);
				graphic_write_data(backBuffer[k], controller);
				bUpdateAddr = false; //	Display	hardware	auto-increments	the	address	per	write
			} else
				bUpdateAddr = true; //	No	write	->	we	need	to	update	the
			// x-address	next	write
			}
		}
    }
}

void clearBuffer(uint8 val) {
	for	(int i=0; i<1024; i++)
		backBuffer[i] =	val;	
}

void clearBuffers(void)	{
	for	(int i=0; i<1024; i++)
		backBuffer[i] =	frontBuffer[i] = 0;
}

void swapBuffers(void) {
	graphic_draw_screen();
	uint8* tmp = frontBuffer;
	frontBuffer	= backBuffer;
	backBuffer = tmp;
}
void pixel(int x, int y, int set) {
    if(!set)
		return;
#ifdef VERTICALSCREEN
	int temp = y;
	y = 64-x;
	x = temp;
#endif
		
    if((x > 127) || (x < 0) || (y > 63) || (y < 0))
		return;
	
    uint8 mask = 1 << (y % 8);
    int index = 0;
    if(x >= 64) {
		x -= 64;
		index = 512;
    }
    index += x + (y / 8) * 64;
    backBuffer[index] |= mask;
}

void ascii_ctrl_bit_set(uint8 x) {
	/*Funktion för att 1-ställa bitar */
	uint8 c = portE.odrLow;
	c |= (B_SELECT | x);
	portE.odrLow = c;
}

void ascii_ctrl_bit_clear(uint8 x) {
	uint8 c;
	c = portE.odrLow;
	c = B_SELECT | (c & ~x);
	portE.odrLow = c;
}

uint8 ascii_read_controller(void) {
	ascii_ctrl_bit_set(B_E);
	delay_250ns();
	delay_250ns();
	uint8 c = portE.idrHigh;
	ascii_ctrl_bit_clear(B_E);
	return c;
}

uint8 ascii_read_status(void) {
	portE.moder &= 0x0000FFFF;
	ascii_ctrl_bit_set(0x2);
	ascii_ctrl_bit_clear(0x1);
	uint8 c = ascii_read_controller();
	portE.moder |= 0x55550000;
	return c;
}

uint8 ascii_read_data(void) {
	//RS och RW till 1
	portE.moder &= 0x0000FFFF;
	ascii_ctrl_bit_set(0x3);
	uint8 c = ascii_read_controller();
	portE.moder |= 0x55550000;
	return c;
}

void ascii_write_controller(uint8 c) {
	ascii_ctrl_bit_set(B_E);
	portE.odrHigh = c;
	ascii_ctrl_bit_clear(B_E);
	delay_250ns();
}

void ascii_write_cmd(uint8 command) {
	// sätt RS och RW till 0.
	ascii_ctrl_bit_clear(0x3);
	ascii_write_controller(command);
}

void ascii_command(uint8 command, uint32 microDelay) {
	while (ascii_read_status() & LCD_BUSY);
	delay_micro(8);
	ascii_write_cmd(command);
	delay_micro(microDelay);
}

void ascii_write_data(uint8 data) {
	// RS = 1, RW = 0
	ascii_ctrl_bit_set(0x1);
	ascii_ctrl_bit_clear(0x2);
	ascii_write_controller(data);
}

void ascii_init(void) {
	ascii_command(0x38, 40);	// 2 rader, 5x8 punkters tecken
	ascii_command(0x0E, 40);	// tänd display, tänd markör, konstant visning
	ascii_command(0x04, 40);	// adressering med increment, inget skift av adressbufferten
	ascii_command(0x01, 1540);	// clear display
}

void ascii_gotoxy(int row, int column) {
	uint8 address = column - 1;
	if (row == 2) {
		address += 0x40;
	}
	ascii_command(0x80 | address, 40);
}

void ascii_write_char(char c) {
	while (ascii_read_status() & LCD_BUSY);
	delay_micro(8); //latenstid för kommando
	ascii_write_data(c);
	delay_micro(44);
}

void ascii_write_string(char *str) {
	while (*str) {
		ascii_write_char(*str++);
	}
}
