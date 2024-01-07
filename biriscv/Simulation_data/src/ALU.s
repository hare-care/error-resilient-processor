.org 0x0 			#code start at address 0x0
 	.global _start
_start:
	addi x1, x0, 123
	addi x2, x0, -100
	slli x3, x1, 3
	xori x4, x1, 0
	add x5, x1, x2