#include "x86.h"
#include "device.h"
#include "memory.h" 

SegDesc gdt[NR_SEGMENTS];
TSS tss;

#define SECTSIZE 512

void waitDisk(void) {
	while((inByte(0x1F7) & 0xC0) != 0x40); 
}

void readSect(void *dst, int offset) {
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

void initSeg() {
	gdt[SEG_KCODE] = SEG(STA_X | STA_R, 0,       0xffffffff, DPL_KERN);
	gdt[SEG_KDATA] = SEG(STA_W,         0,       0xffffffff, DPL_KERN);
	gdt[SEG_UCODE] = SEG(STA_X | STA_R, 0,       0xffffffff, DPL_USER);
	gdt[SEG_UDATA] = SEG(STA_W,         0,       0xffffffff, DPL_USER);
	gdt[SEG_TSS] = SEG16(STS_T32A,      &tss, sizeof(TSS)-1, DPL_KERN);
	gdt[SEG_TSS].s = 0;

	gdt[SEG_VIDEO] = SEG(STA_W,         0xb8000, 0xffffffff, DPL_USER);	
	
	setGdt(gdt, sizeof(gdt));

	/*
	 * 初始化TSS
	 */
	tss.esp0=0xffffffff;
	tss.ss0=KSEL(SEG_KDATA);
	asm ("ltr %%ax":: "a" (KSEL(SEG_TSS)));

	/*设置正确的段寄存器*/
	asm volatile("movw %%ax, %%es"::"a"(KSEL(SEG_KDATA)));
	asm volatile("movw %%ax, %%ss"::"a"(KSEL(SEG_KDATA)));
	asm volatile("movw %%ax, %%ds"::"a"(KSEL(SEG_KDATA)));  

	lLdt(0);	
}

void enterUserSpace(uint32_t entry) {
	/*
	 * Before enter user space 
	 * you should set the right segment registers here
	 * and use 'iret' to jump to ring3
	 */
	asm volatile("movw %%ax, %%ds"::"a"(USEL(SEG_UDATA)));
	asm volatile("movw %%ax, %%es"::"a"(USEL(SEG_UDATA)));  

	asm volatile("pushfl");                             // eflags 
	asm volatile("pushl %%eax"::"a"(KSEL(SEG_KCODE)));  // cs
    asm volatile("pushl %%eax"::"a"(entry));            // eip 

	asm volatile("iret");
 
}

void loadUMain(void) {
	/*加载用户程序至内存*/ 
	uint8_t buf[4096];
	struct ELFHeader* elf;
	struct ProgramHeader* ph; 
	unsigned char* pa, *pa_end;

	elf=(struct ELFHeader*)buf;
	pa=(unsigned char*)elf;
	pa_end=pa+4096;

	for (int i=0;i<8;i++){   // read 4096 bytes from disk into buf
		readSect(pa, i+201);
		pa+=SECTSIZE;
	}  

	for (int i=0;i<elf->phnum;i++)
	{
		ph=(struct ProgramHeader*)((char*)elf+elf->phoff+i*(elf->phentsize));
		if (ph->type == 1)
		{
			pa=(unsigned char*)ph->paddr;
			pa_end=pa+ph->filesz;
			int i=ph->off/SECTSIZE+201;
			for (; pa<pa_end; pa+=SECTSIZE, i++)
				readSect(pa, i);
			while(pa_end<pa+ph->memsz)
				*pa_end++=0; 
		}
	}
	enterUserSpace(elf->entry);
	
	while(1);
}
