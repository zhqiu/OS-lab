
uMain.elf:     file format elf32-i386


Disassembly of section .text:

00200000 <uEntry>:
  200000:	55                   	push   %ebp
  200001:	89 e5                	mov    %esp,%ebp
  200003:	53                   	push   %ebx
  200004:	53                   	push   %ebx
  200005:	e8 b2 00 00 00       	call   2000bc <fork>
  20000a:	85 c0                	test   %eax,%eax
  20000c:	75 4a                	jne    200058 <uEntry+0x58>
  20000e:	c7 05 f8 14 20 00 02 	movl   $0x2,0x2014f8
  200015:	00 00 00 
  200018:	b8 02 00 00 00       	mov    $0x2,%eax
  20001d:	bb 08 00 00 00       	mov    $0x8,%ebx
  200022:	eb 05                	jmp    200029 <uEntry+0x29>
  200024:	a1 f8 14 20 00       	mov    0x2014f8,%eax
  200029:	4b                   	dec    %ebx
  20002a:	51                   	push   %ecx
  20002b:	53                   	push   %ebx
  20002c:	50                   	push   %eax
  20002d:	68 84 03 20 00       	push   $0x200384
  200032:	e8 dd 00 00 00       	call   200114 <printf>
  200037:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
  20003e:	e8 b1 00 00 00       	call   2000f4 <sleep>
  200043:	83 c4 10             	add    $0x10,%esp
  200046:	85 db                	test   %ebx,%ebx
  200048:	75 da                	jne    200024 <uEntry+0x24>
  20004a:	e8 89 00 00 00       	call   2000d8 <exit>
  20004f:	31 c0                	xor    %eax,%eax
  200051:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  200054:	c9                   	leave  
  200055:	c3                   	ret    
  200056:	66 90                	xchg   %ax,%ax
  200058:	40                   	inc    %eax
  200059:	74 f4                	je     20004f <uEntry+0x4f>
  20005b:	c7 05 f8 14 20 00 01 	movl   $0x1,0x2014f8
  200062:	00 00 00 
  200065:	b8 01 00 00 00       	mov    $0x1,%eax
  20006a:	bb 08 00 00 00       	mov    $0x8,%ebx
  20006f:	eb 08                	jmp    200079 <uEntry+0x79>
  200071:	8d 76 00             	lea    0x0(%esi),%esi
  200074:	a1 f8 14 20 00       	mov    0x2014f8,%eax
  200079:	4b                   	dec    %ebx
  20007a:	52                   	push   %edx
  20007b:	53                   	push   %ebx
  20007c:	50                   	push   %eax
  20007d:	68 a1 03 20 00       	push   $0x2003a1
  200082:	e8 8d 00 00 00       	call   200114 <printf>
  200087:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
  20008e:	e8 61 00 00 00       	call   2000f4 <sleep>
  200093:	83 c4 10             	add    $0x10,%esp
  200096:	85 db                	test   %ebx,%ebx
  200098:	75 da                	jne    200074 <uEntry+0x74>
  20009a:	eb ae                	jmp    20004a <uEntry+0x4a>

0020009c <syscall>:
  20009c:	55                   	push   %ebp
  20009d:	89 e5                	mov    %esp,%ebp
  20009f:	57                   	push   %edi
  2000a0:	56                   	push   %esi
  2000a1:	53                   	push   %ebx
  2000a2:	8b 55 14             	mov    0x14(%ebp),%edx
  2000a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  2000a8:	8b 45 08             	mov    0x8(%ebp),%eax
  2000ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  2000ae:	8b 75 18             	mov    0x18(%ebp),%esi
  2000b1:	8b 7d 1c             	mov    0x1c(%ebp),%edi
  2000b4:	cd 80                	int    $0x80
  2000b6:	5b                   	pop    %ebx
  2000b7:	5e                   	pop    %esi
  2000b8:	5f                   	pop    %edi
  2000b9:	5d                   	pop    %ebp
  2000ba:	c3                   	ret    
  2000bb:	90                   	nop

