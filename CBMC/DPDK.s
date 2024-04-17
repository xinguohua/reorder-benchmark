	.arch armv8-a
	.file	"2-DPDK.c"
	.text
.Ltext0:
	.global	global_lock
	.bss
	.align	3
	.type	global_lock, %object
	.size	global_lock, 8
global_lock:
	.zero	8
	.comm	global_node1,16,8
	.comm	global_node2,16,8
	.section	.rodata
	.align	3
.LC0:
	.string	"Thread %d: 1: W locked.\n"
	.align	3
.LC1:
	.string	"Thread %d: 2: W.next \n"
	.text
	.align	2
	.type	rte_mcslock_lock, %function
rte_mcslock_lock:
.LFB0:
	.file 1 "2-DPDK.c"
	.loc 1 44 1
	.cfi_startproc
	stp	x29, x30, [sp, -192]!
	.cfi_def_cfa_offset 192
	.cfi_offset 29, -192
	.cfi_offset 30, -184
	mov	x29, sp
	str	x0, [sp, 40]
	str	x1, [sp, 32]
	str	w2, [sp, 28]
	.loc 1 48 5
	ldr	w1, [sp, 28]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
.LBB2:
	.loc 1 49 5
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 104]
	.loc 1 49 7
	ldr	x0, [sp, 104]
	.loc 1 49 33
	add	x0, x0, 8
	str	x0, [sp, 184]
	.loc 1 49 40
	mov	w0, 1
	str	w0, [sp, 100]
	.loc 1 49 7
	ldr	w0, [sp, 100]
	mov	w1, w0
	ldr	x0, [sp, 184]
	str	w1, [x0]
.LBE2:
.LBB3:
	.loc 1 50 5
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 112]
	.loc 1 50 7
	ldr	x0, [sp, 112]
	.loc 1 50 33
	str	x0, [sp, 176]
	.loc 1 50 40
	str	xzr, [sp, 88]
	.loc 1 50 76
	ldr	x0, [sp, 88]
	mov	x1, x0
	ldr	x0, [sp, 176]
	str	x1, [x0]
.LBE3:
.LBB4:
	.loc 1 58 40
	ldr	x0, [sp, 40]
	str	x0, [sp, 168]
	.loc 1 58 74
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 120]
	.loc 1 58 50
	ldr	x0, [sp, 120]
	str	x0, [sp, 80]
	.loc 1 58 73
	ldr	x0, [sp, 80]
	mov	x2, x0
	ldr	x0, [sp, 168]
.L7:
	ldaxr	x1, [x0]
	stlxr	w3, x2, [x0]
	cbnz	w3, .L7
	mov	x0, x1
	str	x0, [sp, 72]
	.loc 1 58 15
	ldr	x0, [sp, 72]
.LBE4:
	.loc 1 58 10
	str	x0, [sp, 160]
	.loc 1 59 8
	ldr	x0, [sp, 160]
	cmp	x0, 0
	beq	.L6
	.loc 1 72 5
	ldr	w1, [sp, 28]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
.LBB5:
	.loc 1 76 33
	ldr	x0, [sp, 160]
	str	x0, [sp, 152]
	.loc 1 76 61
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 128]
	.loc 1 76 40
	ldr	x0, [sp, 128]
	str	x0, [sp, 64]
	.loc 1 76 7
	ldr	x0, [sp, 64]
	mov	x1, x0
	ldr	x0, [sp, 152]
	str	x1, [x0]
.LBE5:
	.loc 1 84 4
	dmb	ish
	.loc 1 90 11
	b	.L4
.L5:
	.loc 1 91 9
	bl	sched_yield
.L4:
.LBB6:
	.loc 1 90 12
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 136]
	.loc 1 90 14
	ldr	x0, [sp, 136]
	.loc 1 90 40
	add	x0, x0, 8
	str	x0, [sp, 144]
	.loc 1 90 65
	ldr	x0, [sp, 144]
	ldar	w0, [x0]
	str	w0, [sp, 60]
	.loc 1 90 15
	ldr	w0, [sp, 60]
.LBE6:
	.loc 1 90 11
	cmp	w0, 0
	bne	.L5
	b	.L1
.L6:
	.loc 1 63 9
	nop
.L1:
	.loc 1 92 1
	ldp	x29, x30, [sp], 192
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	rte_mcslock_lock, .-rte_mcslock_lock
	.section	.rodata
	.align	3
.LC2:
	.string	"Thread %d: 3: R.next \n"
	.align	3
.LC3:
	.string	"Thread %d: 4: W.locked \n"
	.text
	.align	2
	.type	rte_mcslock_unlock, %function
