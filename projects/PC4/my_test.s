# check addi
addi $2, $0, 5
addi $1, $0, 1
# check add
add $3, $2, $1
# check sub
sub $4, $2, $1
# check add
add $5, $2, $1
# check or
or $6, $2, $1
# check sll
sll $7, $2, 2
# check sra
sra $8, $2, 2
# check sw
sw $8, 3($2)
# check lw
lw $9, 3($2)
add $10, $9, $8
# check overflow
sll $11, $1, 30
addi $12, $11, 0 
# overflow
add $13, $12, $11
add $29, $30, $0
sll $14, $11, 1
addi $15, $14, -1
add $28, $30, $0
sub $16, $14, $1
add $27, $30, $0
# add to same reg
add $2, $2, $2
add $2, $2, $2
# addi neg
addi $17, $1, -1
# add r0
addi $0, $1, 1
add $0, $0, $0
# sra neg
addi $18, $0, -100
sra $18, $18, 2



