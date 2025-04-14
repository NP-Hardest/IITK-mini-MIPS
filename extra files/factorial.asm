# MIPS Program to compute factorial of n
# Input:  $a0 = n (non-negative integer)
# Output: $v0 = n!

    .data
newline: .asciiz "\n"

    .text
    .globl main

main:   
    li $a0, 6           {6'h8, 5'd0, 5'd4, 6'h6}

    li $v0, 1          {6'h8, 5'd0, 5'd2, 6'h1}
    li $t0, 1          {6'h8, 5'd0, 5'd8, 6'h1}

factorial_loop:
    ble $a0, $zero, done      {6'h14, 5'd4, 5'd0, 16'h20} 
    mul $v0, $a0         {6'h0, 5'd2, 5'd4, 5'd0, 5'd0, 6'h28}
    addi $v0, $LO, 0     {6'h8, 5'd27, 5'd4, 6'h0}
    addi $a0, $a0, -1        {6'h8, 5'd, 5'd4, 6'h0}
    j factorial_loop

done:
    # Print the result
    move $a0, $v0
    li $v0, 1
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall



.data
newline: .asciiz "\n"

.text
.globl main

main:
    li $a0, 5         {6'h8, 5'd0, 5'd4, 6'h6}
    jal factorial     {6'h3, 26'h10}
    move $a0, $v0     {6'h8, 5'd2, 5'd4, 6'h0}
    li $v0, 1          # Print integer
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall

# Recursive factorial function
# Input:  $a0 = n
# Output: $v0 = n!

factorial:
    addi $sp, $sp, -8     {6'h8, 5'd29, 5'd29, -16'h2}
    sw $ra, 4($sp)        {6'h2B, 5'd29, 5'd31, 16'h1}
    sw $a0, 0($sp)        {6'h2B, 5'd29, 5'd4, 16'h0}
    li $s0, 1             {6'h8, 5'd0, 5'd16, 16'h1}

    ble $a0, $s0, base_case  {6'h14, 5'd4, 5'd16, 16'h20} 

    addi $a0, $a0, -1      {6'h8, 5'd0, 5'd16, -16'h1}
    jal factorial          {6'h3, 26'h10}
    lw $a0, 0($sp)         {6'h23, 5'd29, 5'd4, 16'h0}
    mul $v0, $a0         {6'h0, 5'd2, 5'd4, 5'd0, 5'd0, 6'h28}
    addi $v0, $LO, 0     {6'h8, 5'd27, 5'd4, 6'h0}

    lw $ra, 4($sp)         {6'h23, 5'd29, 5'd31, 16'h1}
    addi $sp, $sp, 8        {6'h8, 5'd29, 5'd29, 16'h2}
    jr $ra                 {6'h1, 5'd31, 21'd0}

base_case:
    li $v0, 1             {6'h8, 5'd0, 5'd2, 16'h1}
    lw $ra, 4($sp)        {6'h23, 5'd29, 5'd31, 16'h1}
    addi $sp, $sp, 8       {6'h8, 5'd29, 5'd29, 16'h2}
    jr $ra                {6'h1, 5'd31, 21'd0}
