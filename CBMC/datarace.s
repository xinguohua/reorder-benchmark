	.arch armv8-a
	.file	"0-datarace.cpp"
	.text
.Ltext0:
	.global	data
	.bss
	.align	2
	.type	data, %object
	.size	data, 4
data:
	.zero	4
	.global	flag
	.align	2
	.type	flag, %object
	.size	flag, 4
flag:
	.zero	4
	.global	str
	.align	3
	.type	str, %object
	.size	str, 50
str:
	.zero	50
	.text
	.align	2
	.global	_Z13writer_threadPv
	.type	_Z13writer_threadPv, %function
_Z13writer_threadPv:
.LFB9:
	.file 1 "0-datarace.cpp"
	.loc 1 21 33
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	.loc 1 22 10
	adrp	x0, data
	add	x0, x0, :lo12:data
	mov	w1, 42
	str	w1, [x0]
	.loc 1 23 10
	adrp	x0, flag
	add	x0, x0, :lo12:flag
	mov	w1, 1
	str	w1, [x0]
	.loc 1 24 11
	mov	x0, 0
	.loc 1 25 1
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE9:
	.size	_Z13writer_threadPv, .-_Z13writer_threadPv
	.section	.rodata
	.align	3
.LC0:
	.string	"Data happen %d"
	.align	3
.LC1:
	.string	"void* reader_thread(void*)"
	.align	3
.LC2:
	.string	"0-datarace.cpp"
	.align	3
.LC3:
	.string	"data == 42"
	.text
	.align	2
	.global	_Z13reader_threadPv
	.type	_Z13reader_threadPv, %function
_Z13reader_threadPv:
.LFB10:
	.loc 1 28 33
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	x0, [sp, 24]
	.loc 1 31 14
	adrp	x0, flag
	add	x0, x0, :lo12:flag
	ldr	w0, [x0]
	.loc 1 31 5
	cmp	w0, 1
	bne	.L4
	.loc 1 32 15
	adrp	x0, data
	add	x0, x0, :lo12:data
	ldr	w0, [x0]
	mov	w2, w0
	adrp	x0, .LC0
	add	x1, x0, :lo12:.LC0
	adrp	x0, str
	add	x0, x0, :lo12:str
	bl	printf
	.loc 1 33 13
	adrp	x0, data
	add	x0, x0, :lo12:data
	ldr	w0, [x0]
	.loc 1 33 10
	cmp	w0, 42
	beq	.L4
	.loc 1 33 37 discriminator 1
	adrp	x0, .LC1
	add	x3, x0, :lo12:.LC1
	mov	w2, 33
	adrp	x0, .LC2
	add	x1, x0, :lo12:.LC2
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	__assert_fail
.L4:
	.loc 1 35 11
	mov	x0, 0
	.loc 1 36 1
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE10:
	.size	_Z13reader_threadPv, .-_Z13reader_threadPv
	.section	.rodata
	.align	3
.LC4:
	.string	"Data happen 0"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB11:
	.loc 1 38 12
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	.loc 1 38 12
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, #:got_lo12:__stack_chk_guard]
	ldr	x1, [x0]
	str	x1, [sp, 40]
	mov	x1,0
	.loc 1 40 9
	str	wzr, [sp, 20]
	.loc 1 43 19
	add	x4, sp, 24
	mov	x3, 0
	adrp	x0, _Z13writer_threadPv
	add	x2, x0, :lo12:_Z13writer_threadPv
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 44 19
	add	x4, sp, 32
	mov	x3, 0
	adrp	x0, _Z13reader_threadPv
	add	x2, x0, :lo12:_Z13reader_threadPv
	mov	x1, 0
	mov	x0, x4
	bl	pthread_create
	.loc 1 47 17
	ldr	x0, [sp, 24]
	mov	x1, 0
	bl	pthread_join
	.loc 1 48 17
	ldr	x0, [sp, 32]
	mov	x1, 0
	bl	pthread_join
	.loc 1 50 15
	adrp	x0, .LC4
	add	x1, x0, :lo12:.LC4
	adrp	x0, str
	add	x0, x0, :lo12:str
	bl	strcmp
	.loc 1 50 5
	cmp	w0, 0
	bne	.L7
	.loc 1 51 12
	ldr	w0, [sp, 20]
	add	w0, w0, 1
	str	w0, [sp, 20]
	.loc 1 52 15
	adrp	x0, str
	add	x0, x0, :lo12:str
	bl	puts
