#include "boot.h" 

#define SECTSIZE 512

void bootMain(void) {
	/* 加载内核至内存，并跳转执行 */
	struct ELFHeader* elf;                   // start of elf file
	struct ProgramHeader* ph;
	struct ProgramHeader *ph_end;            // start of ProgramHeader
	unsigned char* pa, *pa_end;              // physical addr of a segment

	elf=(struct ELFHeader*)0x8000;           // load elf file to 0x8000 in memory
	readSect((unsigned char*)elf, 1);        // load sector 1 on disk to memory

	/* load each program segment */ 
	ph = (struct ProgramHeader*)((char*)elf + elf->phoff);
	ph_end = ph + elf->phnum;
	while (ph<ph_end)
	{ 
		pa = (unsigned char*)ph->paddr;                 // load to this physical addr
		pa_end = pa + ph->filesz;                    // end of the physical addr
		int i;
		for (i=ph->off/SECTSIZE+1; pa<pa_end; pa+=SECTSIZE, i++)
			readSect(pa, i);
		readSect(pa, i); 
		ph++; 
	}

	// execute the kernel
	((void(*)(void))elf->entry)();

	while(1);
 
}

void waitDisk(void) { // waiting for disk
	while((inByte(0x1F7) & 0xC0) != 0x40);
}

void readSect(void *dst, int offset) { // reading a sector of disk
	int i;
	waitDisk();
	outByte(0x1F2, 1);
	outByte(0x1F3, offset);
	outByte(0x1F4, offset >> 8);
	outByte(0x1F5, offset >> 16);
	outByte(0x1F6, (offset >> 24) | 0xE0);
	outByte(0x1F7, 0x20);

	waitDisk();
	for (i = 0; i < SECTSIZE / 4; i ++) {
		((int *)dst)[i] = inLong(0x1F0);
	}
}
