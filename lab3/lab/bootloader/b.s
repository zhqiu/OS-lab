
bootloader.elf:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
    7c00:	fa                   	cli    
    7c01:	e4 92                	in     $0x92,%al
    7c03:	0c 02                	or     $0x2,%al
    7c05:	e6 92                	out    %al,$0x92
    7c07:	0f 01 16             	lgdtl  (%esi)
    7c0a:	58                   	pop    %eax
    7c0b:	7c 0f                	jl     7c1c <start32+0x1>
    7c0d:	20 c0                	and    %al,%al
    7c0f:	66 83 c8 01          	or     $0x1,%ax
    7c13:	0f 22 c0             	mov    %eax,%cr0
    7c16:	ea                   	.byte 0xea
    7c17:	1b 7c 08 00          	sbb    0x0(%eax,%ecx,1),%edi

00007c1b <start32>:
    7c1b:	66 b8 18 00          	mov    $0x18,%ax
    7c1f:	8e e8                	mov    %eax,%gs
    7c21:	66 b8 10 00          	mov    $0x10,%ax
    7c25:	8e d8                	mov    %eax,%ds
    7c27:	8e d0                	mov    %eax,%ss
    7c29:	8e c0                	mov    %eax,%es
    7c2b:	bc 00 80 00 00       	mov    $0x8000,%esp
    7c30:	e9 c3 00 00 00       	jmp    7cf8 <bootMain>
    7c35:	8d 76 00             	lea    0x0(%esi),%esi

00007c38 <gdt>:
	...
    7c40:	ff                   	(bad)  
    7c41:	ff 00                	incl   (%eax)
    7c43:	00 00                	add    %al,(%eax)
    7c45:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c4c:	00 92 cf 00 ff ff    	add    %dl,-0xff31(%edx)
    7c52:	00 80 0b 92 cf 00    	add    %al,0xcf920b(%eax)

00007c58 <gdtDesc>:
    7c58:	1f                   	pop    %ds
    7c59:	00 38                	add    %bh,(%eax)
    7c5b:	7c 00                	jl     7c5d <gdtDesc+0x5>
    7c5d:	00 66 90             	add    %ah,-0x70(%esi)

00007c60 <waitDisk>:
    7c60:	55                   	push   %ebp
    7c61:	89 e5                	mov    %esp,%ebp
    7c63:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c68:	ec                   	in     (%dx),%al
    7c69:	25 c0 00 00 00       	and    $0xc0,%eax
    7c6e:	83 f8 40             	cmp    $0x40,%eax
    7c71:	75 f5                	jne    7c68 <waitDisk+0x8>
    7c73:	5d                   	pop    %ebp
    7c74:	c3                   	ret    
    7c75:	8d 76 00             	lea    0x0(%esi),%esi

00007c78 <readSect>:
    7c78:	55                   	push   %ebp
    7c79:	89 e5                	mov    %esp,%ebp
    7c7b:	53                   	push   %ebx
    7c7c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7c7f:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c84:	ec                   	in     (%dx),%al
    7c85:	25 c0 00 00 00       	and    $0xc0,%eax
    7c8a:	83 f8 40             	cmp    $0x40,%eax
    7c8d:	75 f5                	jne    7c84 <readSect+0xc>
    7c8f:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c94:	b0 01                	mov    $0x1,%al
    7c96:	ee                   	out    %al,(%dx)
    7c97:	ba f3 01 00 00       	mov    $0x1f3,%edx
    7c9c:	88 c8                	mov    %cl,%al
    7c9e:	ee                   	out    %al,(%dx)
    7c9f:	89 c8                	mov    %ecx,%eax
    7ca1:	c1 f8 08             	sar    $0x8,%eax
    7ca4:	ba f4 01 00 00       	mov    $0x1f4,%edx
    7ca9:	ee                   	out    %al,(%dx)
    7caa:	89 c8                	mov    %ecx,%eax
    7cac:	c1 f8 10             	sar    $0x10,%eax
    7caf:	ba f5 01 00 00       	mov    $0x1f5,%edx
    7cb4:	ee                   	out    %al,(%dx)
    7cb5:	89 c8                	mov    %ecx,%eax
    7cb7:	c1 f8 18             	sar    $0x18,%eax
    7cba:	83 c8 e0             	or     $0xffffffe0,%eax
    7cbd:	ba f6 01 00 00       	mov    $0x1f6,%edx
    7cc2:	ee                   	out    %al,(%dx)
    7cc3:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cc8:	b0 20                	mov    $0x20,%al
    7cca:	ee                   	out    %al,(%dx)
    7ccb:	90                   	nop
    7ccc:	ec                   	in     (%dx),%al
    7ccd:	25 c0 00 00 00       	and    $0xc0,%eax
    7cd2:	83 f8 40             	cmp    $0x40,%eax
    7cd5:	75 f5                	jne    7ccc <readSect+0x54>
    7cd7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7cda:	8d 99 00 02 00 00    	lea    0x200(%ecx),%ebx
    7ce0:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7ce5:	8d 76 00             	lea    0x0(%esi),%esi
    7ce8:	ed                   	in     (%dx),%eax
    7ce9:	89 01                	mov    %eax,(%ecx)
    7ceb:	83 c1 04             	add    $0x4,%ecx
    7cee:	39 d9                	cmp    %ebx,%ecx
    7cf0:	75 f6                	jne    7ce8 <readSect+0x70>
    7cf2:	5b                   	pop    %ebx
    7cf3:	5d                   	pop    %ebp
    7cf4:	c3                   	ret    
    7cf5:	8d 76 00             	lea    0x0(%esi),%esi

