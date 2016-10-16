.text
.globl main
main:
# stack storage test
      addi $v1, $zero, 20    # amount of bytes: 20
      add  $t2, $v1, $zero   # get amount of bytes
      srl  $t2, $t2, 1       # shift right is division, amount of itens (half word) on array: 20/2 = 10
      add  $t1, $zero, $sp   # point to the last stack address
      add  $s2, $zero, $zero # clear index
Loop1:
      sll  $t0, $s2, 1       # go to the next index
      add  $t0, $t0, $t1     # point to the real stack address
      sll  $t3, $s2, 1       # get a bigger number
      sh   $t3, 0($t0)       # put index on the stack address
      addi $s2, $s2, 1       # increment index
      bne  $s2, $t2, Loop1   # continue loop if s2 different from t2

# histogram array clear
      addi $v1, $zero, 5     # amount of bytes: 5
      add  $t1, $zero, $sp   # point to the last stack address
      addi $t1, $t1, 30      # load the base address (first array item): stack pointer + 20
      add  $s2, $zero, $zero # clear index
      add  $t3, $zero, $zero # zero the register
Loop2:
      add  $t0, $s2, $t1     # point to the real stack address
      sb   $t3, 0($t0)       # put index on the stack address
      addi $s2, $s2, 1       # increment index
      bne  $s2, $v1, Loop2   # continue loop if s2 different from t2

# sort array exercice
      # array of values
      add  $a0, $zero, $sp      # point to the last stack address
      addi $v0, $zero, 10         # amount of items on array
      # array of histogram
      addi $t1, $zero, 30       # jump a few bytes
      add  $a1, $zero, $sp      # point to the last stack address
      add  $a1, $a1, $t1        # load the base address (first array item): stack + 30 bytes
      addi $v1, $zero, 5        # amount of items on array: 5

      add  $s0, $zero, $zero    # index of histogram array
ForHisto:
      slt  $t0, $s0, $v1        # test if index is smaller than the size of the histogram array
      beq  $t0, $zero, Exit0    # if $t0 is zero, then go quit (leave loop if index is bigger than the size of the histogram array)
      add  $s1, $zero, $zero    # index of value array
ForArray:
      slt  $t0, $s1, $v0        # test if index is smaller than the size of the value array
      beq  $t0, $zero, Exit1    # if $t0 is zero, then go exit (leave loop if index is bigger than the size of the value array)
      sll  $t1, $s1, 1          # get the position of the array item (half word is 16bits, so 2 bytes)
      add  $t2, $a0, $t1        # get the address of the array item
      lhu  $t3, 0($t2)          # load value array item
      addi $s1, $s1, 1          # increment array index
      srl  $t3, $t3, 2          # prepare value to compare (do a right shift)
      bne  $s0, $t3, ForArray   # compare histogram index with array value shifted
      add  $t4, $a1, $s0        # get the address of the histogram item
      lbu  $t5, 0($t4)          # load histogram array item
      addi $t5, $t5, 1          # value is in the histogram range, so increment the histogram array item
      sb   $t5, 0($t4)          # change histogram array item
      j    ForArray             # go check if the array loop is valid
Exit1:
      addi $s0, $s0, 1          # increment histogram index variable
      j    ForHisto             # go check if the histogram loop is valid
Exit0:
      syscall                   # End of routine
