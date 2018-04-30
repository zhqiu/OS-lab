#include "common.h"
#include "x86.h"
#include "device.h"  
 
#include "pcb.h"

#define TIMER_PORT 0x40
#define FREQ_8253 1193182
#define HZ 100

void initTimer() {
    int counter = FREQ_8253 / HZ;
    outByte(TIMER_PORT + 3, 0x34);
    outByte(TIMER_PORT + 0, counter % 256);
    outByte(TIMER_PORT + 0, counter / 256);
}

void kEntry(void) {  
	initSerial();// initialize serial port
	initIdt(); // initialize idt
	initIntr(); // initialize 8259a
	initSeg(); // initialize gdt, tss
	uint32_t entry = loadUMain(); // load user program, enter user space 

	initPCB(entry);   // initialize PCB
	initTimer(); // initialize timer 
	enableInterrupt();  
	while(1){                // idle process 
		waitForInterrupt(); 
	//	putScreen('0');
	}
	
	assert(0,0);
}
