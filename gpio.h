#ifndef GPIO_H
#define GPIO_H

#include "types.h"

typedef struct {
	unsigned int moder;
	unsigned int otyper;
	unsigned int ospeedr;
	unsigned int pupdr;
	union {
		unsigned int idr;
		struct {
			uint8 idrLow;
			uint8 idrHigh;
		};
	};
	union {
		unsigned int odr;
		struct {
			uint8 odrLow;
			uint8 odrHigh;
		};
	};
} GPIO;

#define portD	(*((volatile GPIO*) 0x40020C00))
#define portE	(*((volatile GPIO*) 0x40021000))

#endif // GPIO_H