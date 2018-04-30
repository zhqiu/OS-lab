#include "x86.h"
#include "device.h" 

void syscallHandle(struct TrapFrame *tf);

void GProtectFaultHandle(struct TrapFrame *tf);

void irqHandle(struct TrapFrame *tf) {
	/*
	 * 中断处理程序
	 */
	/* Reassign segment register */
	asm volatile("movw %%ax,%%es"::"a"(KSEL(SEG_KDATA)));
	asm volatile("movw %%ax,%%ds"::"a"(KSEL(SEG_KDATA)));
	asm volatile("movw %%ax,%%ss"::"a"(KSEL(SEG_KDATA)));

	switch(tf->irq) {
		case -1:
			break;
		case 0xd:
			GProtectFaultHandle(tf);
			break;
		case 0x80:
			syscallHandle(tf);
			break;
		default:assert(0);
	}
}

void syscallHandle(struct TrapFrame *tf) {
	/* 实现系统调用*/
	switch (tf->eax){
		case 4: putChar((char)tf->ecx);       // write
				tf->eax=1;
				break;
		default: assert(0); break;
	}
}

void GProtectFaultHandle(struct TrapFrame *tf){
	assert(0);
	return;
}
