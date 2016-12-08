#include "keypad.h"

void activateRow(int row) {
	switch (row) {
		case 1: portD.odrHigh = 0x10; break;
		case 2: portD.odrHigh = 0x20; break;
		case 3: portD.odrHigh = 0x40; break;
		case 4: portD.odrHigh = 0x80; break;
		case 0: portD.odrHigh = 0x00; break;
	}
}

int readColumn() {
	uint8 c = portD.idrHigh;
	if (c & 0x1) return 1;
	if (c & 0x2) return 2;
	if (c & 0x4) return 3;
	if (c & 0x8) return 4;
	return 0;
}

uint8 keyb(void) {
	uint8 key[] = {1, 2, 3, 0xA, 4, 5, 6, 0xB, 7, 8, 9, 0xC, 0xE, 0x0, 0xF, 0xD};
	
	int col;
	for (int row = 1; row <= 4; row++) {
		activateRow(row);
		
		if ((col = readColumn())) {
			// avaktivera keypaden
			activateRow(0);
			
			// returera tecken utifrån rad och kolumn
			return key[4 * (row - 1) + col - 1];
		}
	}
	
	activateRow(0);
	return 0xFF;
}