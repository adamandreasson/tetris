#ifndef LCD_H
#define LCD_H

#include "types.h"
#include "gpio.h"
#include "delay.h"

void graphic_ctrl_bit_set( uint8 x );

void graphic_ctrl_bit_clear( uint8 x );

void select_controller(uint8 controller);

void graphic_wait_ready(void);

uint8 display_read(uint8 controller);

uint8 graphic_read(uint8 controller);

void graphic_write(uint8 val, uint8 controller);

void graphic_write_command(uint8 commandToWrite, uint8 controller);

void graphic_write_data(uint8 data, uint8 controller);

void graphic_initialize(void);

void graphic_clear_screen(void);

void graphic_draw_screen(void);

void clearBuffer(uint8 val);

void clearBuffers(void);

void swapBuffers(void);

void pixel(int x, int y, int set);

extern uint8 *frontBuffer, *backBuffer;

void ascii_ctrl_bit_set(uint8 x);

void ascii_ctrl_bit_clear(uint8 x);

uint8 ascii_read_controller(void);

uint8 ascii_read_status(void);

uint8 ascii_read_data(void);

void ascii_write_controller(uint8 c);

void ascii_write_cmd(uint8 command);

void ascii_write_data(uint8 data);

void ascii_init(void);

void ascii_gotoxy(int row, int column);

void ascii_write_char(char c);

void ascii_write_string(char *str);

#endif
