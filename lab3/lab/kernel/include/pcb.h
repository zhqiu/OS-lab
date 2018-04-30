#ifndef __PCB_H__
#define __PCB_H__

#include "common.h"
#include "x86.h"
#include "device.h"

#define MAX_PCB 20          // max of PCBs

#define NEW 0          // define some states of a process
#define RUNNABLE 1
#define RUNNING 2
#define SLEEPING 3
#define DEAD 4

struct ProcessTable {  // struct of PCB
	struct TrapFrame* tf; 
	unsigned char kStack[1024];
    int state;
    int timeCount;
    int sleepTime;
    uint32_t pid;
	struct ProcessTable* prev;
    struct ProcessTable* next;
};

typedef struct ProcessTable PCB;

PCB pcb_pool[MAX_PCB];     // build a pool to store all pcbs

//the first node of the following 2 list are NOT belong to any process
PCB pcb_ready;   // point to the list of ready process 
PCB pcb_wait;    // point to the list of waitting process(sleepTime!=0)

PCB* current;     // point to current process 
PCB* idle;        // point to idle process 

static inline void pcb_delete(PCB* p)  // delete a PCB
{
	p->prev->next = p->next;
	p->next->prev = p->prev;
}

/*  add a new PCB to the tail of the list
 *  p must point a new node which must be 'new' before
 */
static inline void pcb_add(PCB* list, PCB* p) 
{
	p->next = list;
	list->prev->next = p;
	p->prev = list->prev;
	list->prev = p;
}

static inline void initPCB(uint32_t entry)  // init state of all PCB
{
	// init pcb_pool
	for (int i=0;i<MAX_PCB;i++){
		pcb_pool[i].state = DEAD;	
	} 

    // initialize the ready list
	pcb_ready.prev = &pcb_ready;
	pcb_ready.next = &pcb_ready;
	
	// initialize the wait list
	pcb_wait.prev = &pcb_wait;
	pcb_wait.next = &pcb_wait;
	
	idle = &pcb_pool[0];         // initialize process idle 
	idle->pid = 0;            
	idle->state = RUNNING;

	PCB* first_proc = &pcb_pool[1];      // make user app be the first process
	first_proc->state = RUNNABLE; 
	first_proc->tf = (void*)(pcb_pool[1].kStack+sizeof(pcb_pool[1].kStack)-sizeof(struct TrapFrame));
	first_proc->tf->ds = USEL(SEG_UDATA);
	first_proc->tf->es = USEL(SEG_UDATA);
	first_proc->tf->ss = USEL(SEG_UDATA);
	first_proc->tf->cs = USEL(SEG_UCODE);
	first_proc->tf->ebp = 0x200000;
	first_proc->tf->esp = 0x200000;
	first_proc->tf->eip = entry;         // entry ??
	first_proc->tf->eflags = 0x202;
	first_proc->timeCount = 10;
	first_proc->sleepTime = 0;
	first_proc->pid = 1;	
	pcb_add(&pcb_ready, first_proc); 

	current = idle;  
}

#endif
