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

#endif // GPIO_H