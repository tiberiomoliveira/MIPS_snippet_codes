.text
.globl main

# stack storage test
main: addi $v1, $zero, 20    # amount of bytes: 20
      add  $t2, $v1, $zero   # get amount of bytes
      srl  $t2, $t2, 1       # shift right is division, amount of itens on array: 20/2 = 10
      add  $t1, $zero, $sp   # point to the last stack address
      sub  $t1, $t1, $v1     # load the base address (first array item): stack pointer - 20
      add  $s2, $zero, $zero # index
Loop1: sll $t0, $s2, 1       # go to the next index
      add  $t0, $t0, $t1     # point to the real stack address
      sll  $t3, $s2, 5       # get a bigger number
      sh   $t3, 0($t0)       # put index on the stack address
      addi $s2, $s2, 1       # increment index
      bne  $s2, $t2, Loop1   # continue loop if s2 different from t2
# sort array exercice
      addi $v0, $zero, 20       # amount of bytes: 20
      add  $a0, $zero, $sp      # point to the last stack address
      sub  $a0, $a0, $v0        # load the base address (first array item): stack - 20 bytes
      srl  $v0, $v0, 1          # amount of items on array: 20/2 = 10
      addi  $s0, $zero, 1       # index variable, skip first array item
ForOuter: slt $t0, $s0, $v0 # test if index is smaller than the size of the vector
      beq  $t0, $zero, Exit0    # if $t0 is zero, then go exit (leave loop if index bigger than the size of the vector)
      addi $s1, $s0, -1         # set second index as outer index minus one
ForInner: slt $t0, $s1, $zero  # test if second index is smaller than zero
      bne  $t0, $zero, Exit1    # if $t0 is zero, then go exit (leave loop if second index is smaller than zero)
      sll  $t1, $s1, 1          # get the position of the array item (halfword is 16bits, so 2 bytes)
      add  $t2, $a0, $t1        # get the address of the array item
      lhu  $t3, 0($t2)          # load current array item
      lhu  $t4, 2($t2)          # load next array item
      sltu $t0, $t4, $t3        # test if next array item is smaller than the current array item
      beq  $t0, $zero, Exit1    # if $t0 is zero, next array item is bigger, so go to next array item
      sh   $t4, 0($t2)          # store next array item on the place of the current array item
      sh   $t3, 2($t2)          # store current array item on the place of the first array item
      addi $s1, $s1, -1         # decrement index, so check earlier array item if it is smaller
      j    ForInner             # go check if the inner loop is valid
Exit1: addi $s0, $s0, 1     # increment outer index variable
      j    ForOuter             # go check if the outer loop is valid
Exit0: li $v0, 10            # End of routine
      syscall

