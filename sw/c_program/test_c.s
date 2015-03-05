	.file	1 "test_c.c"
	.section .mdebug.abi32
	.previous
	.rdata
	.align	2
$LC0:
	.ascii	"H\000"
	.align	2
$LC1:
	.ascii	"i\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,40,$31		# vars= 32, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$2,12			# 0xc
	sw	$2,20($fp)
	li	$2,-5			# 0xfffffffffffffffb
	sw	$2,16($fp)
	lw	$3,20($fp)
	lw	$2,16($fp)
	nop
	subu	$2,$3,$2
	sw	$2,24($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,-10
	sw	$2,16($fp)
	li	$2,12			# 0xc
	sw	$2,12($fp)
	li	$2,5			# 0x5
	sw	$2,8($fp)
	lw	$3,12($fp)
	lw	$2,8($fp)
	nop
	subu	$2,$3,$2
	sw	$2,4($fp)
	lw	$2,4($fp)
	nop
	sw	$2,24($fp)
	lw	$2,20($fp)
	nop
	sw	$2,4($fp)
	lui	$2,%hi($LC0)
	addiu	$2,$2,%lo($LC0)
	sb	$2,1($fp)
	lui	$2,%hi($LC1)
	addiu	$2,$2,%lo($LC1)
	sb	$2,0($fp)
	lbu	$2,1($fp)
	nop
	sb	$2,28($fp)
	lbu	$2,0($fp)
	nop
	sb	$2,29($fp)
	move	$sp,$fp
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 4.1.2"
