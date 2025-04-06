        .data
# Define a sample array and its size.
array:  .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0   # unsorted array
n:      .word 10                             # number of elements

        .text
        .globl main
main:
        # Load the address of the array and the size into registers.
        la    $t0, array       # $t0 holds base address of array
        li    $t1, n           # $t1 holds number of elements (n)       #{6'h8, 5'd0, 5'd9, 16'd10}

        # Outer loop: iterate (n-1) passes.
        li    $t2, 0         # $t2 = outer loop index i = 0    #use addi {6'h8, 5'd0, 5'd9, 16'd0}

outer_loop:
        # Compare i with n-1; if i >= n-1, sorting is done.
        addi  $t3, $t1, -1   # $t3 = n - 1          {6'h8, 5'd9, 5'd11, -16'd1}
        bge   $t2, $t3, done_outer      {6'h12, 5'd0, 5'd2, 16'h20}//

        # Initialize a flag to detect swaps during this pass.
        li    $t4, 0         # $t4 = swap flag (0 means no swap yet)    addi{6'h8, 5'd0, 5'd12, 16'd0}

        # Inner loop initialization: j = 0
        li    $t5, 0         # $t5 = inner loop index j         addi{6'h8, 5'd0, 5'd13, 16'd0}

inner_loop:
        # Calculate the limit for inner loop: j < n - 1 - i
        sub   $t6, $t1, $t2  # $t6 = n - i                  {6'h0, 5'd9, 5'd10, 5'd14, 5'd0, 6'h22}
        addi  $t6, $t6, -1   # $t6 = n - i - 1              {6'h8, 5'd14, 5'd14, -16'd1}
        bge   $t5, $t6, inner_loop_end              {6'h12, 5'd13, 5'd14, 16'h20}//

        # Calculate the address for array[j]: base + j*4
        sll   $t8, $t5, 2    # $t8 = j * 4 (word offset)        {6'h0, 5'd24, 5'd2, 5'd13, 5'd2, 6'h0}
        add   $t7, $t0, $t8  # $t7 = address of array[j]             {6'h0, 5'd8, 5'd24, 5'd15, 5'd0, 6'h20}
        lw    $t9, 0($t7)    # load array[j] into $t9       {6'h23, 5'd15, 5'd25, 16'h0}

        # Load array[j+1] (next element)
        lw    $s7, 4($t7)   # load array[j+1] into $s7        {6'h23, 5'd15, 5'd23, 16'h4}

        # Compare array[j] and array[j+1]. If out of order, swap.
        ble   $t9, $s7, no_swap  # if array[j] <= array[j+1], skip swap         {6'h14, 5'd25, 5'd23, 16'h20}// 

        # Swap elements: store $s7 in array[j] and $t9 in array[j+1].
        sw    $s7, 0($t7)          {6'h2B, 5'd15, 5'd23, 16'h0}
        sw    $t9, 4($t7)           {6'h2B, 5'd25, 5'd23, 16'h4}
        li    $t4, 1         # set flag to indicate a swap occurred             addi{6'h8, 5'd0, 5'd12, 16'h1}

no_swap:
        addi  $t5, $t5, 1    # increment inner loop index (j)              {6'h8, 5'd13, 5'd13, 16'h1}
        j     inner_loop                    {6'h2, 26'h10}//

inner_loop_end:
        # If no swaps occurred in this entire pass, the array is sorted.
        beq   $t4, $zero, done_outer                 {6'h4, 5'd12, 5'd0, 16'h20}//

        addi  $t2, $t2, 1    # increment outer loop index (i)            {6'h8, 5'd10, 5'd10, 16'h1}
        j     outer_loop                {6'h2, 26'h10}//

done_outer:
        # Exit the program.
        li    $v0, 10               {6'h8, 5'd1, 5'd2, 16'h20}
        syscall
