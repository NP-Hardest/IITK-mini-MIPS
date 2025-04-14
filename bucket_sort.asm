.data
input:          .word 19, 9, 6, 2, 3, 3, 19, 10, 5, 8   # Input array
length:         .word 10                              # Array size
buckets:        .space 1040                           # 10 buckets
space:          .asciiz " "                           # Space separator
newline:        .asciiz "\n"                          # Newline

.text
main:
    # Initialize bucket counts
    la $t0, buckets
    li $t1, 0
    li $t2, 10
init_loop:
    sw $zero, 0($t0)
    addi $t0, $t0, 104
    addi $t1, $t1, 1
    blt $t1, $t2, init_loop

    # Distribute elements using subtraction-based bucket index
    la $s0, input
    lw $s1, length
    li $s2, 0

distribute_loop:
    bge $s2, $s1, end_distribute
    lw $a0, 0($s0)                # Load element
    
    # Calculate bucket index without division
    li $t1, 0                     # Bucket index counter
    move $t8, $a0                 # Element copy
    li $t9, 10                    # Comparison value
bucket_calc:
    blt $t8, $t9, end_bucket_calc
    addi $t1, $t1, 1
    addi $t8, $t8, -10
    j bucket_calc
end_bucket_calc:

    # Store element in bucket
    la $t2, buckets
    mul $t3, $t1, 104
    add $t2, $t2, $t3
    lw $t4, 0($t2)
    li $t5, 20
    bge $t4, $t5, skip_element

    addi $t6, $t2, 4
    sll $t7, $t4, 2
    add $t6, $t6, $t7
    sw $a0, 0($t6)
    addi $t4, $t4, 1
    sw $t4, 0($t2)

skip_element:
    addi $s0, $s0, 4
    addi $s2, $s2, 1
    j distribute_loop

end_distribute:
    # Sort buckets (same as before)
    la $s6, buckets
    li $t8, 0
    li $t9, 10

sort_loop:
    bge $t8, $t9, end_sort
    lw $t3, 0($s6)
    ble $t3, 1, next_bucket

    addi $a0, $s6, 4
    move $a1, $t3
    jal insertion_sort

next_bucket:
    addi $s6, $s6, 104
    addi $t8, $t8, 1
    j sort_loop

end_sort:
    # Concatenate buckets (same as before)
    la $s3, input
    li $s4, 0
    li $s5, 10
concat_loop:
    bge $s4, $s5, end_concat
    la $t0, buckets
    mul $t1, $s4, 104
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    beqz $t2, next_concat

    addi $t0, $t0, 4
    li $t3, 0
copy_loop:
    bge $t3, $t2, next_concat
    sll $t4, $t3, 2
    add $t4, $t0, $t4
    lw $t5, 0($t4)
    sw $t5, 0($s3)
    addi $s3, $s3, 4
    addi $t3, $t3, 1
    j copy_loop

next_concat:
    addi $s4, $s4, 1
    j concat_loop

end_concat:
    # Print sorted array
    la $t0, input
    lw $t1, length
    li $t2, 0
    
    li $v0, 4
    la $a0, newline
    syscall

print_loop:
    bge $t2, $t1, exit
    lw $a0, 0($t0)
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j print_loop

exit:
    li $v0, 10
    syscall

# Insertion Sort Subroutine (unchanged)
insertion_sort:
    li $t0, 1
insertion_loop:
    bge $t0, $a1, end_insertion
    sll $t1, $t0, 2
    add $t1, $a0, $t1
    lw $t2, 0($t1)
    addi $t3, $t0, -1

inner_loop:
    blt $t3, 0, end_inner
    sll $t4, $t3, 2
    add $t4, $a0, $t4
    lw $t5, 0($t4)
    ble $t5, $t2, end_inner

    addi $t6, $t4, 4
    sw $t5, 0($t6)
    addi $t3, $t3, -1
    j inner_loop

end_inner:
    addi $t3, $t3, 1
    sll $t4, $t3, 2
    add $t4, $a0, $t4
    sw $t2, 0($t4)
    addi $t0, $t0, 1
    j insertion_loop

end_insertion:
    jr $ra