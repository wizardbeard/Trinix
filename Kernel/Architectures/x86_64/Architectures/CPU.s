bits 64
global _CPU_refresh_iretq
global _CPU_iretq
global _CPU_lidt
global _CPU_load_cr3
global _CPU_swapgs
global _CPU_sysretq
global _CPU_syscall_handler


_CPU_refresh_iretq:
	mov RAX, 0x10
	mov DS, AX
	mov ES, AX
	mov FS, AX
	mov GS, AX
	
	mov RDX, RSP
	push RAX
	push RDX
	pushfq
	push 0x08
	
	mov RAX, .r
	push RAX
	iretq
	
	.r:
		ret

_CPU_iretq:
	iretq

_CPU_swapgs:
	swapgs;
	ret;


extern SyscallDispatcher;
_CPU_syscall_handler:
	swapgs;
	mov [GS:0], RSP;
	mov RAX, [GS:8];
	swapgs;
	sti;

	push RAX;
	push RBX;
	push RCX;
	push RDX;
	push RSI;
	push RDI;
	push RBP;
	push R8;
	push R9;
	push R10;
	push R11;
	push R12;
	push R13;
	push R14;
	push R15;
	
	mov RDI, RSP;
	call SyscallDispatcher;

	pop R15;
	pop R14;
	pop R13;
	pop R12;
	pop R11;
	pop R10;
	pop R9;
	pop R8;
	pop RBP;
	pop RDI;
	pop RSI;
	pop RDX;
	pop RCX;
	pop RBX;
	pop RAX;

	cli;
	swapgs;
	mov RSP, [GS:0];
	swapgs;

	o64 sysret