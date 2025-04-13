`timescale 1ns / 1ps

module fp_comparator_tb;
  // Testbench signals to drive the inputs to the comparator and capture outputs.
  reg  [31:0] a, b;
  wire        eq, lt, gt, le, ge;

  // Instantiate the floating point comparator module.
  fp_comparator uut (
    .a(a),
    .b(b),
    .eq(eq),
    .lt(lt),
    .gt(gt),
    .le(le),
    .ge(ge)
  );

  initial begin
    // Display column header
    $display("Time\t     a\t     b\t | eq lt gt le ge");
    $monitor("%g\t%h\t%h\t | %b  %b  %b  %b  %b", $time, a, b, eq, lt, gt, le, ge);

    // Test Case 1: Compare 1.0 and 2.0
    // 1.0 in IEEE-754: 3F800000, 2.0 in IEEE-754: 40000000
    a = 32'h3F800000; b = 32'h40000000;
    #10;
    
    // Test Case 2: Compare 2.0 and 1.0
    a = 32'h40000000; b = 32'h3F800000;
    #10;
    
    // Test Case 3: Compare 1.0 and 1.0
    a = 32'h3F800000; b = 32'h3F800000;
    #10;
    
    // Test Case 4: Compare -1.0 and 1.0
    // -1.0 in IEEE-754: BF800000, 1.0: 3F800000
    a = 32'hBF800000; b = 32'h3F800000;
    #10;
    
    // Test Case 5: Compare -2.0 and -1.0
    // -2.0 in IEEE-754: C0000000, -1.0: BF800000
    a = 32'hC0000000; b = 32'hBF800000;
    #10;
    
    // Test Case 6: Compare -1.0 and -2.0 (reverse of above)
    a = 32'hBF800000; b = 32'hC0000000;
    #10;
    
    // Test Case 7: Compare numbers with different fractional parts, e.g., 1.5 vs. 1.25
    // 1.5 in IEEE-754: 3FC00000, 1.25 in IEEE-754: 3F980000
    a = 32'h3FC00000; b = 32'h3F980000;
    #10;
    
    $finish;
  end
  
endmodule
