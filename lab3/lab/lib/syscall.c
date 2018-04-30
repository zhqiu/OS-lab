#include "lib.h"
#include "types.h"  
/*
 * io lib here
 * 库函数写在这
 */
int32_t syscall(int num, uint32_t a1,uint32_t a2,
		uint32_t a3, uint32_t a4, uint32_t a5)
{
	int32_t ret = 0;

	/* 内嵌汇编 保存 num, a1, a2, a3, a4, a5 至通用寄存器*/
	asm volatile("int $0x80" 
				: "=a"(ret) 
				: "a"(num), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)); // S:%esi D:%edi
		
	return ret;
}

int fork(){
	return syscall(2, 0, 0, 0, 0, 0);
}

void exit(){
	syscall(1, 0, 0, 0, 0, 0);
}

void sleep(int time){
	syscall(3, 0, time, 0, 0 ,0);
}

void printf(const char *format,...){ 
	char* p;            // point to data
	int num;            // store signed number           
	unsigned int u_num; // store unsigned number
	char ch;            // store character
	char* str;          // store string
	int i;

	if (format == 0)
		return;
	else
	{
		p = (char*)&format;	
		p += 4;
	}

	while(*format)
	{	
		if (*format == '%')
		{
			switch(*(++format))  // choose what kind of format to output
			{
				case 'd':	num = *(int*)p;
							if (num < 0){
								syscall(4, 2, '-', 0, 0, 0);
								num = -num;
							}
							i=0;
							int dtmp[20];
							do{
								dtmp[i++]=num%10;
								num /= 10;
							}while(num!=0);
							for (; i>0; i--)
								syscall(4, 2, ((dtmp[i-1]>0)?dtmp[i-1]:-dtmp[i-1])+'0', 0, 0, 0);
							break;
				case 'x':	u_num = *(unsigned int*)p;
							i=0;
							int xtmp[20];
							do{
								xtmp[i++]=u_num%16;
								u_num /= 16;
							}while(u_num!=0);
							while (i>0){
								switch(xtmp[i-1]){
									case 10: syscall(4, 2, 'a', 0, 0, 0); break;
									case 11: syscall(4, 2, 'b', 0, 0, 0); break;
									case 12: syscall(4, 2, 'c', 0, 0, 0); break;
									case 13: syscall(4, 2, 'd', 0, 0, 0); break;
									case 14: syscall(4, 2, 'e', 0, 0, 0); break;
									case 15: syscall(4, 2, 'f', 0, 0, 0); break;
									default: syscall(4, 2, xtmp[i-1]+'0', 0, 0, 0); break;
								}
								i--;
							} 
							break;
				case 's':	str = (char*)(*((char**)p));
							while(*str != '\0'){
								syscall(4, 2, *str++, 0, 0, 0);  
							}
							break;
				case 'c':	ch = *(char*)p;
							syscall(4, 2, ch, 0, 0, 0);  
							break;
			}  
			p+=4;
		}
		else      // output the string directly
			syscall(4, 2, *format, 0, 0, 0);
		format++;
	}
}
