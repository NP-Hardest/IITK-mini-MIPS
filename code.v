`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/26/2025 02:37:27 PM
// Design Name:
// Module Name: code
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module code(clk, rst, done);
    input clk, rst;
    output done;

    reg [31:0] GPR [31:0];

    reg [31:0] instruction_memory [1000:0];

    // GPR[0] is $zero
    // GPR[1] is $at
    // GPR[3:2] are $v0, $v1
    // GPR[7:4] are $a0, $a3
    // GPR[]

    reg [31:0] FPR [31:0];

    wire [31:0] PC; // program counter register

    reg state;
    reg counter;

    assign PC = instruction_memory[counter];

//    parameter FETCH = 0;
//    parameter DECODE = 1;
//    parameter EXECUTE = 2;
//    parameter READ = 3;
//    parameter WRITE = 4;

    always @(posedge clk or posedge rst) begin
         counter <= counter + 1;

    end

endmodule