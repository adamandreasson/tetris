#ifndef KEYPAD_H
#define KEYPAD_H

#include "types.h"
#include "gpio.h"

void activateRow(int row);

int readColumn();

uint8 keyb(void);

#endif