.L7:
	.loc 1 54 10
	adrp	x0, data
	add	x0, x0, :lo12:data
	str	wzr, [x0]
	.loc 1 55 11
	mov	x2, 50
	mov	w1, 0
	adrp	x0, str
	add	x0, x0, :lo12:str
	bl	memset
	.loc 1 56 12
	mov	w0, 0
	mov	w1, w0
	.loc 1 57 1
	adrp	x0, :got:__stack_chk_guard
	ldr	x0, [x0, #:got_lo12:__stack_chk_guard]
	ldr	x2, [sp, 40]
	ldr	x3, [x0]
	subs	x2, x2, x3
	mov	x3, 0
	beq	.L9
	bl	__stack_chk_fail
.L9:
	mov	w0, w1
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/lib/gcc-cross/aarch64-linux-gnu/9/include/stddef.h"
	.file 3 "/usr/aarch64-linux-gnu/include/bits/types.h"
	.file 4 "/usr/aarch64-linux-gnu/include/bits/types/struct_FILE.h"
	.file 5 "/usr/aarch64-linux-gnu/include/bits/types/FILE.h"
	.file 6 "/usr/aarch64-linux-gnu/include/stdio.h"
	.file 7 "/usr/aarch64-linux-gnu/include/bits/sys_errlist.h"
	.file 8 "/usr/aarch64-linux-gnu/include/time.h"
	.file 9 "/usr/aarch64-linux-gnu/include/bits/pthreadtypes.h"
	.file 10 "/usr/aarch64-linux-gnu/include/pthread.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x536
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.4byte	.LASF85
	.byte	0x4
	.4byte	.LASF86
	.4byte	.LASF87
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x1b
	.4byte	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.4byte	.LASF8
	.byte	0x3
	.byte	0x98
	.byte	0x12
	.4byte	0x6c
	.uleb128 0x2
	.4byte	.LASF9
	.byte	0x3
	.byte	0x99
	.byte	0x12
	.4byte	0x6c
	.uleb128 0x6
	.byte	0x8
	.4byte	0x91
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.uleb128 0x7
	.4byte	0x91
	.uleb128 0x8
	.4byte	.LASF88
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.4byte	0x224
	.uleb128 0x9
	.4byte	.LASF11
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.4byte	0x42
	.byte	0
	.uleb128 0x9
	.4byte	.LASF12
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.4byte	0x8b
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF13
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.4byte	0x8b
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF14
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.4byte	0x8b
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF15
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.4byte	0x8b
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.4byte	0x8b
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF17
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.4byte	0x8b
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF18
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.4byte	0x8b
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF19
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.4byte	0x8b
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF20
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.4byte	0x8b
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF21
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.4byte	0x8b
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF22
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.4byte	0x8b
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF23
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.4byte	0x23d
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF24
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.4byte	0x243
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF25
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.4byte	0x42
	.byte	0x70
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.4byte	0x42
	.byte	0x74
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.4byte	0x73
	.byte	0x78
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.4byte	0x50
	.byte	0x80
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.4byte	0x5e
	.byte	0x82
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.4byte	0x249
	.byte	0x83
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.4byte	0x259
	.byte	0x88
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.4byte	0x7f
	.byte	0x90
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.4byte	0x264
	.byte	0x98
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.4byte	0x26f
	.byte	0xa0
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.4byte	0x243
	.byte	0xa8
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.4byte	0x40
	.byte	0xb0
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.4byte	0x2d
	.byte	0xb8
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.4byte	0x42
	.byte	0xc0
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.4byte	0x275
	.byte	0xc4
	.byte	0
	.uleb128 0x2
	.4byte	.LASF40
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.4byte	0x9d
	.uleb128 0xa
	.4byte	.LASF89
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.4byte	.LASF41
	.uleb128 0x6
	.byte	0x8
	.4byte	0x238
	.uleb128 0x6
	.byte	0x8
	.4byte	0x9d
	.uleb128 0xc
	.4byte	0x91
	.4byte	0x259
	.uleb128 0xd
	.4byte	0x39
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x230
	.uleb128 0xb
	.4byte	.LASF42
	.uleb128 0x6
	.byte	0x8
	.4byte	0x25f
	.uleb128 0xb
	.4byte	.LASF43
	.uleb128 0x6
	.byte	0x8
	.4byte	0x26a
	.uleb128 0xc
	.4byte	0x91
	.4byte	0x285
	.uleb128 0xd
	.4byte	0x39
	.byte	0x13
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.4byte	0x98
	.uleb128 0x7
	.4byte	0x285
	.uleb128 0xe
	.4byte	.LASF44
	.byte	0x6
	.byte	0x89
	.byte	0xe
	.4byte	0x29c
	.uleb128 0x6
	.byte	0x8
	.4byte	0x224
	.uleb128 0xe
	.4byte	.LASF45
	.byte	0x6
	.byte	0x8a
	.byte	0xe
	.4byte	0x29c
	.uleb128 0xe
	.4byte	.LASF46
	.byte	0x6
	.byte	0x8b
	.byte	0xe
	.4byte	0x29c
	.uleb128 0xe
	.4byte	.LASF47
	.byte	0x7
	.byte	0x1a
	.byte	0xc
	.4byte	0x42
	.uleb128 0xc
	.4byte	0x28b
	.4byte	0x2d1
	.uleb128 0xf
	.byte	0
	.uleb128 0xe
	.4byte	.LASF48
	.byte	0x7
	.byte	0x1b
	.byte	0x1a
	.4byte	0x2c6
	.uleb128 0xe
	.4byte	.LASF49
	.byte	0x7
	.byte	0x1e
	.byte	0xc
	.4byte	0x42
	.uleb128 0xe
	.4byte	.LASF50
	.byte	0x7
	.byte	0x1f
	.byte	0x1a
	.4byte	0x2c6
	.uleb128 0xc
	.4byte	0x8b
	.4byte	0x305
	.uleb128 0xd
	.4byte	0x39
	.byte	0x1
	.byte	0
	.uleb128 0xe
	.4byte	.LASF51
	.byte	0x8
	.byte	0x9f
	.byte	0xe
	.4byte	0x2f5
	.uleb128 0xe
	.4byte	.LASF52
	.byte	0x8
	.byte	0xa0
	.byte	0xc
	.4byte	0x42
	.uleb128 0xe
	.4byte	.LASF53
	.byte	0x8
	.byte	0xa1
	.byte	0x11
	.4byte	0x6c
	.uleb128 0xe
	.4byte	.LASF54
	.byte	0x8
	.byte	0xa6
	.byte	0xe
	.4byte	0x2f5
	.uleb128 0xe
	.4byte	.LASF55
	.byte	0x8
	.byte	0xae
	.byte	0xc
	.4byte	0x42
	.uleb128 0xe
	.4byte	.LASF56
	.byte	0x8
	.byte	0xaf
	.byte	0x11
	.4byte	0x6c
	.uleb128 0x10
	.4byte	.LASF57
	.byte	0x8
	.2byte	0x112
	.byte	0xc
	.4byte	0x42
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF58
	.uleb128 0x2
	.4byte	.LASF59
	.byte	0x9
	.byte	0x1b
	.byte	0x1b
	.4byte	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF60
	.uleb128 0x11
	.byte	0x7
	.byte	0x4
	.4byte	0x57
	.byte	0xa
	.byte	0x2c
	.byte	0x1
	.4byte	0x3b9
	.uleb128 0x12
	.4byte	.LASF61
	.byte	0
	.uleb128 0x12
	.4byte	.LASF62
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF63
	.byte	0x2
	.uleb128 0x12
	.4byte	.LASF64
	.byte	0x3
	.uleb128 0x12
	.4byte	.LASF65
	.byte	0
	.uleb128 0x12
	.4byte	.LASF66
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF67
	.byte	0x2
	.uleb128 0x12
	.4byte	.LASF68
	.byte	0
	.uleb128 0x12
	.4byte	.LASF69
	.byte	0
	.byte	0
	.uleb128 0x11
	.byte	0x7
	.byte	0x4
	.4byte	0x57
	.byte	0xa
	.byte	0x42
	.byte	0x1
	.4byte	0x3e0
	.uleb128 0x12
	.4byte	.LASF70
	.byte	0
	.uleb128 0x12
	.4byte	.LASF71
	.byte	0
	.uleb128 0x12
	.4byte	.LASF72
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF73
	.byte	0x1
	.byte	0
	.uleb128 0x11
	.byte	0x7
	.byte	0x4
	.4byte	0x57
	.byte	0xa
	.byte	0x65
	.byte	0x1
	.4byte	0x407
	.uleb128 0x12
	.4byte	.LASF74
	.byte	0
	.uleb128 0x12
	.4byte	.LASF75
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF76
	.byte	0x2
	.uleb128 0x12
	.4byte	.LASF77
	.byte	0
	.byte	0
	.uleb128 0x13
	.4byte	.LASF78
	.byte	0x1
	.byte	0xe
	.byte	0x5
	.4byte	0x42
	.uleb128 0x9
	.byte	0x3
	.8byte	data
	.uleb128 0x13
	.4byte	.LASF79
	.byte	0x1
	.byte	0xf
	.byte	0x5
	.4byte	0x42
	.uleb128 0x9
	.byte	0x3
	.8byte	flag
	.uleb128 0xc
	.4byte	0x91
	.4byte	0x443
	.uleb128 0xd
	.4byte	0x39
	.byte	0x31
	.byte	0
	.uleb128 0x14
	.string	"str"
	.byte	0x1
	.byte	0x10
	.byte	0x6
	.4byte	0x433
	.uleb128 0x9
	.byte	0x3
	.8byte	str
	.uleb128 0x15
	.4byte	.LASF82
	.byte	0x1
	.byte	0x26
	.byte	0x5
	.4byte	0x42
	.8byte	.LFB11
	.8byte	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4a9
	.uleb128 0x16
	.4byte	.LASF80
	.byte	0x1
	.byte	0x27
	.byte	0xf
	.4byte	0x361
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x16
	.4byte	.LASF81
	.byte	0x1
	.byte	0x27
	.byte	0x17
	.4byte	0x361
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x17
	.string	"num"
	.byte	0x1
	.byte	0x28
	.byte	0x9
	.4byte	0x42
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0x18
	.4byte	.LASF90
	.byte	0x1
	.byte	0x1c
	.byte	0x7
	.4byte	.LASF91
	.4byte	0x40
	.8byte	.LFB10
	.8byte	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4f2
	.uleb128 0x19
	.4byte	.LASF84
	.byte	0x1
	.byte	0x1c
	.byte	0x1b
	.4byte	0x40
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x1a
	.4byte	.LASF92
	.4byte	0x502
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC1
	.byte	0
	.uleb128 0xc
	.4byte	0x98
	.4byte	0x502
	.uleb128 0xd
	.4byte	0x39
	.byte	0x1a
	.byte	0
	.uleb128 0x7
	.4byte	0x4f2
	.uleb128 0x1b
	.4byte	.LASF83
	.byte	0x1
	.byte	0x15
	.byte	0x7
	.4byte	.LASF93
	.4byte	0x40
	.8byte	.LFB9
	.8byte	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x19
	.4byte	.LASF84
	.byte	0x1
	.byte	0x15
	.byte	0x1b
	.4byte	0x40
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
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
	.uleb128 0x3
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
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
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
	.uleb128 0x12
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.uleb128 0x14
	.uleb128 0x34
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
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
	.uleb128 0x34
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
	.uleb128 0x18
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
	.uleb128 0x6e
	.uleb128 0xe
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
	.uleb128 0x19
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
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x6c
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
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
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
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
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF8:
	.string	"__off_t"
.LASF12:
	.string	"_IO_read_ptr"
.LASF24:
	.string	"_chain"
.LASF7:
	.string	"size_t"
.LASF30:
	.string	"_shortbuf"
.LASF86:
	.string	"0-datarace.cpp"
.LASF18:
	.string	"_IO_buf_base"
.LASF58:
	.string	"long long unsigned int"
.LASF91:
	.string	"_Z13reader_threadPv"
.LASF81:
	.string	"reader"
.LASF93:
	.string	"_Z13writer_threadPv"
.LASF33:
	.string	"_codecvt"
.LASF53:
	.string	"__timezone"
.LASF60:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF92:
	.string	"__PRETTY_FUNCTION__"
.LASF73:
	.string	"PTHREAD_MUTEX_ROBUST_NP"
.LASF25:
	.string	"_fileno"
.LASF13:
	.string	"_IO_read_end"
.LASF6:
	.string	"long int"
.LASF11:
	.string	"_flags"
.LASF19:
	.string	"_IO_buf_end"
.LASF28:
	.string	"_cur_column"
.LASF42:
	.string	"_IO_codecvt"
.LASF50:
	.string	"_sys_errlist"
.LASF27:
	.string	"_old_offset"
.LASF32:
	.string	"_offset"
.LASF87:
	.string	"/home/nsas2020/fuzz/targetProcess/reorder/RMEM"
.LASF77:
	.string	"PTHREAD_RWLOCK_DEFAULT_NP"
.LASF56:
	.string	"timezone"
.LASF90:
	.string	"reader_thread"
.LASF41:
	.string	"_IO_marker"
.LASF44:
	.string	"stdin"
.LASF67:
	.string	"PTHREAD_MUTEX_ERRORCHECK"
.LASF3:
	.string	"unsigned int"
.LASF36:
	.string	"_freeres_buf"
.LASF0:
	.string	"long unsigned int"
.LASF16:
	.string	"_IO_write_ptr"
.LASF47:
	.string	"sys_nerr"
.LASF78:
	.string	"data"
.LASF64:
	.string	"PTHREAD_MUTEX_ADAPTIVE_NP"
.LASF2:
	.string	"short unsigned int"
.LASF20:
	.string	"_IO_save_base"
.LASF80:
	.string	"writer"
.LASF31:
	.string	"_lock"
.LASF26:
	.string	"_flags2"
.LASF38:
	.string	"_mode"
.LASF45:
	.string	"stdout"
.LASF83:
	.string	"writer_thread"
.LASF71:
	.string	"PTHREAD_MUTEX_STALLED_NP"
.LASF76:
	.string	"PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP"
.LASF65:
	.string	"PTHREAD_MUTEX_NORMAL"
.LASF57:
	.string	"getdate_err"
.LASF70:
	.string	"PTHREAD_MUTEX_STALLED"
.LASF17:
	.string	"_IO_write_end"
.LASF89:
	.string	"_IO_lock_t"
.LASF88:
	.string	"_IO_FILE"
.LASF62:
	.string	"PTHREAD_MUTEX_RECURSIVE_NP"
.LASF52:
	.string	"__daylight"
.LASF69:
	.string	"PTHREAD_MUTEX_FAST_NP"
.LASF48:
	.string	"sys_errlist"
.LASF23:
	.string	"_markers"
.LASF63:
	.string	"PTHREAD_MUTEX_ERRORCHECK_NP"
.LASF59:
	.string	"pthread_t"
.LASF1:
	.string	"unsigned char"
.LASF75:
	.string	"PTHREAD_RWLOCK_PREFER_WRITER_NP"
.LASF74:
	.string	"PTHREAD_RWLOCK_PREFER_READER_NP"
.LASF5:
	.string	"short int"
.LASF43:
	.string	"_IO_wide_data"
.LASF85:
	.string	"GNU C++11 9.4.0 -mlittle-endian -mabi=lp64 -g -std=c++11 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection"
.LASF79:
	.string	"flag"
.LASF49:
	.string	"_sys_nerr"
.LASF29:
	.string	"_vtable_offset"
.LASF54:
	.string	"tzname"
.LASF40:
	.string	"FILE"
.LASF55:
	.string	"daylight"
.LASF10:
	.string	"char"
.LASF9:
	.string	"__off64_t"
.LASF14:
	.string	"_IO_read_base"
.LASF22:
	.string	"_IO_save_end"
.LASF68:
	.string	"PTHREAD_MUTEX_DEFAULT"
.LASF37:
	.string	"__pad5"
.LASF39:
	.string	"_unused2"
.LASF46:
	.string	"stderr"
.LASF66:
	.string	"PTHREAD_MUTEX_RECURSIVE"
.LASF21:
	.string	"_IO_backup_base"
.LASF61:
	.string	"PTHREAD_MUTEX_TIMED_NP"
.LASF35:
	.string	"_freeres_list"
.LASF34:
	.string	"_wide_data"
.LASF84:
	.string	"args"
.LASF51:
	.string	"__tzname"
.LASF82:
	.string	"main"
.LASF15:
	.string	"_IO_write_base"
.LASF72:
	.string	"PTHREAD_MUTEX_ROBUST"
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
