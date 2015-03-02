	.file	1 "add.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$fp,16($sp)
	move	$fp,$sp
	li	$2,2			# 0x2
	sw	$2,8($fp)
	li	$2,3			# 0x3
	sw	$2,4($fp)
	lw	$3,8($fp)
	lw	$2,4($fp)
	nop
	mult	$3,$2
	mflo	$2
	sw	$2,12($fp)
	lw	$3,4($fp)
	lw	$2,8($fp)
	nop
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mflo	$2
	sw	$2,0($fp)
	li	$2,29			# 0x1d
	sw	$2,8($fp)
	li	$2,4			# 0x4
	sw	$2,4($fp)
	lw	$3,8($fp)
	lw	$2,4($fp)
	nop
	mult	$3,$2
	mflo	$2
	sw	$2,12($fp)
	move	$sp,$fp
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 4.1.2"
