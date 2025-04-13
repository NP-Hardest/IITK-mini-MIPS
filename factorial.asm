    .data
prompt:     .asciiz "Enter an integer: "
resultMsg:  .asciiz "Factorial is: "

    .text
    .globl main

main:
    # Print prompt for input.
    li $v0, 4           # syscall code for print_string.
    la $a0, prompt      # address of the prompt string.
    syscall

    # Read integer from user.
    li $v0, 5           # syscall code for read_integer.
    syscall
    move $a0, $v0       # move input to $a0 for use in fact().

    # Call the recursive factorial function.
    jal fact            # result will be returned in $v0.

    # Print result message.
    li $v0, 4           # syscall code for print_string.
    la $a0, resultMsg   # address of the result message.
    syscall

    # Print the factorial result.
    move $a0, $v0       # move computed factorial into $a0.
    li $v0, 1           # syscall code for print_integer.
    syscall

    # Exit the program.
    li $v0, 10          # syscall code for exit.
    syscall

# Recursive factorial function.
# Input: integer in $a0.
# Output: factorial result in $v0.
fact:
    # Allocate space on the stack for two registers: return address and parameter.
    addi $sp, $sp, -8                                   {6'h8, 5'd1, 5'd2, 16'h20}
    sw   $ra, 4($sp)    # save return address.          {6'h2B, 5'd1, 5'd2, 16'h20}
    sw   $a0, 0($sp)    # save current parameter.       {6'h2B, 5'd1, 5'd2, 16'h20}

    # Base Case: If the input is 0, factorial of 0 is 1.
    beq  $a0, $zero, fact_base                          {6'h4, 5'd0, 5'd2, 16'h20}

    # Recursive Case:
    # Decrement the number in $a0 and recursively call fact.
    addi $a0, $a0, -1   # prepare argument (n - 1).     {6'h8, 5'd1, 5'd2, 16'h20}
    jal  fact           # recursive call; result returned in $v0.           {6'h3, 26'h10}

    # Retrieve the original parameter from the stack.
    lw   $a0, 0($sp)                        {6'h23, 5'd1, 5'd2, 16'h20}
    # Multiply the current number with the factorial of (n - 1).
    mul  $v0, $a0, $v0                      {6'h0, 5'd1, 5'd2, 5'd3, 5'd0, 6'h18}

    # Restore the registers and deallocate the stack frame.
    lw   $ra, 4($sp)            {6'h23, 5'd1, 5'd2, 16'h20}
    addi $sp, $sp, 8            {6'h8, 5'd1, 5'd2, 16'h20}
    jr   $ra            # return to caller.         d 0 rs 0 8

fact_base:
    # Base case return: factorial(0) = 1.
    li   $v0, 1                     {6'h8, 5'd1, 5'd2, 16'h20}
    lw   $ra, 4($sp)    # restore return address.           {6'h23, 5'd1, 5'd2, 16'h20}
    addi $sp, $sp, 8    # deallocate stack frame.           {6'h8, 5'd1, 5'd2, 16'h20}
    jr   $ra            # return to caller.                 d 0 rs 0 8