002000bc <fork>:
  2000bc:	55                   	push   %ebp
  2000bd:	89 e5                	mov    %esp,%ebp
  2000bf:	57                   	push   %edi
  2000c0:	56                   	push   %esi
  2000c1:	53                   	push   %ebx
  2000c2:	31 d2                	xor    %edx,%edx
  2000c4:	b8 02 00 00 00       	mov    $0x2,%eax
  2000c9:	89 d3                	mov    %edx,%ebx
  2000cb:	89 d1                	mov    %edx,%ecx
  2000cd:	89 d6                	mov    %edx,%esi
  2000cf:	89 d7                	mov    %edx,%edi
  2000d1:	cd 80                	int    $0x80
  2000d3:	5b                   	pop    %ebx
  2000d4:	5e                   	pop    %esi
  2000d5:	5f                   	pop    %edi
  2000d6:	5d                   	pop    %ebp
  2000d7:	c3                   	ret    

002000d8 <exit>:
  2000d8:	55                   	push   %ebp
  2000d9:	89 e5                	mov    %esp,%ebp
  2000db:	57                   	push   %edi
  2000dc:	56                   	push   %esi
  2000dd:	53                   	push   %ebx
  2000de:	31 d2                	xor    %edx,%edx
  2000e0:	b8 01 00 00 00       	mov    $0x1,%eax
  2000e5:	89 d3                	mov    %edx,%ebx
  2000e7:	89 d1                	mov    %edx,%ecx
  2000e9:	89 d6                	mov    %edx,%esi
  2000eb:	89 d7                	mov    %edx,%edi
  2000ed:	cd 80                	int    $0x80
  2000ef:	5b                   	pop    %ebx
  2000f0:	5e                   	pop    %esi
  2000f1:	5f                   	pop    %edi
  2000f2:	5d                   	pop    %ebp
  2000f3:	c3                   	ret    

002000f4 <sleep>:
  2000f4:	55                   	push   %ebp
  2000f5:	89 e5                	mov    %esp,%ebp
  2000f7:	57                   	push   %edi
  2000f8:	56                   	push   %esi
  2000f9:	53                   	push   %ebx
  2000fa:	31 d2                	xor    %edx,%edx
  2000fc:	b8 03 00 00 00       	mov    $0x3,%eax
  200101:	8b 4d 08             	mov    0x8(%ebp),%ecx
  200104:	89 d3                	mov    %edx,%ebx
  200106:	89 d6                	mov    %edx,%esi
  200108:	89 d7                	mov    %edx,%edi
  20010a:	cd 80                	int    $0x80
  20010c:	5b                   	pop    %ebx
  20010d:	5e                   	pop    %esi
  20010e:	5f                   	pop    %edi
  20010f:	5d                   	pop    %ebp
  200110:	c3                   	ret    
  200111:	8d 76 00             	lea    0x0(%esi),%esi

