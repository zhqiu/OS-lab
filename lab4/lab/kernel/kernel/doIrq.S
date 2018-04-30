.code32

.global irqEmpty
irqEmpty: 
	pushl $-1 // push interrupt vector into kernel
	jmp asmDoIrq

.global irqGProtectFault
irqGProtectFault: 
	pushl $0xd
	jmp asmDoIrq

.global timer
timer:    
	pushl $0x10
	jmp asmDoIrq

.global irqSyscall
irqSyscall: // push dummy error code
	pushl $0x80 // push interrupt vector into kernel stack
	jmp asmDoIrq

.global asmDoIrq
.extern current
asmDoIrq:
	cli
	pushal // push process state into kernel stack
	 
	pushl %ds
	pushl %es	

	pushl %esp
	call irqHandle
	
	movl (current), %eax
	movl (%eax), %esp

//	addl $4, %esp

	popl %es
	popl %ds	
	
	popal
	addl $4, %esp //interrupt vector is on top of kernel stack 
//	sti  
	iret
