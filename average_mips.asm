
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

# average of the array values
      addi $v0, $zero, 20    # amount of bytes: 20
      add  $a0, $zero, $sp   # point to the last stack address
      sub  $a0, $a0, $v0     # load the base address (first array item): stack - 20 bytes
      srl  $v0, $v0, 1       # amount of items on array: 20/2 = 10
      add  $t0, $zero, $zero # point to the first item of the array 
      addu $t1, $zero, $zero # clean the temporary register that holds the sum
Loop2: sll $t2, $t0, 1       # get next index - shift 2 bytes, size of half word
      add  $t2, $t2, $a0     # point to the item address stored on a0
      lhu  $t3, 0($t2)       # load item - half word
      addu $t1, $t1, $t3     # sum the item to the register that accumulates the sum
      addi $t0, $t0, 1       # increment index
      bne  $v0, $t0, Loop2   # go to next array item if index is not the last one
      divu $t1, $v0          # calculate the average value (sum elements/ number elements)
      mflo $v0               # store quocient on $v0

      syscall
