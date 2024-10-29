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
addi $1, $1, -1
addi $1, $1, 1
j 13
addi $1, $1, -1
addi $1, $1, 1
jal 16
addi $1, $1, -1
addi $1, $1, 1
add $3, $31, $0

