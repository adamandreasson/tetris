#include "gpio.h"

GPIO portD;
GPIO portE;

void init_gpio(void) {
	portD = *((volatile GPIO*) 0x40020C00);
	portE = *((volatile GPIO*) 0x40021000);
}
