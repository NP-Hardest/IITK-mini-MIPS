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
        instruction = {6'h0, 5'd1, 5'd2, 5'd3, 5'd0, 6'h20};
        // instruction = {6'hF, 5'b00000, 5'd11, 16'd1000};    //lui
        #20;
        $display("R0 = %h", uut.uu1.GPR[3]);
        $display("R0 = %h", uut.uu1.GPR[2]);
        $display("R0 = %h", uut.uu1.GPR[1]);
        #10
        instruction = {6'h0, 5'd3, 5'd2, 5'd3, 5'd0, 6'h18};
        #30;
        $display("R0 = %b", uut.uu1.lo);
        #30;
        instruction = {6'h1D, 5'd3, 5'd2, 5'd3, 5'd0, 6'h0};
        #30;
        
        $display("R0 = %b", uut.uu1.lo);
        // $display("R0 = %b", uut.uu1.GPR[3]);
        // $display("R0 = %b", uut.uu1.GPR[2]);
        // $display("R0 = %b", uut.uu1.GPR[1]);
        // $display("R1 = %h", uut.data_memory.mem[3]);
        // $display("R2 = %d", uut.uu1.GPR[11]);
        // instruction = {6'h23, 5'd2, 5'd14, 16'd10};
        $finish;
    end
endmodule