00200114 <printf>:
  200114:	55                   	push   %ebp
  200115:	89 e5                	mov    %esp,%ebp
  200117:	57                   	push   %edi
  200118:	56                   	push   %esi
  200119:	53                   	push   %ebx
  20011a:	83 ec 5c             	sub    $0x5c,%esp
  20011d:	8b 45 08             	mov    0x8(%ebp),%eax
  200120:	85 c0                	test   %eax,%eax
  200122:	0f 84 50 01 00 00    	je     200278 <printf+0x164>
  200128:	0f be 08             	movsbl (%eax),%ecx
  20012b:	84 c9                	test   %cl,%cl
  20012d:	0f 84 45 01 00 00    	je     200278 <printf+0x164>
  200133:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  200136:	89 5d 98             	mov    %ebx,-0x68(%ebp)
  200139:	eb 2e                	jmp    200169 <printf+0x55>
  20013b:	90                   	nop
  20013c:	31 d2                	xor    %edx,%edx
  20013e:	bb 02 00 00 00       	mov    $0x2,%ebx
  200143:	b8 04 00 00 00       	mov    $0x4,%eax
  200148:	89 d6                	mov    %edx,%esi
  20014a:	89 d7                	mov    %edx,%edi
  20014c:	cd 80                	int    $0x80
  20014e:	8b 45 08             	mov    0x8(%ebp),%eax
  200151:	89 45 9c             	mov    %eax,-0x64(%ebp)
  200154:	8b 5d 9c             	mov    -0x64(%ebp),%ebx
  200157:	89 d8                	mov    %ebx,%eax
  200159:	40                   	inc    %eax
  20015a:	89 45 08             	mov    %eax,0x8(%ebp)
  20015d:	0f be 4b 01          	movsbl 0x1(%ebx),%ecx
  200161:	84 c9                	test   %cl,%cl
  200163:	0f 84 0f 01 00 00    	je     200278 <printf+0x164>
  200169:	80 f9 25             	cmp    $0x25,%cl
  20016c:	75 ce                	jne    20013c <printf+0x28>
  20016e:	8d 58 01             	lea    0x1(%eax),%ebx
  200171:	89 5d 9c             	mov    %ebx,-0x64(%ebp)
  200174:	89 5d 08             	mov    %ebx,0x8(%ebp)
  200177:	8a 40 01             	mov    0x1(%eax),%al
  20017a:	3c 64                	cmp    $0x64,%al
  20017c:	0f 84 2a 01 00 00    	je     2002ac <printf+0x198>
  200182:	0f 8e f8 00 00 00    	jle    200280 <printf+0x16c>
  200188:	3c 73                	cmp    $0x73,%al
  20018a:	0f 84 98 01 00 00    	je     200328 <printf+0x214>
  200190:	3c 78                	cmp    $0x78,%al
  200192:	75 5e                	jne    2001f2 <printf+0xde>
  200194:	8b 45 98             	mov    -0x68(%ebp),%eax
  200197:	8b 00                	mov    (%eax),%eax
  200199:	31 d2                	xor    %edx,%edx
  20019b:	90                   	nop
  20019c:	42                   	inc    %edx
  20019d:	89 c1                	mov    %eax,%ecx
  20019f:	83 e1 0f             	and    $0xf,%ecx
  2001a2:	89 4c 95 a0          	mov    %ecx,-0x60(%ebp,%edx,4)
  2001a6:	c1 e8 04             	shr    $0x4,%eax
  2001a9:	75 f1                	jne    20019c <printf+0x88>
  2001ab:	8d 44 95 a0          	lea    -0x60(%ebp,%edx,4),%eax
  2001af:	89 45 a0             	mov    %eax,-0x60(%ebp)
  2001b2:	bb 02 00 00 00       	mov    $0x2,%ebx
  2001b7:	90                   	nop
  2001b8:	8b 45 a0             	mov    -0x60(%ebp),%eax
  2001bb:	8b 08                	mov    (%eax),%ecx
  2001bd:	8d 51 f6             	lea    -0xa(%ecx),%edx
  2001c0:	83 fa 05             	cmp    $0x5,%edx
  2001c3:	0f 87 97 00 00 00    	ja     200260 <printf+0x14c>
  2001c9:	ff 24 95 c0 03 20 00 	jmp    *0x2003c0(,%edx,4)
  2001d0:	31 d2                	xor    %edx,%edx
  2001d2:	b9 65 00 00 00       	mov    $0x65,%ecx
  2001d7:	b8 04 00 00 00       	mov    $0x4,%eax
  2001dc:	89 d6                	mov    %edx,%esi
  2001de:	89 d7                	mov    %edx,%edi
  2001e0:	cd 80                	int    $0x80
  2001e2:	66 90                	xchg   %ax,%ax
  2001e4:	83 6d a0 04          	subl   $0x4,-0x60(%ebp)
  2001e8:	8b 45 a0             	mov    -0x60(%ebp),%eax
  2001eb:	8d 75 a0             	lea    -0x60(%ebp),%esi
  2001ee:	39 f0                	cmp    %esi,%eax
  2001f0:	75 c6                	jne    2001b8 <printf+0xa4>
  2001f2:	83 45 98 04          	addl   $0x4,-0x68(%ebp)
  2001f6:	e9 59 ff ff ff       	jmp    200154 <printf+0x40>
  2001fb:	90                   	nop
  2001fc:	31 d2                	xor    %edx,%edx
  2001fe:	b9 64 00 00 00       	mov    $0x64,%ecx
  200203:	b8 04 00 00 00       	mov    $0x4,%eax
  200208:	89 d6                	mov    %edx,%esi
  20020a:	89 d7                	mov    %edx,%edi
  20020c:	cd 80                	int    $0x80
  20020e:	eb d4                	jmp    2001e4 <printf+0xd0>
  200210:	31 d2                	xor    %edx,%edx
  200212:	b9 63 00 00 00       	mov    $0x63,%ecx
  200217:	b8 04 00 00 00       	mov    $0x4,%eax
  20021c:	89 d6                	mov    %edx,%esi
  20021e:	89 d7                	mov    %edx,%edi
  200220:	cd 80                	int    $0x80
  200222:	eb c0                	jmp    2001e4 <printf+0xd0>
  200224:	31 d2                	xor    %edx,%edx
  200226:	b9 62 00 00 00       	mov    $0x62,%ecx
  20022b:	b8 04 00 00 00       	mov    $0x4,%eax
  200230:	89 d6                	mov    %edx,%esi
  200232:	89 d7                	mov    %edx,%edi
  200234:	cd 80                	int    $0x80
  200236:	eb ac                	jmp    2001e4 <printf+0xd0>
  200238:	31 d2                	xor    %edx,%edx
  20023a:	b9 61 00 00 00       	mov    $0x61,%ecx
  20023f:	b8 04 00 00 00       	mov    $0x4,%eax
  200244:	89 d6                	mov    %edx,%esi
  200246:	89 d7                	mov    %edx,%edi
  200248:	cd 80                	int    $0x80
  20024a:	eb 98                	jmp    2001e4 <printf+0xd0>
  20024c:	31 d2                	xor    %edx,%edx
  20024e:	b9 66 00 00 00       	mov    $0x66,%ecx
  200253:	b8 04 00 00 00       	mov    $0x4,%eax
  200258:	89 d6                	mov    %edx,%esi
  20025a:	89 d7                	mov    %edx,%edi
  20025c:	cd 80                	int    $0x80
  20025e:	eb 84                	jmp    2001e4 <printf+0xd0>
  200260:	83 c1 30             	add    $0x30,%ecx
  200263:	31 d2                	xor    %edx,%edx
  200265:	b8 04 00 00 00       	mov    $0x4,%eax
  20026a:	89 d6                	mov    %edx,%esi
  20026c:	89 d7                	mov    %edx,%edi
  20026e:	cd 80                	int    $0x80
  200270:	e9 6f ff ff ff       	jmp    2001e4 <printf+0xd0>
  200275:	8d 76 00             	lea    0x0(%esi),%esi
  200278:	83 c4 5c             	add    $0x5c,%esp
  20027b:	5b                   	pop    %ebx
  20027c:	5e                   	pop    %esi
  20027d:	5f                   	pop    %edi
  20027e:	5d                   	pop    %ebp
  20027f:	c3                   	ret    
  200280:	3c 63                	cmp    $0x63,%al
  200282:	0f 85 6a ff ff ff    	jne    2001f2 <printf+0xde>
  200288:	8b 45 98             	mov    -0x68(%ebp),%eax
  20028b:	0f be 08             	movsbl (%eax),%ecx
  20028e:	31 d2                	xor    %edx,%edx
  200290:	bb 02 00 00 00       	mov    $0x2,%ebx
  200295:	b8 04 00 00 00       	mov    $0x4,%eax
  20029a:	89 d6                	mov    %edx,%esi
  20029c:	89 d7                	mov    %edx,%edi
  20029e:	cd 80                	int    $0x80
  2002a0:	83 45 98 04          	addl   $0x4,-0x68(%ebp)
  2002a4:	e9 ab fe ff ff       	jmp    200154 <printf+0x40>
  2002a9:	8d 76 00             	lea    0x0(%esi),%esi
  2002ac:	8b 45 98             	mov    -0x68(%ebp),%eax
  2002af:	8b 00                	mov    (%eax),%eax
  2002b1:	89 45 a0             	mov    %eax,-0x60(%ebp)
  2002b4:	85 c0                	test   %eax,%eax
  2002b6:	0f 88 a8 00 00 00    	js     200364 <printf+0x250>
  2002bc:	31 c9                	xor    %ecx,%ecx
  2002be:	bb 0a 00 00 00       	mov    $0xa,%ebx
  2002c3:	be 67 66 66 66       	mov    $0x66666667,%esi
  2002c8:	8b 7d a0             	mov    -0x60(%ebp),%edi
  2002cb:	90                   	nop
  2002cc:	41                   	inc    %ecx
  2002cd:	89 f8                	mov    %edi,%eax
  2002cf:	99                   	cltd   
  2002d0:	f7 fb                	idiv   %ebx
  2002d2:	89 54 8d a0          	mov    %edx,-0x60(%ebp,%ecx,4)
  2002d6:	89 f8                	mov    %edi,%eax
  2002d8:	f7 ee                	imul   %esi
  2002da:	89 d0                	mov    %edx,%eax
  2002dc:	c1 f8 02             	sar    $0x2,%eax
  2002df:	c1 ff 1f             	sar    $0x1f,%edi
  2002e2:	29 f8                	sub    %edi,%eax
  2002e4:	89 c7                	mov    %eax,%edi
  2002e6:	75 e4                	jne    2002cc <printf+0x1b8>
  2002e8:	8d 44 8d a0          	lea    -0x60(%ebp,%ecx,4),%eax
  2002ec:	89 45 a0             	mov    %eax,-0x60(%ebp)
  2002ef:	bb 02 00 00 00       	mov    $0x2,%ebx
  2002f4:	eb 24                	jmp    20031a <printf+0x206>
  2002f6:	66 90                	xchg   %ax,%ax
  2002f8:	83 c1 30             	add    $0x30,%ecx
  2002fb:	31 d2                	xor    %edx,%edx
  2002fd:	b8 04 00 00 00       	mov    $0x4,%eax
  200302:	89 d6                	mov    %edx,%esi
  200304:	89 d7                	mov    %edx,%edi
  200306:	cd 80                	int    $0x80
  200308:	83 6d a0 04          	subl   $0x4,-0x60(%ebp)
  20030c:	8b 45 a0             	mov    -0x60(%ebp),%eax
  20030f:	8d 75 a0             	lea    -0x60(%ebp),%esi
  200312:	39 c6                	cmp    %eax,%esi
  200314:	0f 84 d8 fe ff ff    	je     2001f2 <printf+0xde>
  20031a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  20031d:	8b 08                	mov    (%eax),%ecx
  20031f:	85 c9                	test   %ecx,%ecx
  200321:	79 d5                	jns    2002f8 <printf+0x1e4>
  200323:	f7 d9                	neg    %ecx
  200325:	eb d1                	jmp    2002f8 <printf+0x1e4>
  200327:	90                   	nop
  200328:	8b 45 98             	mov    -0x68(%ebp),%eax
  20032b:	8b 00                	mov    (%eax),%eax
  20032d:	89 45 a0             	mov    %eax,-0x60(%ebp)
  200330:	0f be 08             	movsbl (%eax),%ecx
  200333:	84 c9                	test   %cl,%cl
  200335:	0f 84 b7 fe ff ff    	je     2001f2 <printf+0xde>
  20033b:	bb 02 00 00 00       	mov    $0x2,%ebx
  200340:	ff 45 a0             	incl   -0x60(%ebp)
  200343:	31 d2                	xor    %edx,%edx
  200345:	b8 04 00 00 00       	mov    $0x4,%eax
  20034a:	89 d6                	mov    %edx,%esi
  20034c:	89 d7                	mov    %edx,%edi
  20034e:	cd 80                	int    $0x80
  200350:	8b 45 a0             	mov    -0x60(%ebp),%eax
  200353:	0f be 08             	movsbl (%eax),%ecx
  200356:	84 c9                	test   %cl,%cl
  200358:	75 e6                	jne    200340 <printf+0x22c>
  20035a:	83 45 98 04          	addl   $0x4,-0x68(%ebp)
  20035e:	e9 f1 fd ff ff       	jmp    200154 <printf+0x40>
  200363:	90                   	nop
  200364:	31 d2                	xor    %edx,%edx
  200366:	b9 2d 00 00 00       	mov    $0x2d,%ecx
  20036b:	bb 02 00 00 00       	mov    $0x2,%ebx
  200370:	b8 04 00 00 00       	mov    $0x4,%eax
  200375:	89 d6                	mov    %edx,%esi
  200377:	89 d7                	mov    %edx,%edi
  200379:	cd 80                	int    $0x80
  20037b:	f7 5d a0             	negl   -0x60(%ebp)
  20037e:	e9 39 ff ff ff       	jmp    2002bc <printf+0x1a8>
