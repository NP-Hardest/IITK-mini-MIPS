        .data
# Define a sample array and its size.
array:  .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0   # unsorted array
n:      .word 10                             # number of elements

        .text
        .globl main
main:
        # Load the address of the array and the size into registers.
        la    $t0, array       # $t0 holds base address of array
        li    $t1, n           # $t1 holds number of elements (n)       

        # Outer loop: iterate (n-1) passes.
        li    $t2, 0         # $t2 = outer loop index i = 0   

outer_loop:
        # Compare i with n-1; if i >= n-1, sorting is done.
        addi  $t3, $t1, -1   # $t3 = n - 1          
        bge   $t2, $t3, done_outer     

        # Initialize a flag to detect swaps during this pass.
        li    $t4, 0         # $t4 = swap flag (0 means no swap yet)    

        # Inner loop initialization: j = 0
        li    $t5, 0         # $t5 = inner loop index j         

inner_loop:
        # Calculate the limit for inner loop: j < n - 1 - i
        sub   $t6, $t1, $t2  # $t6 = n - i                
        addi  $t6, $t6, -1   # $t6 = n - i - 1            
        bge   $t5, $t6, inner_loop_end             

        # Calculate the address for array[j]: base + j*4
        sll   $t8, $t5, 2    # $t8 = j * 4 (word offset)        
        add   $t7, $t0, $t8  # $t7 = address of array[j]          
        lw    $t9, 0($t7)    # load array[j] into $t9    

        # Load array[j+1] (next element)
        lw    $s7, 4($t7)   # load array[j+1] into $s7        

        # Compare array[j] and array[j+1]. If out of order, swap.
        ble   $t9, $s7, no_swap  # if array[j] <= array[j+1], skip swap    

        # Swap elements: store $s7 in array[j] and $t9 in array[j+1].
        sw    $s7, 0($t7)       
        sw    $t9, 4($t7)       
        li    $t4, 1         # set flag to indicate a swap occurred           

no_swap:
        addi  $t5, $t5, 1    # increment inner loop index (j)          
        j     inner_loop                 

inner_loop_end:
        # If no swaps occurred in this entire pass, the array is sorted.
        beq   $t4, $zero, done_outer              

        addi  $t2, $t2, 1    # increment outer loop index (i)          
        j     outer_loop         

done_outer:
        # Exit the program.
        li    $v0, 10          
        syscall



        