00007cf8 <bootMain>:
    7cf8:	55                   	push   %ebp
    7cf9:	89 e5                	mov    %esp,%ebp
    7cfb:	57                   	push   %edi
    7cfc:	56                   	push   %esi
    7cfd:	53                   	push   %ebx
    7cfe:	83 ec 1c             	sub    $0x1c,%esp
    7d01:	6a 01                	push   $0x1
    7d03:	68 00 80 00 00       	push   $0x8000
    7d08:	e8 6b ff ff ff       	call   7c78 <readSect>
    7d0d:	a1 1c 80 00 00       	mov    0x801c,%eax
    7d12:	8d b0 00 80 00 00    	lea    0x8000(%eax),%esi
    7d18:	0f b7 3d 2c 80 00 00 	movzwl 0x802c,%edi
    7d1f:	c1 e7 05             	shl    $0x5,%edi
    7d22:	8d 04 3e             	lea    (%esi,%edi,1),%eax
    7d25:	89 45 e0             	mov    %eax,-0x20(%ebp)
    7d28:	5a                   	pop    %edx
    7d29:	59                   	pop    %ecx
    7d2a:	39 c6                	cmp    %eax,%esi
    7d2c:	73 48                	jae    7d76 <bootMain+0x7e>
    7d2e:	66 90                	xchg   %ax,%ax
    7d30:	8b 7e 0c             	mov    0xc(%esi),%edi
    7d33:	8b 46 10             	mov    0x10(%esi),%eax
    7d36:	01 f8                	add    %edi,%eax
    7d38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    7d3b:	8b 56 04             	mov    0x4(%esi),%edx
    7d3e:	c1 ea 09             	shr    $0x9,%edx
    7d41:	8d 5a 01             	lea    0x1(%edx),%ebx
    7d44:	39 c7                	cmp    %eax,%edi
    7d46:	73 19                	jae    7d61 <bootMain+0x69>
    7d48:	83 ec 08             	sub    $0x8,%esp
    7d4b:	53                   	push   %ebx
    7d4c:	57                   	push   %edi
    7d4d:	e8 26 ff ff ff       	call   7c78 <readSect>
    7d52:	81 c7 00 02 00 00    	add    $0x200,%edi
    7d58:	43                   	inc    %ebx
    7d59:	83 c4 10             	add    $0x10,%esp
    7d5c:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
    7d5f:	77 e7                	ja     7d48 <bootMain+0x50>
    7d61:	83 ec 08             	sub    $0x8,%esp
    7d64:	53                   	push   %ebx
    7d65:	57                   	push   %edi
    7d66:	e8 0d ff ff ff       	call   7c78 <readSect>
    7d6b:	83 c6 20             	add    $0x20,%esi
    7d6e:	83 c4 10             	add    $0x10,%esp
    7d71:	39 75 e0             	cmp    %esi,-0x20(%ebp)
    7d74:	77 ba                	ja     7d30 <bootMain+0x38>
    7d76:	ff 15 18 80 00 00    	call   *0x8018
    7d7c:	eb fe                	jmp    7d7c <bootMain+0x84>
