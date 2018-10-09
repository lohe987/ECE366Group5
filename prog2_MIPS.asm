# Joseph de Joya
# ECE 366 - Project 1 - Program 2
# 09/25/2018

.data
T: .word 12			# 0x2000
best_matching_score: .word -1	# best score, within [0,32]. 0x2004
best_matching_count: .word -1	# how many patterns achieve the best score. 0x2008
numel: .word 20			# Number of elements in the  pattern array. 0x200C
# Patter_Array starts at 0x2010
Pattern_Array: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20

.text
# Assumption: Pattern_Array is an array of at most 100 elements.
	addi	$s0, $zero, 0		# $s0 keeps track of the best matching score
	addi	$s1, $zero, 0		# $s1 keeps track of the best matching count
	
	lw	$s2, 0x2000($zero)	# Load Pattern T, $s2 = MEM[0x2000] = T
	lw	$s3, 0x200C($zero)	# Load Number of elements in Pattern_array
	addi	$t0, $zero, 0x2010	# Initialize $t0 to be the address of the first element of the Pattern_Array
	j	start_match		# Jump to start the matching process

loop_match:
	addi	$s3, $s3, -1		# Reduce the number of unchecked elements in the Pattern_Array
	addi	$t0, $t0, 0x0004	# Point to the next element in the Pattern_Array
start_match: 
	beq	$s3, $zero, done	# Check  if every element in the Pattern_Array have been checked.
	addi	$t2, $zero, 0		# Initialize counter
	lw	$t1, ($t0)		# Load the element of Pattern_Array specified by the address at $t0
	xor	$t1, $t1, $s2		# $t1 = $t1 bitwise xor T, where $t1 is an element of the Pattern_Array
	j	start_count		# Start counting the number of unmatched bits
	
# Approach to counting bit matches. Step 1: Use xor to find out the number of mismatched bits from T and the an element of
# the Pattern_Array. Step 2: 32 - (number of mismatched bits) = Number of matched bits.
loop_count:
	addi	$t2, $t2, 1		# $t2++, keeping track of unmatched bits.
loop_no_count:
	sll	$t1, $t1, 1		# $t1 << 1
start_count:
	beq	$t1, $zero, count_done	# Branch out when done counting the number 1's. Each 1 means there is an unmatched bit between T and $t1
	slt	$t3, $t1, $zero		# If $t1 < 0, then $t3 = 1, else $t3 = 0
	beq	$t3, 1, loop_count	# If $t3 == 1 then $t2++, else $t1 << 1.
	j	loop_no_count		# Jump back to loop_no_count
count_done:
	addi	$t3, $zero, 32			# Initialize $t3 = 32
	sub	$t2, $t3, $t2			# $t2 = 32 - $t2 = Number of matched bits
	slt	$t3, $s0, $t2			# If $s0 < $t2 less than, then a new best match is found and $t3 = 1, else $t3 = 0
	beq	$t3, 1, update_best_match	# Update new best match
	bne	$s0, $t2, loop_match		# Check if current element of Patter_Array is current best match
	addi	$s1, $s1, 1			# Update best match count
	j	loop_match			# go back loop_match
update_best_match:
	addi	$s0, $zero, 0
	add	$s0, $s0, $t2			# $s0 = current best match
	addi	$s1, $zero, 1			# Count the number of best matches
	j	loop_match			# go back to loop_match	
done:
	sw	$s0, 0x2004($zero)		# MEM[0x2004] = best_matching_score = $s0
	sw	$s1, 0x2008($zero)		# MEM[0x2008] = best_matching_count = $s1