	.file	"2-DPDK.c"
	.text
	.globl	global_lock
	.bss
	.align 8
	.type	global_lock, @object
	.size	global_lock, 8
global_lock:
	.zero	8
	.comm	global_node1,16,16
	.comm	global_node2,16,16
	.section	.rodata
.LC0:
	.string	"Thread %d: 1: W locked.\n"
.LC1:
	.string	"Thread %d: 2: W.next \n"
	.text
	.type	rte_mcslock_lock, @function
rte_mcslock_lock:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movq	%rdi, -152(%rbp)
	movq	%rsi, -160(%rbp)
	movl	%edx, -164(%rbp)
	movl	-164(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-160(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -8(%rbp)
	movl	$1, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	movq	-160(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	$0, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-152(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-160(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	xchgq	(%rax), %rdx
	movq	%rdx, %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L6
	movl	-164(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-160(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
	jmp	.L4
.L5:
	call	sched_yield@PLT
.L4:
	movq	-160(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -132(%rbp)
	movl	-132(%rbp), %eax
	testl	%eax, %eax
	jne	.L5
	jmp	.L1
.L6:
	nop
.L1:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	rte_mcslock_lock, .-rte_mcslock_lock
	.section	.rodata
.LC2:
	.string	"Thread %d: 3: R.next \n"
.LC3:
	.string	"Thread %d: 4: W.locked \n"
	.text
	.type	rte_mcslock_unlock, @function
rte_mcslock_unlock:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movq	%rdi, -136(%rbp)
	movq	%rsi, -144(%rbp)
	movl	%edx, -148(%rbp)
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-144(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	testq	%rax, %rax
	jne	.L8
	leaq	-144(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rax, %rcx
	movq	-24(%rbp), %rsi
	leaq	-88(%rbp), %rdx
	movq	(%rdx), %rax
	lock cmpxchgq	%rcx, (%rsi)
	movq	%rax, %rcx
	sete	%al
	testb	%al, %al
	jne	.L9
	movq	%rcx, (%rdx)
.L9:
	testb	%al, %al
	jne	.L14
	jmp	.L12
.L13:
	call	sched_yield@PLT
.L12:
	movq	-144(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	testq	%rax, %rax
	je	.L13
.L8:
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-144(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	addq	$8, %rax
	movq	%rax, -40(%rbp)
	movl	$0, -116(%rbp)
	movl	-116(%rbp), %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L7
.L14:
	nop
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	rte_mcslock_unlock, .-rte_mcslock_unlock
	.section	.rodata
.LC4:
	.string	"Thread %lu: Lock acquired.\n"
	.text
	.globl	thread_lock
	.type	thread_lock, @function
thread_lock:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	call	pthread_self@PLT
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	global_lock(%rip), %rdi
	call	rte_mcslock_lock
	call	pthread_self@PLT
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	thread_lock, .-thread_lock
	.section	.rodata
.LC5:
	.string	"Thread %lu: Lock released.\n"
	.text
	.globl	thread_unlock
	.type	thread_unlock, @function
thread_unlock:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	call	pthread_self@PLT
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	global_lock(%rip), %rdi
	call	rte_mcslock_unlock
	call	pthread_self@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	thread_unlock, .-thread_unlock
	.section	.rodata
	.align 8
.LC6:
	.string	"All threads have finished execution.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	$0, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, 8+global_node1(%rip)
	mfence
	movq	$0, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, global_node1(%rip)
	mfence
	movl	$0, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, 8+global_node2(%rip)
	mfence
	movq	$0, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, global_node2(%rip)
	mfence
	leaq	-40(%rbp), %rax
	leaq	global_node1(%rip), %rcx
	leaq	thread_lock(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	leaq	-48(%rbp), %rax
	leaq	global_node1(%rip), %rcx
	leaq	thread_unlock(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	leaq	-56(%rbp), %rax
	leaq	global_node2(%rip), %rcx
	leaq	thread_lock(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	leaq	-64(%rbp), %rax
	leaq	global_node2(%rip), %rcx
	leaq	thread_unlock(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movq	-40(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movq	-48(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movq	-56(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movq	-64(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
