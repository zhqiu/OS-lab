#include "x86.h"
#include "device.h"

static int line=5, col=-1;    // start output from line 8 col 0

void initSerial(void) {
	outByte(SERIAL_PORT + 1, 0x00);
	outByte(SERIAL_PORT + 3, 0x80);
	outByte(SERIAL_PORT + 0, 0x01);
	outByte(SERIAL_PORT + 1, 0x00);
	outByte(SERIAL_PORT + 3, 0x03);
	outByte(SERIAL_PORT + 2, 0xC7);
	outByte(SERIAL_PORT + 4, 0x0B);
}

static inline int serialIdle(void) {
	return (inByte(SERIAL_PORT + 5) & 0x20) != 0;
}

void putChar(char ch) {

	while (serialIdle() != TRUE);    // serial output
	outByte(SERIAL_PORT, ch);
}

void putScreen(char ch){
// The following code writes char to video memory 
	if (col==79){                 
		line++;
		col=-1;
	}
	int edi=0;
	if (ch == '\n'){
		line++;
		col=-1;
		return;
	}
	else{
		col++;
		edi=(80*line+col)*2;

		asm volatile("movl %%eax, %%edi"::"a"(edi));
		asm volatile("movw $0x30, %ax");
		asm volatile("movw %ax, %gs");	
		asm volatile("movb $0x0c, %ah");
		asm volatile("movb %%bl, %%al"::"b"(ch));
		asm volatile("movw %ax, %gs:(%edi)"); 
	}

}

