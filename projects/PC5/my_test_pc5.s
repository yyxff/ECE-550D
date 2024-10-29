# check bne
bne $1, $2, 4
addi $1, $0, 1
bne $1, $2, 1
addi $7, $7, 1
addi $1, $1, 1
blt $1, $1, 1
addi $1, $1, -2
addi $1, $1, 1
blt $2, $1, 1
addi $1, $1, -2
addi $1, $1, 1
j 13
addi $1, $1, -3
addi $1, $1, 1
jal 16
addi $1, $1, -4
addi $1, $1, 1
add $3, $31, $0
# check bex
addi $10, $0, 1
sll $4, $10, 30
sll $5, $10, 30
add $6, $4, $5
bex 24
addi $1, $1, -5
addi $1, $1, 1

