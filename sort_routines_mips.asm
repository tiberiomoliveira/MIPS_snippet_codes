# stack storage test
  ADDI $v1, $zero, 20    # amount of bytes: 20
  ADD  $t2, $v1, $zero   # get amount of bytes
  SRL  $t2, $t2, 1       # shift right is division, amount of itens on array: 20/2 = 10
  ADD  $t1, $zero, $sp   # point to the last stack address
  SUB  $t1, $t1, $v1     # load the base address (first array item): stack pointer - 20
  ADD  $s2, $zero, $zero # index
Loop1: sll $t0, $s2, 1 # go to the next index
  ADD  $t0, $t0, $t1     # point to the real stack address
  SLL  $t3, $s2, 5       # get a bigger number
  SH   $t3, 0($t0)       # put index on the stack address
  ADDI $s2, $s2, 1       # increment index
  BNE  $s2, $t2, Loop1   # continue loop if s2 different from t2

# sort array exercice
Start: JAL Sort           # jump to Sort function
  J   Exit0                # jump to exit
# swap routine
Swap: SLL $t1, $a1, 1      # multiply second parameter by 2
  ADD  $t1, $a0, $t1       # get the address of the array item
  LHU  $t0, 0($t1)         # load current array item
  LHU  $t2, 2($t1)         # load next array item
  SH   $t2, 0($t1)         # store next array item on the place of the current array item
  SH   $t0, 2($t1)         # store current array item on the place of the first array item
  JR   $ra                 # return to calling routine
# sort routine
Sort: ADDI $sp, $sp, -4    # make room on stack for 1 register
  SW   $ra, 0($sp)         # save $ra on stack
  MOVE $s0, $zero          # clear index variable
ForOuter: SLT $t0, $s0, $v1 # test if index is smaller than the size of the vector
  BEQ  $t0, $zero, Exit1   # if $t0 is zero, then go exit (leave loop if index bigger than the size of the vector)
  ADDI $s1, $s0, -1        # set second index as primary index less one
ForInner: SLTI $t0, $s1, 0 # test if second index is smaller than zero
  BNE  $t0, $zero, Exit2   # if $t0 is zero, then go exit (leave loop if second index is smaller than zero)
  SLL  $t1, $s1, 1         # get the position of the array item (halfword is 16bits, so 2 bytes)
  ADD  $t2, $a0, $t1       # get the address of the array item
  LHU  $t3, 0($t2)         # load current array item
  LHU  $t4, 2($t2)         # load next array item
  SLTU $t0, $t4, $t3       # test if next array item is smaller than the current array item
  BEQ  $t0, $zero, Exit2   # if $t0 is zero, next array item is bigger, so go to next array item
  MOVE $a1, $s1            # store on argument variable the current index array to swap
  JAL  Swap                # call swap routine
  ADDI $s1, $s1, -1        # decrement index, so check earlier array item if it is smaller
  J    ForInner            # go check if the inner loop is valid
Exit2: ADDI $s0, $s0, 1    # increment outer index variable
  J    ForOuter            # go check if the outer loop is valid
Exit1: LW $ra, 0($sp)      # restore $ra register
  JR  $ra                  # return to calling routine
Exit0: # End of routine
