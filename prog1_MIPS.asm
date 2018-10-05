# Joseph de Joya
# ECE 366 - Project 2 - Program 1
# Modular Exponentiation
# 09/25/2018


.data
P: .word 1000		# Exponent P is stored here. MEM[0x2000].
Q: .word 500		# Modulo divisor Q is stored here. MEM[0x2004]
R: .word -1		# Result (R) is written here. MEM[0x2008].

.text
# Approach: Using a property of modular arithmetic (a*b) mod q = ((a mod q) * (b mod q)) mod q
# I will use the algorithm below to get the result c = b^p mod q. Where c is the result, b is
# the base, p is the exponent, and  q is the modular divisor.
# (1) set c = 1 and p' = 0
# (2) p' = p' + 1
# (3) c = (b * c) mod q
# (4) If p' < p go back to step (2), else c is the solution.

# Load P and Q
	lw $s0, 0x2000($zero)	# $s0 = P, assuming MEM[0x2000] = P
	lw $s1, 0x2004($zero)	# $s1 = Q, assuming MEM[0x2004] = Q

# Step (1)
	addi $s2, $zero, 1	# set c = 1
	addi $s3, $zero, 0	# set p' = 0
# Step (2)
step2:
	addi $s3, $s3, 1	# p' = p' + 1
# Step (3): 6 * c = (4 + 2) * c = (4 * c) + (2 * c)
	sll $t0, $s2, 2		# $t0 = 4 * c
	sll $t1, $s2, 1		# $t1 = 2 * c
	add $s2, $t0, $t1	# c = (b * c)
	j mod_start		# c = (b * c) mod Q
mod_loop:
	sub $s2, $s2, $s1	# c = c - Q
mod_start:
	slt $t0, $s2, $s1	 # If c < Q then $t0 = 1, else $t0 = 0
	beq $t0, $zero, mod_loop # Keep looping until (mod Q) is achieved.
# Step (4)
	bne $s3, $s0, step2	# If p' != p, then p' < p in this case.
	sw $s2, 0x2008($zero)	# MEM[0x2008] = R = 6^P mod Q