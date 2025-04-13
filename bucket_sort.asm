.data
input:          .word 5, 3, 8, 2, 9, 1, 7, 4, 0, 6   # Example input array
length:         .word 10                              # Number of elements
buckets:        .space 4040                           # 10 buckets * (4 + 100*4) bytes

.text
main:
    # Initialize bucket counts to zero
    la $t0, buckets               # Load buckets address
    li $t1, 0                     # Initialize counter
    li $t2, 10                    # Number of buckets
init_loop:
    sw $zero, 0($t0)              # Set bucket count to 0
    addi $t0, $t0, 10            # Move to next bucket
    addi $t1, $t1, 1              # Increment counter
    blt $t1, $t2, init_loop       # Loop until all buckets initialized

    # Distribute elements into buckets
    la $s0, input                 # Load input array address
    lw $s1, length                # Load array length
    li $s2, 0                     # Initialize counter
distribute_loop:
    bge $s2, $s1, end_distribute  # Exit loop when all elements processed
    lw $a0, 0($s0)                # Load current element
    li $t0, 10                    
    div $a0, $t0                  # Divide element by 10 (bucket index in LO)
    mflo $t1                      # Get bucket index

    la $t2, buckets               # Load base bucket address
    mul $t3, $t1, 404             # Calculate bucket offset
    add $t2, $t2, $t3             # Get current bucket address
    lw $t4, 0($t2)                # Load bucket count
    li $t5, 100                   # Max elements per bucket
    bge $t4, $t5, skip_element    # Skip if bucket is full

    addi $t6, $t2, 4              # Get element storage address
    sll $t7, $t4, 2               # Calculate element offset
    add $t6, $t6, $t7             # Get target address
    sw $a0, 0($t6)                # Store element in bucket
    addi $t4, $t4, 1              # Increment bucket count
    sw $t4, 0($t2)                # Update bucket count

skip_element:
    addi $s0, $s0, 4             # Move to next element
    addi $s2, $s2, 1             # Increment counter
    j distribute_loop

end_distribute:

    # Sort each bucket using insertion sort
    la $t0, buckets               # Load buckets address
    li $t1, 0                     # Initialize counter
    li $t2, 10                    # Number of buckets
sort_loop:
    bge $t1, $t2, end_sort        # Exit when all buckets sorted
    lw $t3, 0($t0)                # Load bucket count
    ble $t3, 1, next_bucket       # Skip sorting if ≤1 element

    addi $a0, $t0, 4              # Set array address argument
    move $a1, $t3                 # Set array size argument
    jal insertion_sort            # Sort the bucket

next_bucket:
    addi $t0, $t0, 404           # Move to next bucket
    addi $t1, $t1, 1             # Increment counter
    j sort_loop

end_sort:

    # Concatenate buckets back into original array
    la $s3, input                 # Load input array address
    li $s4, 0                     # Initialize bucket counter
    li $s5, 10                    # Total buckets
concat_loop:
    bge $s4, $s5, end_concat      # Exit when all buckets processed
    la $t0, buckets               # Load base bucket address
    mul $t1, $s4, 404             # Calculate bucket offset
    add $t0, $t0, $t1             # Get current bucket address
    lw $t2, 0($t0)                # Load bucket count
    beqz $t2, next_concat         # Skip empty buckets

    addi $t0, $t0, 4              # Get elements address
    li $t3, 0                     # Initialize element counter
copy_loop:
    bge $t3, $t2, next_concat     # Exit when all elements copied
    sll $t4, $t3, 2               # Calculate element offset
    add $t4, $t0, $t4             # Get element address
    lw $t5, 0($t4)               # Load element
    sw $t5, 0($s3)               # Store in original array
    addi $s3, $s3, 4             # Move to next position
    addi $t3, $t3, 1             # Increment element counter
    j copy_loop

next_concat:
    addi $s4, $s4, 1             # Move to next bucket
    j concat_loop

end_concat:
    # Exit program
    li $v0, 10
    syscall




insertion_sort:
    li $t0, 1                     # i = 1
insertion_loop:
    bge $t0, $a1, end_insertion   # Exit when array sorted
    sll $t1, $t0, 2              # Calculate element offset
    add $t1, $a0, $t1            # Get current element address
    lw $t2, 0($t1)               # Load current element (key)
    addi $t3, $t0, -1            # j = i - 1

inner_loop:
    blt $t3, 0, end_inner        # Exit when position found
    sll $t4, $t3, 2              # Calculate comparison element offset
    add $t4, $a0, $t4            # Get comparison element address
    lw $t5, 0($t4)               # Load comparison element
    ble $t5, $t2, end_inner      # Exit if element <= key

    addi $t6, $t4, 4             # Get next position address
    sw $t5, 0($t6)               # Move element forward
    addi $t3, $t3, -1            # Decrement j
    j inner_loop

end_inner:
    addi $t3, $t3, 1             # Correct insertion position
    sll $t4, $t3, 2              # Calculate insertion offset
    add $t4, $a0, $t4            # Get insertion address
    sw $t2, 0($t4)               # Store key in correct position
    addi $t0, $t0, 1             # Increment i
    j insertion_loop

end_insertion:
    jr $ra                       # Return to caller