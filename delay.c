#include "delay.h"

#define SIMULATOR
#define STK_CTRL	((volatile unsigned int *) (0xE000E010))
#define STK_LOAD	((volatile unsigned int *) (0xE000E014))
#define STK_VAL		((volatile unsigned int *) (0xE000E018))

void delay_250ns(void) {
	*STK_CTRL = 0;
#ifdef SIMULATOR
	*STK_LOAD = 16/4 - 1;
#else
	*STK_LOAD = 168/4 - 1;
#endif
	*STK_VAL = 0;
	*STK_CTRL = 5;
	while ((*STK_CTRL & 0x10000) == 0);
	*STK_CTRL = 0;
}

void delay_500ns(void) {
	delay_250ns();
	delay_250ns();
}

void delay_micro(unsigned int us) {
	while(us--) {
		delay_250ns();
		delay_250ns();
		delay_250ns();
		delay_250ns();
	}
}

void delay_milli(unsigned int ms) {
#ifndef SIMULATOR
	while(ms--) {
		delay_micro(1000);
	}
#endif
}