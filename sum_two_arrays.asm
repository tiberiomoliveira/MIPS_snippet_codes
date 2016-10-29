    .data
array1: .byte 1, 2, 3, 4, 5
array2: .byte 6, 7, 8, 9, 0
SIZE:   .byte 5

    .text
    .globl main

# sum two arrays based on size variable
main:
    la      $t0, array1               # load array 1 address
    move    $a0, $t0                  # keep the array 1 address on the right register
    la      $t0, array2               # load array 2 address
    move    $a1, $t0                  # keep the array 2 address on the right register
    la      $t0, SIZE                 # load size variable address
    lbu     $a2, 0($t0)               # load the value of the size variable address
    add     $t0, $zero, $zero         # index of the arrays
    add     $t1, $zero, $zero         # initialize the sum temp variable

Loop:
    add     $t2, $t0, $a0             # point to the real item address of the array 1
    lbu     $t4, 0($t2)               # load a item of the array 1
    add     $t2, $t0, $a1             # point to the real item address of the array 2
    lbu     $t5, 0($t2)               # load a item of the array 2
    add     $t1, $t1, $t4             # add item from array 1
    add     $t1, $t1, $t5             # add item from array 2
    addi    $t0, $t0, 1               # increment the index of the arrays
    beq     $t0, $a2, End             # $t0 == $a2 means all items has been summed
    j       Loop                      # continue the loop, so get next character

End:
    add     $v0, $t0, $zero           # store the index of the position found
    syscall
