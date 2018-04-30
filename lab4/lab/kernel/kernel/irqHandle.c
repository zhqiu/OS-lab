#include "x86.h"
#include "device.h" 
#include "common.h" 
#include "string.h"

#include "pcb.h"
typedef struct mySemaphore sem_t;

extern SegDesc gdt[NR_SEGMENTS]; 

static int gdt_index = 7;              // gdt of child process start from 7
              // length of a segment
static int child_pid =2;               // child pid start from 2

static int startPos = 0x400000;
static int segLen = 0x200000;

void syscallHandle(struct TrapFrame *tf);

void GProtectFaultHandle(struct TrapFrame *tf);

void fork_copy(PCB* dst, PCB* src);

void schedule();

void irqHandle(struct TrapFrame *tf) {
	/*
	 * 中断处理程序
	 */
	/* Reassign segment register */
	asm volatile("movw %%ax,%%es"::"a"(KSEL(SEG_KDATA)));
	asm volatile("movw %%ax,%%ds"::"a"(KSEL(SEG_KDATA)));

//	if (current->pid!=0) putScreen(current->pid+'0');   
	current->tf = tf;         // store trapframe
	switch(tf->irq) {
		case -1:
			break;
		case 0xd:
			GProtectFaultHandle(tf);
			break;
		case 0x80:  
			syscallHandle(tf);
			break;
		case 0x10: 
			disableInterrupt();
			schedule();  
			enableInterrupt();
			break;
		default: assert(0,tf->irq);
	}     
}

void syscallHandle(struct TrapFrame *tf) {
	/* 实现系统调用*/
	switch (tf->eax){
		case 4: putChar((char)tf->ecx);       // write
				tf->eax=1;
				break;
		case 2: gdt[gdt_index++] = SEG(STA_X|STA_R, startPos, segLen, DPL_USER); // code
				gdt[gdt_index++] = SEG(STA_W,       startPos, segLen, DPL_USER); // data 
				
				for(int idx=0;idx<segLen;idx++){
					*(char*)(startPos+idx) = *(char*)(startPos-segLen+idx);
				}
				startPos += segLen;
									
				int child_proc_i=19;           // index of child process
				for (int i=0;i<MAX_PCB;i++)
					if(pcb_pool[i].state == DEAD)
						{child_proc_i = i; break;}		 
				fork_copy(&pcb_pool[child_proc_i], current); 
				break;
		case 1: current->state = DEAD;        //exit
				pcb_delete(current);
				current = idle;
				break;
		case 3: current->state = SLEEPING;    // sleep
				current->sleepTime = tf->ecx;
				pcb_delete(current);
				pcb_add(&pcb_wait, current);   // put the sleeping process into wait list 
				current = idle;
				break;
	    case 5: // init
				sem.value = tf->ecx;
				sem.wait = NULL;
				break;
		case 7: // wait (P) 
				sem.value--;
				if (sem.value<0){
					sem.wait = current;
					pcb_delete(current); 
					current=idle;
				} 
				break;
		case 6: // post (V)
				sem.value++;
				if (sem.value<=0){
					pcb_add(&pcb_ready, sem.wait);
					sem.wait = NULL;
				}  
				break; 
		case 8: sem.value=0;  // sem destory  
				sem.wait = NULL; 
				break;
		default: assert(0,tf->eax); break;
	}
}

void GProtectFaultHandle(struct TrapFrame *tf){
	assert(0,0);
	return;
} 

void fork_copy(PCB* dst, PCB* src)
{
	*dst = *src;
	dst->tf = (void*)(dst->kStack+sizeof(dst->kStack)-sizeof(struct TrapFrame));
	dst->tf->eax = 0;
	dst->tf->ss = USEL(gdt_index-1); // point to data segment 
	dst->tf->es = USEL(gdt_index-1);
	dst->tf->ds = USEL(gdt_index-1);
	dst->tf->cs = USEL(gdt_index-2); // point to code segment 
	dst->pid = child_pid++;
	dst->state = RUNNABLE;
	pcb_add(&pcb_ready, dst);
	src->tf->eax = dst->pid;	
}