rte_mcslock_unlock:
.LFB1:
	.loc 1 104 1
	.cfi_startproc
	stp	x29, x30, [sp, -176]!
	.cfi_def_cfa_offset 176
	.cfi_offset 29, -176
	.cfi_offset 30, -168
	mov	x29, sp
	str	x0, [sp, 40]
	str	x1, [sp, 32]
	str	w2, [sp, 28]
	.loc 1 105 5
	ldr	w1, [sp, 28]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
.LBB7:
	.loc 1 107 9
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 104]
	.loc 1 107 11
	ldr	x0, [sp, 104]
	.loc 1 107 37
	str	x0, [sp, 168]
	.loc 1 107 62
	ldr	x0, [sp, 168]
	ldr	x0, [x0]
	str	x0, [sp, 96]
	.loc 1 107 12
	ldr	x0, [sp, 96]
.LBE7:
	.loc 1 107 8
	cmp	x0, 0
	bne	.L9
.LBB8:
.LBB9:
	.loc 1 109 62
	add	x0, sp, 32
	str	x0, [sp, 160]
	.loc 1 109 87
	ldr	x0, [sp, 160]
	ldr	x0, [x0]
	str	x0, [sp, 80]
	.loc 1 109 37
	ldr	x0, [sp, 80]
.LBE9:
	.loc 1 109 24
	str	x0, [sp, 88]
.LBB10:
	.loc 1 112 41
	ldr	x0, [sp, 40]
	str	x0, [sp, 152]
	.loc 1 112 59
	str	xzr, [sp, 72]
	.loc 1 112 106
	ldr	x0, [sp, 72]
	mov	x4, x0
	ldr	x1, [sp, 152]
	add	x0, sp, 88
	ldr	x3, [x0]
.L16:
	ldxr	x2, [x1]
	cmp	x2, x3
	bne	.L17
	stlxr	w5, x4, [x1]
	cbnz	w5, .L16
.L17:
	cset	w1, eq
	cmp	w1, 0
	bne	.L10
	str	x2, [x0]
.L10:
	mov	w0, w1
.LBE10:
	.loc 1 112 12
	cmp	w0, 0
	bne	.L15
	.loc 1 119 8
	dmb	ishld
	.loc 1 124 15
	b	.L13
.L14:
	.loc 1 125 13
	bl	sched_yield
.L13:
.LBB11:
	.loc 1 124 16
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 112]
	.loc 1 124 18
	ldr	x0, [sp, 112]
	.loc 1 124 44
	str	x0, [sp, 144]
	.loc 1 124 69
	ldr	x0, [sp, 144]
	ldr	x0, [x0]
	str	x0, [sp, 64]
	.loc 1 124 19
	ldr	x0, [sp, 64]
.LBE11:
	.loc 1 124 15
	cmp	x0, 0
	beq	.L14
.L9:
.LBE8:
	.loc 1 127 5 discriminator 1
	ldr	w1, [sp, 28]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
.LBB12:
	.loc 1 129 5 discriminator 1
	add	x0, sp, 32
	ldar	x0, [x0]
	str	x0, [sp, 128]
	.loc 1 129 7 discriminator 1
	ldr	x0, [sp, 128]
	.loc 1 129 5 discriminator 1
	ldar	x0, [x0]
	str	x0, [sp, 120]
	.loc 1 129 13 discriminator 1
	ldr	x0, [sp, 120]
	.loc 1 129 33 discriminator 1
	add	x0, x0, 8
	str	x0, [sp, 136]
	.loc 1 129 40 discriminator 1
	str	wzr, [sp, 60]
	.loc 1 129 7 discriminator 1
	ldr	w0, [sp, 60]
	mov	w1, w0
	ldr	x0, [sp, 136]
	stlr	w1, [x0]
	b	.L8
.L15:
.LBE12:
.LBB13:
	.loc 1 113 13
	nop
.L8:
.LBE13:
	.loc 1 130 1
	ldp	x29, x30, [sp], 176
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	rte_mcslock_unlock, .-rte_mcslock_unlock
	.section	.rodata
	.align	3
.LC4:
	.string	"Thread %lu: Lock acquired.\n"
	.text
	.align	2
	.global	thread_lock
	.type	thread_lock, %function
thread_lock:
.LFB2:
	.loc 1 138 30
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	x0, [sp, 24]
	.loc 1 139 20
	ldr	x0, [sp, 24]
	str	x0, [sp, 40]
	.loc 1 142 42
	bl	pthread_self
	.loc 1 142 5
	mov	w2, w0
	ldr	x1, [sp, 40]
	adrp	x0, global_lock
	add	x0, x0, :lo12:global_lock
	bl	rte_mcslock_lock
	.loc 1 143 5
	bl	pthread_self
	mov	x1, x0
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	printf
	.loc 1 144 11
	mov	x0, 0
	.loc 1 145 1
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE2:
	.size	thread_lock, .-thread_lock
	.section	.rodata
	.align	3
