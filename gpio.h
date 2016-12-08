#ifndef GPIO_H
#define GPIO_H

typedef struct {
	unsigned int moder;
	unsigned int otyper;
	unsigned int ospeedr;
	unsigned int pupdr;
	union {
		unsigned int idr;
		struct {
			unsigned char idrLow;
			unsigned char idrHigh;
		};
	};
	union {
		unsigned int odr;
		struct {
			unsigned char odrLow;
			unsigned char odrHigh;
		};
	};
} GPIO;

#define portD	(*((volatile GPIO*) 0x40020C00))
#define portE	(*((volatile GPIO*) 0x40021000))

#endif // GPIO_H