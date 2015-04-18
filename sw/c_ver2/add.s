	.file	1 "ver2.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,32,$31		# vars= 24, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,32			# 0x20
	sw	$2,16($fp)
	li	$2,-4			# 0xfffffffffffffffc
	sw	$2,12($fp)
	lw	$2,16($fp)
	nop
	nor	$2,$0,$2
	sw	$2,8($fp)
	lw	$2,16($fp)
	nop
	sltu	$2,$2,1
	sw	$2,8($fp)
	lw	$3,16($fp)
	lw	$2,12($fp)
	nop
	addu	$2,$3,$2
	sw	$2,8($fp)
	lw	$3,16($fp)
	lw	$2,12($fp)
	nop
	subu	$2,$3,$2
	sw	$2,8($fp)
	lw	$2,16($fp)
	nop
	sll	$2,$2,4
	sw	$2,8($fp)
	lw	$2,16($fp)
	nop
	sra	$2,$2,4
	sw	$2,8($fp)
	sw	$0,8($fp)
	lw	$3,8($fp)
	lw	$2,16($fp)
	nop
	slt	$2,$3,$2
	beq	$2,$0,$L2
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L2:
	lw	$2,8($fp)
	lw	$3,16($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L4
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L4:
	lw	$2,8($fp)
	lw	$3,12($fp)
	nop
	slt	$2,$3,$2
	beq	$2,$0,$L6
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L6:
	lw	$2,8($fp)
	lw	$3,12($fp)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L8
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L8:
	lw	$2,8($fp)
	nop
	bne	$2,$0,$L10
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L10:
	lw	$3,8($fp)
	lw	$2,16($fp)
	nop
	beq	$3,$2,$L12
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L12:
	lw	$3,16($fp)
	lw	$2,12($fp)
	nop
	and	$2,$3,$2
	sw	$2,8($fp)
	lw	$3,16($fp)
	lw	$2,12($fp)
	nop
	xor	$2,$3,$2
	sw	$2,8($fp)
	lw	$3,16($fp)
	lw	$2,12($fp)
	nop
	or	$2,$3,$2
	sw	$2,8($fp)
	sw	$0,8($fp)
	lw	$2,8($fp)
	nop
	beq	$2,$0,$L14
	nop

	lw	$2,16($fp)
	nop
	beq	$2,$0,$L14
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L14:
	lw	$2,8($fp)
	nop
	bne	$2,$0,$L17
	nop

	lw	$2,16($fp)
	nop
	beq	$2,$0,$L19
	nop

$L17:
	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L19:
	lw	$2,8($fp)
	nop
	beq	$2,$0,$L20
	nop

	lw	$2,16($fp)
	nop
	beq	$2,$0,$L20
	nop

	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L20:
	li	$2,16			# 0x10
	sw	$2,16($fp)
	li	$2,8			# 0x8
	sw	$2,4($fp)
	li	$2,2			# 0x2
	sw	$2,0($fp)
	j	$L23
	nop

$L26:
	lw	$3,16($fp)
	lw	$2,4($fp)
	nop
	subu	$2,$3,$2
	sw	$2,16($fp)
	lw	$2,0($fp)
	nop
	addiu	$2,$2,-1
	sw	$2,0($fp)
$L25:
	lw	$2,0($fp)
	nop
	bgtz	$2,$L26
	nop

$L23:
	lw	$2,16($fp)
	lw	$3,4($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L25
	nop

	lw	$2,16($fp)
	nop
	bne	$2,$0,$L30
	nop

	li	$2,-1			# 0xffffffffffffffff
	sw	$2,16($fp)
$L30:
	move	$sp,$fp
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 4.1.2"