.LC5:
	.string	"Thread %lu: Lock released.\n"
	.text
	.align	2
	.global	thread_unlock
	.type	thread_unlock, %function
thread_unlock:
.LFB3:
	.loc 1 148 32
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	x0, [sp, 24]
	.loc 1 149 20
	ldr	x0, [sp, 24]
	str	x0, [sp, 40]
	.loc 1 151 44
	bl	pthread_self
	.loc 1 151 5
	mov	w2, w0
	ldr	x1, [sp, 40]
	adrp	x0, global_lock
	add	x0, x0, :lo12:global_lock
	bl	rte_mcslock_unlock
	.loc 1 152 5
	bl	pthread_self
	mov	x1, x0
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	.loc 1 153 11
	mov	x0, 0
	.loc 1 154 1
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3:
	.size	thread_unlock, .-thread_unlock
	.section	.rodata
	.align	3
.LC6:
	.string	"All threads have finished execution."
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB4:
	.loc 1 157 33
	.cfi_startproc
	stp	x29, x30, [sp, -96]!
	.cfi_def_cfa_offset 96
	.cfi_offset 29, -96
	.cfi_offset 30, -88
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	.loc 1 161 25
	str	wzr, [sp, 68]
	ldr	w0, [sp, 68]
	mov	w1, w0
	adrp	x0, :got:global_node1
	ldr	x0, [x0, #:got_lo12:global_node1]
	add	x0, x0, 8
	stlr	w1, [x0]
	.loc 1 162 23
	str	xzr, [sp, 72]
	ldr	x0, [sp, 72]
	mov	x1, x0
	adrp	x0, :got:global_node1
	ldr	x0, [x0, #:got_lo12:global_node1]
	stlr	x1, [x0]
	.loc 1 163 25
	str	wzr, [sp, 84]
	ldr	w0, [sp, 84]
	mov	w1, w0
	adrp	x0, :got:global_node2
	ldr	x0, [x0, #:got_lo12:global_node2]
	add	x0, x0, 8
	stlr	w1, [x0]
	.loc 1 164 23
	str	xzr, [sp, 88]
	ldr	x0, [sp, 88]
	mov	x1, x0
	adrp	x0, :got:global_node2
	ldr	x0, [x0, #:got_lo12:global_node2]
	stlr	x1, [x0]
	.loc 1 167 5
	add	x4, sp, 56
	adrp	x0, :got:global_node1
	ldr	x3, [x0, #:got_lo12:global_node1]
	adrp	x0, thread_lock
	add	x2, x0, :lo12:thread_lock
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 168 5
	add	x4, sp, 48
	adrp	x0, :got:global_node1
	ldr	x3, [x0, #:got_lo12:global_node1]
	adrp	x0, thread_unlock
	add	x2, x0, :lo12:thread_unlock
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 169 5
	add	x4, sp, 40
	adrp	x0, :got:global_node2
	ldr	x3, [x0, #:got_lo12:global_node2]
	adrp	x0, thread_lock
	add	x2, x0, :lo12:thread_lock
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 170 5
	add	x4, sp, 32
	adrp	x0, :got:global_node2
	ldr	x3, [x0, #:got_lo12:global_node2]
	adrp	x0, thread_unlock
	add	x2, x0, :lo12:thread_unlock
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 173 5
	ldr	x0, [sp, 56]
	mov	x1, 0
	bl	pthread_join
	.loc 1 174 5
	ldr	x0, [sp, 48]
	mov	x1, 0
	bl	pthread_join
	.loc 1 175 5
	ldr	x0, [sp, 40]
	mov	x1, 0
	bl	pthread_join
	.loc 1 176 5
	ldr	x0, [sp, 32]
	mov	x1, 0
	bl	pthread_join
	.loc 1 178 5
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	.loc 1 180 12
	mov	w0, 0
	.loc 1 181 1
	ldp	x29, x30, [sp], 96
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/lib/gcc-cross/aarch64-linux-gnu/9/include/stddef.h"
	.file 3 "/usr/aarch64-linux-gnu/include/bits/types.h"
	.file 4 "/usr/aarch64-linux-gnu/include/time.h"
	.file 5 "/usr/aarch64-linux-gnu/include/bits/pthreadtypes.h"
	.file 6 "/usr/aarch64-linux-gnu/include/bits/types/struct_FILE.h"
	.file 7 "/usr/aarch64-linux-gnu/include/bits/types/FILE.h"
	.file 8 "/usr/aarch64-linux-gnu/include/stdio.h"
	.file 9 "/usr/aarch64-linux-gnu/include/unistd.h"
	.file 10 "/usr/lib/gcc-cross/aarch64-linux-gnu/9/include/stdatomic.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x7b8
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF92
	.byte	0xc
	.4byte	.LASF93
	.4byte	.LASF94
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x7
	.byte	0x4
	.4byte	0x60
	.byte	0xa
	.byte	0x1e
	.byte	0x3
	.4byte	0x60
	.uleb128 0x3
	.4byte	.LASF0
	.byte	0
	.uleb128 0x3
	.4byte	.LASF1
	.byte	0x1
	.uleb128 0x3
	.4byte	.LASF2
	.byte	0x2
	.uleb128 0x3
	.4byte	.LASF3
	.byte	0x3
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x5
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x4
	.byte	0x1
	.byte	0x2
	.4byte	.LASF7
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.4byte	.LASF8
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.4byte	.LASF9
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.4byte	.LASF11
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.4byte	.LASF12
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.4byte	.LASF13
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.4byte	.LASF14
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.4byte	.LASF15
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.4byte	.LASF16
	.uleb128 0x6
	.4byte	.LASF18
	.byte	0x2
	.byte	0xd1
	.byte	0x1b
	.4byte	0x9f
	.uleb128 0x4
	.byte	0x10
	.byte	0x4
	.4byte	.LASF17
	.uleb128 0x6
	.4byte	.LASF19
	.byte	0x3
	.byte	0x98
	.byte	0x12
	.4byte	0x98
	.uleb128 0x6
	.4byte	.LASF20
	.byte	0x3
	.byte	0x99
	.byte	0x12
	.4byte	0x98
	.uleb128 0x7
	.byte	0x8
	.uleb128 0x8
	.byte	0x8
	.4byte	0x6e
	.uleb128 0x9
	.4byte	0xe1
	.4byte	0xf7
	.uleb128 0xa
	.4byte	0x9f
	.byte	0x1
	.byte	0
	.uleb128 0xb
	.4byte	.LASF21
	.byte	0x4
	.byte	0x9f
	.byte	0xe
	.4byte	0xe7
	.uleb128 0xb
	.4byte	.LASF22
	.byte	0x4
	.byte	0xa0
	.byte	0xc
	.4byte	0x91
	.uleb128 0xb
	.4byte	.LASF23
	.byte	0x4
	.byte	0xa1
	.byte	0x11
	.4byte	0x98
	.uleb128 0x6
	.4byte	.LASF24
	.byte	0x5
	.byte	0x1b
	.byte	0x1b
	.4byte	0x9f
	.uleb128 0xc
	.4byte	.LASF62
	.byte	0xd8
	.byte	0x6
	.byte	0x31
	.byte	0x8
	.4byte	0x2ae
	.uleb128 0xd
	.4byte	.LASF25
	.byte	0x6
	.byte	0x33
	.byte	0x7
	.4byte	0x91
	.byte	0
	.uleb128 0xd
	.4byte	.LASF26
	.byte	0x6
	.byte	0x36
	.byte	0x9
	.4byte	0xe1
	.byte	0x8
	.uleb128 0xd
	.4byte	.LASF27
	.byte	0x6
	.byte	0x37
	.byte	0x9
	.4byte	0xe1
	.byte	0x10
	.uleb128 0xd
	.4byte	.LASF28
	.byte	0x6
	.byte	0x38
	.byte	0x9
	.4byte	0xe1
	.byte	0x18
	.uleb128 0xd
	.4byte	.LASF29
	.byte	0x6
	.byte	0x39
	.byte	0x9
	.4byte	0xe1
	.byte	0x20
	.uleb128 0xd
	.4byte	.LASF30
	.byte	0x6
	.byte	0x3a
	.byte	0x9
	.4byte	0xe1
	.byte	0x28
	.uleb128 0xd
	.4byte	.LASF31
	.byte	0x6
	.byte	0x3b
	.byte	0x9
	.4byte	0xe1
	.byte	0x30
	.uleb128 0xd
	.4byte	.LASF32
	.byte	0x6
	.byte	0x3c
	.byte	0x9
	.4byte	0xe1
	.byte	0x38
	.uleb128 0xd
	.4byte	.LASF33
	.byte	0x6
	.byte	0x3d
	.byte	0x9
	.4byte	0xe1
	.byte	0x40
	.uleb128 0xd
	.4byte	.LASF34
	.byte	0x6
	.byte	0x40
	.byte	0x9
	.4byte	0xe1
	.byte	0x48
	.uleb128 0xd
	.4byte	.LASF35
	.byte	0x6
	.byte	0x41
	.byte	0x9
	.4byte	0xe1
	.byte	0x50
	.uleb128 0xd
	.4byte	.LASF36
	.byte	0x6
	.byte	0x42
	.byte	0x9
	.4byte	0xe1
	.byte	0x58
	.uleb128 0xd
	.4byte	.LASF37
	.byte	0x6
	.byte	0x44
	.byte	0x16
	.4byte	0x2c7
	.byte	0x60
	.uleb128 0xd
	.4byte	.LASF38
	.byte	0x6
	.byte	0x46
	.byte	0x14
	.4byte	0x2cd
	.byte	0x68
	.uleb128 0xd
	.4byte	.LASF39
	.byte	0x6
	.byte	0x48
	.byte	0x7
	.4byte	0x91
	.byte	0x70
	.uleb128 0xd
	.4byte	.LASF40
	.byte	0x6
	.byte	0x49
	.byte	0x7
	.4byte	0x91
	.byte	0x74
	.uleb128 0xd
	.4byte	.LASF41
	.byte	0x6
	.byte	0x4a
	.byte	0xb
	.4byte	0xc7
	.byte	0x78
	.uleb128 0xd
	.4byte	.LASF42
	.byte	0x6
	.byte	0x4d
	.byte	0x12
	.4byte	0x8a
	.byte	0x80
	.uleb128 0xd
	.4byte	.LASF43
	.byte	0x6
	.byte	0x4e
	.byte	0xf
	.4byte	0x75
	.byte	0x82
	.uleb128 0xd
	.4byte	.LASF44
	.byte	0x6
	.byte	0x4f
	.byte	0x8
	.4byte	0x2d3
	.byte	0x83
	.uleb128 0xd
	.4byte	.LASF45
	.byte	0x6
	.byte	0x51
	.byte	0xf
	.4byte	0x2e3
	.byte	0x88
	.uleb128 0xd
	.4byte	.LASF46
	.byte	0x6
	.byte	0x59
	.byte	0xd
	.4byte	0xd3
	.byte	0x90
	.uleb128 0xd
	.4byte	.LASF47
	.byte	0x6
	.byte	0x5b
	.byte	0x17
	.4byte	0x2ee
	.byte	0x98
	.uleb128 0xd
	.4byte	.LASF48
	.byte	0x6
	.byte	0x5c
	.byte	0x19
	.4byte	0x2f9
	.byte	0xa0
	.uleb128 0xd
	.4byte	.LASF49
	.byte	0x6
	.byte	0x5d
	.byte	0x14
	.4byte	0x2cd
	.byte	0xa8
	.uleb128 0xd
	.4byte	.LASF50
	.byte	0x6
	.byte	0x5e
	.byte	0x9
	.4byte	0xdf
	.byte	0xb0
	.uleb128 0xd
	.4byte	.LASF51
	.byte	0x6
	.byte	0x5f
	.byte	0xa
	.4byte	0xb4
	.byte	0xb8
	.uleb128 0xd
	.4byte	.LASF52
	.byte	0x6
	.byte	0x60
	.byte	0x7
	.4byte	0x91
	.byte	0xc0
	.uleb128 0xd
	.4byte	.LASF53
	.byte	0x6
	.byte	0x62
	.byte	0x8
	.4byte	0x2ff
	.byte	0xc4
	.byte	0
	.uleb128 0x6
	.4byte	.LASF54
	.byte	0x7
	.byte	0x7
	.byte	0x19
	.4byte	0x127
	.uleb128 0xe
	.4byte	.LASF95
	.byte	0x6
	.byte	0x2b
	.byte	0xe
	.uleb128 0xf
	.4byte	.LASF55
	.uleb128 0x8
	.byte	0x8
	.4byte	0x2c2
	.uleb128 0x8
	.byte	0x8
	.4byte	0x127
	.uleb128 0x9
	.4byte	0x6e
	.4byte	0x2e3
	.uleb128 0xa
	.4byte	0x9f
	.byte	0
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.4byte	0x2ba
	.uleb128 0xf
	.4byte	.LASF56
	.uleb128 0x8
	.byte	0x8
	.4byte	0x2e9
	.uleb128 0xf
	.4byte	.LASF57
	.uleb128 0x8
	.byte	0x8
	.4byte	0x2f4
	.uleb128 0x9
	.4byte	0x6e
	.4byte	0x30f
	.uleb128 0xa
	.4byte	0x9f
	.byte	0x13
	.byte	0
	.uleb128 0xb
	.4byte	.LASF58
	.byte	0x8
	.byte	0x89
	.byte	0xe
	.4byte	0x31b
	.uleb128 0x8
	.byte	0x8
	.4byte	0x2ae
	.uleb128 0xb
	.4byte	.LASF59
	.byte	0x8
	.byte	0x8a
	.byte	0xe
	.4byte	0x31b
	.uleb128 0xb
	.4byte	.LASF60
	.byte	0x8
	.byte	0x8b
	.byte	0xe
	.4byte	0x31b
	.uleb128 0x10
	.4byte	.LASF61
	.byte	0x9
	.2byte	0x21f
	.byte	0xf
	.4byte	0x346
	.uleb128 0x8
	.byte	0x8
	.4byte	0xe1
	.uleb128 0xc
	.4byte	.LASF63
	.byte	0x10
	.byte	0x1
	.byte	0x13
	.byte	0x10
	.4byte	0x374
	.uleb128 0xd
	.4byte	.LASF64
	.byte	0x1
	.byte	0x14
	.byte	0x22
	.4byte	0x374
	.byte	0
	.uleb128 0xd
	.4byte	.LASF65
	.byte	0x1
	.byte	0x15
	.byte	0x10
	.4byte	0x37a
	.byte	0x8
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.4byte	0x34c
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.4byte	.LASF66
	.uleb128 0x6
	.4byte	.LASF67
	.byte	0x1
	.byte	0x16
	.byte	0x3
	.4byte	0x34c
	.uleb128 0x11
	.4byte	.LASF68
	.byte	0x1
	.byte	0x1a
	.byte	0x19
	.4byte	0x3a3
	.uleb128 0x9
	.byte	0x3
	.8byte	global_lock
	.uleb128 0x8
	.byte	0x8
	.4byte	0x381
	.uleb128 0x11
	.4byte	.LASF69
	.byte	0x1
	.byte	0x1d
	.byte	0xf
	.4byte	0x381
	.uleb128 0x9
	.byte	0x3
	.8byte	global_node1
	.uleb128 0x11
	.4byte	.LASF70
	.byte	0x1
	.byte	0x1d
	.byte	0x1d
	.4byte	0x381
	.uleb128 0x9
	.byte	0x3
	.8byte	global_node2
	.uleb128 0x12
	.4byte	.LASF77
	.byte	0x1
	.byte	0x9d
	.byte	0x5
	.4byte	0x91
	.8byte	.LFB4
	.8byte	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x454
	.uleb128 0x13
	.4byte	.LASF71
	.byte	0x1
	.byte	0x9d
	.byte	0xe
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x13
	.4byte	.LASF72
	.byte	0x1
	.byte	0x9d
	.byte	0x1b
	.4byte	0x346
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x14
	.4byte	.LASF73
	.byte	0x1
	.byte	0x9e
	.byte	0xf
	.4byte	0x11b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x14
	.4byte	.LASF74
	.byte	0x1
	.byte	0x9e
	.byte	0x18
	.4byte	0x11b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x14
	.4byte	.LASF75
	.byte	0x1
	.byte	0x9e
	.byte	0x21
	.4byte	0x11b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x14
	.4byte	.LASF76
	.byte	0x1
	.byte	0x9e
	.byte	0x2a
	.4byte	0x11b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.byte	0
	.uleb128 0x12
	.4byte	.LASF78
	.byte	0x1
	.byte	0x94
	.byte	0x7
	.4byte	0xdf
	.8byte	.LFB3
	.8byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x495
	.uleb128 0x15
	.string	"arg"
	.byte	0x1
	.byte	0x94
	.byte	0x1b
	.4byte	0xdf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x14
	.4byte	.LASF79
	.byte	0x1
	.byte	0x95
	.byte	0x14
	.4byte	0x3a3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x12
	.4byte	.LASF80
	.byte	0x1
	.byte	0x8a
	.byte	0x7
	.4byte	0xdf
	.8byte	.LFB2
	.8byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4d6
	.uleb128 0x15
	.string	"arg"
	.byte	0x1
	.byte	0x8a
	.byte	0x19
	.4byte	0xdf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x14
	.4byte	.LASF79
	.byte	0x1
	.byte	0x8b
	.byte	0x14
	.4byte	0x3a3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.byte	0
	.uleb128 0x16
	.4byte	.LASF96
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.8byte	.LFB1
	.8byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x63d
	.uleb128 0x15
	.string	"msl"
	.byte	0x1
	.byte	0x67
	.byte	0x2e
	.4byte	0x63d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x15
	.string	"me"
	.byte	0x1
	.byte	0x67
	.byte	0x4b
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x67
	.byte	0x53
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x17
	.8byte	.LBB7
	.8byte	.LBE7-.LBB7
	.4byte	0x556
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x1
	.byte	0x6b
	.byte	0x25
	.4byte	0x643
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x1
	.byte	0x6b
	.byte	0x2b
	.4byte	0x374
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0
	.uleb128 0x18
	.4byte	.Ldebug_ranges0+0
	.4byte	0x60b
	.uleb128 0x14
	.4byte	.LASF83
	.byte	0x1
	.byte	0x6d
	.byte	0x18
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x17
	.8byte	.LBB9
	.8byte	.LBE9-.LBB9
	.4byte	0x5a4
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x1
	.byte	0x6d
	.byte	0x3e
	.4byte	0x63d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x1
	.byte	0x6d
	.byte	0x44
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.byte	0
	.uleb128 0x17
	.8byte	.LBB10
	.8byte	.LBE10-.LBB10
	.4byte	0x5d9
	.uleb128 0x14
	.4byte	.LASF84
	.byte	0x1
	.byte	0x70
	.byte	0x29
	.4byte	0x63d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x14
	.4byte	.LASF85
	.byte	0x1
	.byte	0x70
	.byte	0x3b
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.byte	0
	.uleb128 0x19
	.8byte	.LBB11
	.8byte	.LBE11-.LBB11
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x1
	.byte	0x7c
	.byte	0x2c
	.4byte	0x643
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x1
	.byte	0x7c
	.byte	0x32
	.4byte	0x374
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.byte	0
	.byte	0
	.uleb128 0x19
	.8byte	.LBB12
	.8byte	.LBE12-.LBB12
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0x1
	.byte	0x81
	.byte	0x21
	.4byte	0x649
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x14
	.4byte	.LASF87
	.byte	0x1
	.byte	0x81
	.byte	0x28
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.byte	0
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.4byte	0x3a3
	.uleb128 0x8
	.byte	0x8
	.4byte	0x374
	.uleb128 0x8
	.byte	0x8
	.4byte	0x91
	.uleb128 0x1a
	.4byte	.LASF97
	.byte	0x1
	.byte	0x2b
	.byte	0x1
	.8byte	.LFB0
	.8byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x15
	.string	"msl"
	.byte	0x1
	.byte	0x2b
	.byte	0x2b
	.4byte	0x63d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x15
	.string	"me"
	.byte	0x1
	.byte	0x2b
	.byte	0x48
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x2b
	.byte	0x50
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -164
	.uleb128 0x14
	.4byte	.LASF88
	.byte	0x1
	.byte	0x2d
	.byte	0x14
	.4byte	0x3a3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x17
	.8byte	.LBB2
	.8byte	.LBE2-.LBB2
	.4byte	0x6da
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0x1
	.byte	0x31
	.byte	0x21
	.4byte	0x649
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x14
	.4byte	.LASF87
	.byte	0x1
	.byte	0x31
	.byte	0x28
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.byte	0
	.uleb128 0x17
	.8byte	.LBB3
	.8byte	.LBE3-.LBB3
	.4byte	0x70f
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0x1
	.byte	0x32
	.byte	0x21
	.4byte	0x643
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x14
	.4byte	.LASF87
	.byte	0x1
	.byte	0x32
	.byte	0x28
	.4byte	0x374
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.byte	0
	.uleb128 0x17
	.8byte	.LBB4
	.8byte	.LBE4-.LBB4
	.4byte	0x754
	.uleb128 0x14
	.4byte	.LASF89
	.byte	0x1
	.byte	0x3a
	.byte	0x28
	.4byte	0x63d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x14
	.4byte	.LASF90
	.byte	0x1
	.byte	0x3a
	.byte	0x32
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x14
	.4byte	.LASF91
	.byte	0x1
	.byte	0x3a
	.byte	0x32
	.4byte	0x3a3
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.byte	0
	.uleb128 0x17
	.8byte	.LBB5
	.8byte	.LBE5-.LBB5
	.4byte	0x789
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0x1
	.byte	0x4c
	.byte	0x21
	.4byte	0x643
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x14
	.4byte	.LASF87
	.byte	0x1
	.byte	0x4c
	.byte	0x28
	.4byte	0x374
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.byte	0
	.uleb128 0x19
	.8byte	.LBB6
	.8byte	.LBE6-.LBB6
	.uleb128 0x14
	.4byte	.LASF81
	.byte	0x1
	.byte	0x5a
	.byte	0x28
	.4byte	0x649
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x14
	.4byte	.LASF82
	.byte	0x1
	.byte	0x5a
	.byte	0x2e
	.4byte	0x91
	.uleb128 0x3
	.byte	0x91
	.sleb128 -132
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.8byte	.LBB8-.Ltext0
	.8byte	.LBE8-.Ltext0
	.8byte	.LBB13-.Ltext0
	.8byte	.LBE13-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF4:
	.string	"memory_order_acq_rel"
.LASF73:
	.string	"thread1"
.LASF74:
	.string	"thread2"
.LASF75:
	.string	"thread3"
.LASF76:
	.string	"thread4"
.LASF36:
	.string	"_IO_save_end"
.LASF11:
	.string	"short int"
.LASF18:
	.string	"size_t"
.LASF46:
	.string	"_offset"
.LASF21:
	.string	"__tzname"
.LASF30:
	.string	"_IO_write_ptr"
.LASF25:
	.string	"_flags"
.LASF72:
	.string	"argv"
.LASF69:
	.string	"global_node1"
.LASF70:
	.string	"global_node2"
.LASF61:
	.string	"__environ"
.LASF37:
	.string	"_markers"
.LASF3:
	.string	"memory_order_release"
.LASF2:
	.string	"memory_order_acquire"
.LASF50:
	.string	"_freeres_buf"
.LASF62:
	.string	"_IO_FILE"
.LASF87:
	.string	"__atomic_store_tmp"
.LASF67:
	.string	"rte_mcslock_t"
.LASF78:
	.string	"thread_unlock"
.LASF91:
	.string	"__atomic_exchange_tmp"
.LASF84:
	.string	"__atomic_compare_exchange_ptr"
.LASF80:
	.string	"thread_lock"
.LASF5:
	.string	"memory_order_seq_cst"
.LASF83:
	.string	"save_me"
.LASF54:
	.string	"FILE"
.LASF60:
	.string	"stderr"
.LASF15:
	.string	"long long int"
.LASF23:
	.string	"__timezone"
.LASF45:
	.string	"_lock"
.LASF22:
	.string	"__daylight"
.LASF13:
	.string	"long int"
.LASF42:
	.string	"_cur_column"
.LASF85:
	.string	"__atomic_compare_exchange_tmp"
.LASF89:
	.string	"__atomic_exchange_ptr"
.LASF79:
	.string	"node"
.LASF68:
	.string	"global_lock"
.LASF66:
	.string	"atomic_int"
.LASF41:
	.string	"_old_offset"
.LASF17:
	.string	"long double"
.LASF59:
	.string	"stdout"
.LASF10:
	.string	"unsigned char"
.LASF71:
	.string	"argc"
.LASF9:
	.string	"signed char"
.LASF47:
	.string	"_codecvt"
.LASF16:
	.string	"long long unsigned int"
.LASF6:
	.string	"unsigned int"
.LASF55:
	.string	"_IO_marker"
.LASF44:
	.string	"_shortbuf"
.LASF82:
	.string	"__atomic_load_tmp"
.LASF86:
	.string	"__atomic_store_ptr"
.LASF29:
	.string	"_IO_write_base"
.LASF53:
	.string	"_unused2"
.LASF26:
	.string	"_IO_read_ptr"
.LASF33:
	.string	"_IO_buf_end"
.LASF90:
	.string	"__atomic_exchange_val"
.LASF8:
	.string	"char"
.LASF65:
	.string	"locked"
.LASF77:
	.string	"main"
.LASF92:
	.string	"GNU C11 9.4.0 -mlittle-endian -mabi=lp64 -g -std=c11 -fasynchronous-unwind-tables -fstack-clash-protection"
.LASF48:
	.string	"_wide_data"
.LASF49:
	.string	"_freeres_list"
.LASF20:
	.string	"__off64_t"
.LASF7:
	.string	"_Bool"
.LASF51:
	.string	"__pad5"
.LASF94:
	.string	"/home/nsas2020/fuzz/targetProcess/reorder/RMEM"
.LASF96:
	.string	"rte_mcslock_unlock"
.LASF12:
	.string	"short unsigned int"
.LASF14:
	.string	"long unsigned int"
.LASF97:
	.string	"rte_mcslock_lock"
.LASF31:
	.string	"_IO_write_end"
.LASF0:
	.string	"memory_order_relaxed"
.LASF39:
	.string	"_fileno"
.LASF63:
	.string	"rte_mcslock"
.LASF38:
	.string	"_chain"
.LASF57:
	.string	"_IO_wide_data"
.LASF52:
	.string	"_mode"
.LASF81:
	.string	"__atomic_load_ptr"
.LASF35:
	.string	"_IO_backup_base"
.LASF58:
	.string	"stdin"
.LASF32:
	.string	"_IO_buf_base"
.LASF19:
	.string	"__off_t"
.LASF40:
	.string	"_flags2"
.LASF56:
	.string	"_IO_codecvt"
.LASF28:
	.string	"_IO_read_base"
.LASF43:
	.string	"_vtable_offset"
.LASF34:
	.string	"_IO_save_base"
.LASF1:
	.string	"memory_order_consume"
.LASF88:
	.string	"prev"
.LASF27:
	.string	"_IO_read_end"
.LASF24:
	.string	"pthread_t"
.LASF93:
	.string	"2-DPDK.c"
.LASF64:
	.string	"next"
.LASF95:
	.string	"_IO_lock_t"
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
