    .data
str1: .asciiz "A91abcda19A"
str2: .asciiz "abc"

    .text
    .globl main

# find first occurrency of a string into another string
main:
    la      $t0, str1                 # load string 1 array address
    move    $a0, $t0                  # keep the string 1 array address on the right register
    la      $t0, str2                 # load string 2 array address
    move    $a1, $t0                  # keep the string 2 array address on the right register
    add     $t0, $zero, $zero         # index of the characters into the string 1
    add     $t1, $zero, $zero         # index of the characters into the string 2
    addi    $t6, $zero, -1            # index of the string 2 on string 1
    add     $t3, $t1, $a1             # point to the real item address of the string 2
    lbu     $t5, 0($t3)               # load a character of the string 2
    beq     $t5, $zero, End           # $t5 == 0 means the string 2 is empty

Loop:
    add     $t2, $t0, $a0             # point to the real item address of the string 1
    lbu     $t4, 0($t2)               # load a character of the string 1
    beq     $t4, $zero, End           # $t4 == 0 means it is the end of the string 1
    beq     $t4, $t5, Found           # jump to found if $t4 == $t5
    add     $t1, $zero, $zero         # reinitialize the index for string 2
    addi    $t6, $zero, -1            # reinitialize the found index
ContinueLoop:
    add     $t0, $t0, 1               # increment index of characters of the string 1
    j       Loop                      # continue the loop, so get next character

Found:
    add     $t1, $t1, 1               # incremet index of character of the string 2
    add     $t3, $t1, $a1             # point to the real item address of the string 2
    lbu     $t5, 0($t3)               # load a character of the string 2
    beq     $t5, $zero, End           # $t5 == 0 means the string 2 has found completly
    bne     $t6, -1, ContinueLoop     # if index not zero the position has been stored
    add     $t6, $t0, $zero           # store the position index
    j       ContinueLoop              # continue

End:
    add     $v0, $t6, $zero           # store the index of the position found
    syscall
