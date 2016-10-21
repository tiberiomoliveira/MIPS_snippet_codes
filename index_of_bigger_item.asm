    .data
array: .half 0, 1, 10, 11, 100, 101, 2, 3, 4, 1000
size:  .half 10

    .text
    .globl main

# find the index of the biggest item of the array
main:
    la      $t0, array                # load the array address
    move    $a0, $t0                  # store the array address
    la      $t0, size                 # load the size address
    lhu     $v1, 0($t0)               # load the size of the array
    lhu     $t0, 0($a0)               # load the first item of the array
    add     $t1, $zero, $zero         # bigger item index
    addi    $t2, $zero, 1             # loop index
Loop:
    sll     $t3, $t2, 1               # go to the next index, shift left by 1 multiply 2
    add     $t4, $t3, $a0             # point to the real item address
    lhu     $t5, 0($t4)               # load an array item
    sltu    $t4, $t1, $t5             # compare which is smaller
    beq     $t4, $zero, Next          # $t4 == 0 means $t1 is bigger than $t5
    add     $t0, $t5, $zero           # store the bigger value
    add     $t1, $t2, $zero           # store the index for the bigger value
Next:
    addi    $t2, $t2, 1               # increment loop index
    bne     $v1, $t2, Loop            # continue loop if s2 different from t2
    add     $v0, $t2, $zero           # store the bigger index for the answer

    syscall
