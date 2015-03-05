	.file	1 "test_c.c"
	.section .mdebug.abi32
	.previous
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
	li	$2,32			# 0x20
	sw	$2,24($fp)
	li	$2,-4			# 0xfffffffffffffffc
	sw	$2,20($fp)
	lw	$3,24($fp)
	lw	$2,20($fp)
	nop
	addu	$2,$3,$2
	sw	$2,16($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,16
	sw	$2,16($fp)
	lw	$3,24($fp)
	lw	$2,20($fp)
	nop
	subu	$2,$3,$2
	sw	$2,16($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,-16
	sw	$2,16($fp)
	lw	$3,24($fp)
	lw	$2,20($fp)
	nop
	mult	$3,$2
	mflo	$2
	sw	$2,16($fp)
	lw	$2,24($fp)
	nop
	sll	$2,$2,1
	sw	$2,16($fp)
	lw	$3,24($fp)
	lw	$2,20($fp)
	nop
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mflo	$2
	sw	$2,16($fp)
	lw	$3,24($fp)
	nop
	srl	$2,$3,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,16($fp)
	li	$2,32			# 0x20
	sw	$2,12($fp)
	li	$2,4			# 0x4
	sw	$2,8($fp)
	lw	$3,12($fp)
	lw	$2,8($fp)
	nop
	addu	$2,$3,$2
	sw	$2,4($fp)
	lw	$2,12($fp)
	nop
	addiu	$2,$2,16
	sw	$2,4($fp)
	lw	$3,12($fp)
	lw	$2,8($fp)
	nop
	subu	$2,$3,$2
	sw	$2,4($fp)
	lw	$2,12($fp)
	nop
	addiu	$2,$2,-16
	sw	$2,4($fp)
	lw	$3,12($fp)
	lw	$2,8($fp)
	nop
	mult	$3,$2
	mflo	$2
	sw	$2,4($fp)
	lw	$2,12($fp)
	nop
	sll	$2,$2,1
	sw	$2,4($fp)
	lw	$3,12($fp)
	lw	$2,8($fp)
	nop
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mflo	$2
	sw	$2,4($fp)
	lw	$3,12($fp)
	nop
	srl	$2,$3,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,4($fp)
	lw	$2,4($fp)
	nop
	sw	$2,24($fp)
	lw	$3,24($fp)
	nop
	srl	$2,$3,31
	addu	$2,$2,$3
	sra	$2,$2,1
	sw	$2,4($fp)
	lw	$3,24($fp)
	lw	$2,4($fp)
	nop
	bne	$2,$0,1f
	div	$0,$3,$2
	break	7
1:
	mflo	$2
	sw	$2,0($fp)
	j	$L2
	nop

$L5:
	lw	$3,24($fp)
	lw	$2,4($fp)
	nop
	subu	$2,$3,$2
	sw	$2,24($fp)
	lw	$2,0($fp)
	nop
	addiu	$2,$2,-1
	sw	$2,0($fp)
$L4:
	lw	$2,0($fp)
	nop
	bgtz	$2,$L5
	nop

$L2:
	lw	$2,24($fp)
	lw	$3,4($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L4
	nop

	lw	$2,24($fp)
	nop
	bne	$2,$0,$L7
	nop

	li	$2,-1			# 0xffffffffffffffff
	sw	$2,24($fp)
$L7:
	move	$2,$0
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
