#include "pcb.h"
#include "x86.h"

extern TSS tss;

void schedule()
{   
	for (PCB* p = pcb_wait.next; p != &pcb_wait && p->sleepTime>0; p=p->next){
		p->sleepTime--;	  
	}
				
	// first: renew wait list and ready list
	for(PCB* p = pcb_wait.next; p!=&pcb_wait; p=p->next)
	{ 
		if (p->sleepTime == 0){		
			PCB* prev = p->prev;	
			pcb_delete(p);
			p->state = RUNNABLE;
			pcb_add(&pcb_ready, p);
			p=prev;
		}
	} 

	if (current != idle) {   
		current->timeCount--;
		return;
	}  
	// second: check ready list	
	if (current == idle) {          // current process is idle and have other ready process
		if (pcb_ready.next != &pcb_ready){ 
			current = pcb_ready.next;  
		}
	}
	else if (current->timeCount == 0) // current process time out 
	{ 

		if (current->next != &pcb_ready){  // if have other ready process
			current->state=RUNNABLE;
			PCB* newProc = current->next;
			pcb_delete(current);
			pcb_add(&pcb_wait, current);
			current = newProc;
		}
		else                          // no other ready process 
		{	
			pcb_delete(current);
			pcb_add(&pcb_wait, current); 
			current = idle;
		}
	}
	else return; 
	current->state = RUNNING;
	current->timeCount = 10; 
	tss.esp0 = (uint32_t)(current->kStack+sizeof(current->kStack)); // change process
}
