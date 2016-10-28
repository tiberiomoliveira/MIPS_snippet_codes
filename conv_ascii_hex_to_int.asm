    .data
str: .asciiz "A91a"

    .text
    .globl main

# convert a hexadecimal string to an interger number
main:
    la      $t0, str                  # load the array address
    move    $a0, $t0                  # store the array address
    addi    $t1, $zero, 16            # 16 units to transform from hexadecimal
    add     $t2, $zero, $zero         # accumulate final number
    add     $t3, $zero, $zero         # index of the characters into the string

Loop:
    add     $t4, $t3, $a0             # point to the real item address
    lbu     $t4, 0($t4)               # load an item of the array
    beq     $t4, $zero, End           # $t4 == 0 means it is the end of the string
    blt     $t4, 48, Error            # $t4 < '0'(value 48 in ascii) so it is not a hexadecimal
    bgt     $t4, 70, Error            # $t4 > 'F' (value 70 in ascii) so it is not a hexadecimal
    ble     $t4, 57, Decimal          # $t4 < '9' (value 57 in ascii) so it is a decimal number
    ble     $t4, 65, Hexadecimal      # $t4 > 'A' (value 65 in ascii) so ti is a hexadecimal number
    j       Error                     # $t4 is between '9' and 'A' so not a hexadecimal

Decimal:
    sub     $t5, $t4, 48              # transform in a decimal value
    multu   $t2, $t1                  # multiply by the base
    mflo    $t2                       # get the multiplicatio result
    add     $t2, $t2, $t5             # add the decimal number
    addi    $t3, $t3, 1               # increment loop index
    j       Loop                      # continue the loop

Hexadecimal:
    sub     $t5, $t4, 65              # transform in a decimal value
    addi    $t5, $t5, 10              # this is a hexadecimal larger than 9
    multu   $t2, $t1                  # multiply by the base
    mflo    $t2                       # get the multiplicatio result
    add     $t2, $t2, $t5             # add the decimal number
    addi    $t3, $t3, 1               # increment loop index
    j       Loop                      # continue the loop

Error:
    addi $t2, $zero, -1               # in case of error, return -1

End:
    add     $v0, $t2, $zero           # store the sum value for the answer
    syscall
