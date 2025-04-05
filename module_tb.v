`timescale 1ns/1ps

module tb_hahaha;
    reg [31:0] instruction;
    reg clk;
    
    hahaha uut (
        .instruction(instruction),
        .clk(clk)
    );
    
    initial begin
        clk <= 0;
        forever #5 clk <= ~clk; 
    end


    initial begin
        #2;
        instruction = {6'h8, 5'b00001, 5'b00010, 16'd1000};
        #50;
            #20; // Wait for a few cycles so the registers are updated
    $display("R0 = %h", uut.uu1.GPR[0]);
    $display("R1 = %h", uut.uu1.GPR[1]);
    $display("R2 = %h", uut.uu1.GPR[2]);
        $display("Test finished.");
        $finish;
    end
endmodule
