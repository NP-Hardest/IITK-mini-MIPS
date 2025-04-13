`timescale 1ns/1ps

module tb_processor;
    reg [31:0] instruction;
    reg clk, rst;
    reg [31:0] inst_data_in, inst_addr;
    reg [31:0] mem_data_in, mem_addr;
    
    processor uut (clk, rst, inst_data_in, inst_addr, mem_data_in, mem_addr);

    
    initial begin
        clk <= 0;
        forever #10 clk <= ~clk; 
    end


    initial begin
        rst <= 1;

        #20 inst_data_in <= {6'h8, 5'd0, 5'd8, 16'd1};      inst_addr <= 0;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd9, 16'd10};     inst_addr <= 1;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd10, 16'd0};     inst_addr <= 2;
        #20 inst_data_in <= {6'h8, 5'd9, 5'd11, -16'd1};            inst_addr <= 3;
        #20 inst_data_in <= {6'h12, 5'd10, 5'd11, 16'd17};        inst_addr <= 4;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd12, 16'd0};     inst_addr <= 5;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd13, 16'd0};     inst_addr <= 6;
        #20 inst_data_in <= {6'h0, 5'd9, 5'd10, 5'd14, 5'd0, 6'h22};       inst_addr <= 7;
        #20 inst_data_in <= {6'h8, 5'd14, 5'd14, -16'd1};       inst_addr <= 8;
        #20 inst_data_in <= {6'h12, 5'd13, 5'd14, 16'd9};    inst_addr <= 9;
        #20 inst_data_in = {6'h0, 5'd8, 5'd13, 5'd15, 5'd0, 6'h20};        inst_addr <= 10;
        #20 inst_data_in = {6'h23, 5'd15, 5'd25, 16'h0};       inst_addr <= 11;
        #20 inst_data_in = {6'h23, 5'd15, 5'd23, 16'h1};       inst_addr <= 12;
        #20 inst_data_in = {6'h14, 5'd25, 5'd23, 16'd3};     inst_addr <= 13;
        #20 inst_data_in = {6'h2B, 5'd15, 5'd23, 16'd0};       inst_addr <= 14;
        #20 inst_data_in = {6'h2B, 5'd15, 5'd25, 16'd1};       inst_addr <= 15;
        #20 inst_data_in = {6'h8, 5'd0, 5'd12, 16'h1};     inst_addr <= 16;
        #20 inst_data_in = {6'h8, 5'd13, 5'd13, 16'h1};        inst_addr <= 17;
        #20 inst_data_in = {6'h2, 26'h7};        inst_addr <= 18;
        #20 inst_data_in = {6'h4, 5'd12, 5'd0, 16'h2};       inst_addr <= 19;
        #20 inst_data_in = {6'h8, 5'd10, 5'd10, 16'h1};        inst_addr <= 20;
        #20 inst_data_in = {6'h2, 26'h3};                    inst_addr <= 21;
        #20 inst_data_in = {6'h8, 5'd1, 5'd2, 16'h20};     inst_addr <= 22;

        #20 mem_addr <= 1 ; mem_data_in <= 4; 
        #20 mem_addr <= 2 ; mem_data_in <= 2; 
        #20 mem_addr <= 3 ; mem_data_in <= 9; 
        #20 mem_addr <= 4 ; mem_data_in <= 0; 
        #20 mem_addr <= 5 ; mem_data_in <= 3; 
        #20 mem_addr <= 6 ; mem_data_in <= 3; 
        #20 mem_addr <= 7 ; mem_data_in <= 7; 
        #20 mem_addr <= 8 ; mem_data_in <= 10; 
        #20 mem_addr <= 9 ; mem_data_in <= 5; 
        #20 mem_addr <= 10 ; mem_data_in <= 8; 

        #30;
        rst <= 0;
      #8000;

        $display("time : %t",$time);
        $display("GPRs:");
        $display("$0:  %d, $1:  %d, $2:  %d, $3:  %d, ", uut.reg_file.GPR[0], uut.reg_file.GPR[1], uut.reg_file.GPR[2], uut.reg_file.GPR[3]);
        $display("$4:  %d, $5:  %d, $6:  %d, $7:  %d, ", uut.reg_file.GPR[4], uut.reg_file.GPR[5], uut.reg_file.GPR[6], uut.reg_file.GPR[7]);
        $display("$8:  %d, $9:  %d, $10: %d, $11: %d, ", uut.reg_file.GPR[8], uut.reg_file.GPR[9], uut.reg_file.GPR[10], uut.reg_file.GPR[11]);
        $display("$12: %d, $13: %d, $14: %d, $15: %h, ", uut.reg_file.GPR[12], uut.reg_file.GPR[13], uut.reg_file.GPR[14], uut.reg_file.GPR[15]);
        $display("$16: %d, $17: %d, $18: %d, $19: %d, ", uut.reg_file.GPR[16], uut.reg_file.GPR[17], uut.reg_file.GPR[18], uut.reg_file.GPR[19]);
        $display("$20: %d, $21: %d, $22: %d, $23: %d, ", uut.reg_file.GPR[20], uut.reg_file.GPR[21], uut.reg_file.GPR[22], uut.reg_file.GPR[23]);
        $display("$24: %d, $25: %d, $26: %d, $27: %d, ", uut.reg_file.GPR[24], uut.reg_file.GPR[25], uut.reg_file.GPR[26], uut.reg_file.GPR[27]);
        $display("$28: %d, $29: %d, $30: %d, $31: %d, ", uut.reg_file.GPR[28], uut.reg_file.GPR[29], uut.reg_file.GPR[30], uut.reg_file.GPR[31]);
        
        $display("FPRs:");
        $display("$0:  %h, $1:  %h, $2:  %h, $3:  %h, ", uut.reg_file.FPR[0], uut.reg_file.FPR[1], uut.reg_file.FPR[2], uut.reg_file.FPR[3]);
        $display("$4:  %h, $5:  %h, $6:  %h, $7:  %h, ", uut.reg_file.FPR[4], uut.reg_file.FPR[5], uut.reg_file.FPR[6], uut.reg_file.FPR[7]);
        $display("$8:  %h, $9:  %h, $10: %h, $11: %h, ", uut.reg_file.FPR[8], uut.reg_file.FPR[9], uut.reg_file.FPR[10], uut.reg_file.FPR[11]);
        $display("$12: %h, $13: %h, $14: %h, $15: %h, ", uut.reg_file.FPR[12], uut.reg_file.FPR[13], uut.reg_file.FPR[14], uut.reg_file.FPR[15]);
        $display("$16: %h, $17: %h, $18: %h, $19: %h, ", uut.reg_file.FPR[16], uut.reg_file.FPR[17], uut.reg_file.FPR[18], uut.reg_file.FPR[19]);
        $display("$20: %h, $21: %h, $22: %h, $23: %h, ", uut.reg_file.FPR[20], uut.reg_file.FPR[21], uut.reg_file.FPR[22], uut.reg_file.FPR[23]);
        $display("$24: %h, $25: %h, $26: %h, $27: %h, ", uut.reg_file.FPR[24], uut.reg_file.FPR[25], uut.reg_file.FPR[26], uut.reg_file.FPR[27]);
        $display("$28: %h, $29: %h, $30: %h, $31: %h, ", uut.reg_file.FPR[28], uut.reg_file.FPR[29], uut.reg_file.FPR[30], uut.reg_file.FPR[31]);
        
        $display("Data Memory:");
        $display("$memory[0]:  %d, $memory[1]:  %d, $memory[2]:  %d, $memory[3]:  %d, ", uut.data_memory.mem[0], uut.data_memory.mem[1], uut.data_memory.mem[2], uut.data_memory.mem[3]);
        $display("$memory[4]:  %d, $memory[5]:  %d, $memory[6]:  %d, $memory[7]:  %d, ", uut.data_memory.mem[4], uut.data_memory.mem[5], uut.data_memory.mem[6], uut.data_memory.mem[7]);
        $display("$memory[8]:  %d, $memory[9]:  %d, $memory[10]: %d, $memory[11]: %d, ", uut.data_memory.mem[8], uut.data_memory.mem[9], uut.data_memory.mem[10], uut.data_memory.mem[11]);
        $display("$memory[12]: %d, $memory[13]: %d, $memory[14]: %d, $memory[15]: %d, ", uut.data_memory.mem[12], uut.data_memory.mem[13], uut.data_memory.mem[14], uut.data_memory.mem[15]);
        $display("$memory[16]: %d, $memory[17]: %d, $memory[18]: %d, $memory[19]: %d, ", uut.data_memory.mem[16], uut.data_memory.mem[17], uut.data_memory.mem[18], uut.data_memory.mem[19]);
        $display("$memory[20]: %d, $memory[21]: %d, $memory[22]: %d, $memory[23]: %d, ", uut.data_memory.mem[20], uut.data_memory.mem[21], uut.data_memory.mem[22], uut.data_memory.mem[23]);
        $display("$memory[24]: %d, $memory[25]: %d, $memory[26]: %d, $memory[27]: %d, ", uut.data_memory.mem[24], uut.data_memory.mem[25], uut.data_memory.mem[26], uut.data_memory.mem[27]);
        $display("$memory[28]: %d, $memory[29]: %d, $memory[30]: %d, $memory[31]: %d, ", uut.data_memory.mem[28], uut.data_memory.mem[29], uut.data_memory.mem[30], uut.data_memory.mem[31]);
        $display("\n");

        $finish;
    end
    always @ (posedge clk) begin

        // $display("time : %t",$time);
        // $display("GPRs:");
        // $display("$0:  %d, $1:  %d, $2:  %d, $3:  %d, ", uut.reg_file.GPR[0], uut.reg_file.GPR[1], uut.reg_file.GPR[2], uut.reg_file.GPR[3]);
        // $display("$4:  %d, $5:  %d, $6:  %d, $7:  %d, ", uut.reg_file.GPR[4], uut.reg_file.GPR[5], uut.reg_file.GPR[6], uut.reg_file.GPR[7]);
        // $display("$8:  %d, $9:  %d, $10: %d, $11: %d, ", uut.reg_file.GPR[8], uut.reg_file.GPR[9], uut.reg_file.GPR[10], uut.reg_file.GPR[11]);
        // $display("$12: %d, $13: %d, $14: %d, $15: %d, ", uut.reg_file.GPR[12], uut.reg_file.GPR[13], uut.reg_file.GPR[14], uut.reg_file.GPR[15]);
        // $display("$16: %d, $17: %d, $18: %d, $19: %d, ", uut.reg_file.GPR[16], uut.reg_file.GPR[17], uut.reg_file.GPR[18], uut.reg_file.GPR[19]);
        // $display("$20: %d, $21: %d, $22: %d, $23: %d, ", uut.reg_file.GPR[20], uut.reg_file.GPR[21], uut.reg_file.GPR[22], uut.reg_file.GPR[23]);
        // $display("$24: %d, $25: %d, $26: %d, $27: %d, ", uut.reg_file.GPR[24], uut.reg_file.GPR[25], uut.reg_file.GPR[26], uut.reg_file.GPR[27]);
        // $display("$28: %d, $29: %d, $30: %d, $31: %d, ", uut.reg_file.GPR[28], uut.reg_file.GPR[29], uut.reg_file.GPR[30], uut.reg_file.GPR[31]);
        
        // $display("Data Memory:");
        // $display("$memory[0]:  %d, $memory[1]:  %d, $memory[2]:  %d, $memory[3]:  %d, ", uut.data_memory.mem[0], uut.data_memory.mem[1], uut.data_memory.mem[2], uut.data_memory.mem[3]);
        // $display("$memory[4]:  %d, $memory[5]:  %d, $memory[6]:  %d, $memory[7]:  %d, ", uut.data_memory.mem[4], uut.data_memory.mem[5], uut.data_memory.mem[6], uut.data_memory.mem[7]);
        // $display("$memory[8]:  %d, $memory[9]:  %d, $memory[10]: %d, $memory[11]: %d, ", uut.data_memory.mem[8], uut.data_memory.mem[9], uut.data_memory.mem[10], uut.data_memory.mem[11]);
        // $display("$memory[12]: %d, $memory[13]: %d, $memory[14]: %d, $memory[15]: %d, ", uut.data_memory.mem[12], uut.data_memory.mem[13], uut.data_memory.mem[14], uut.data_memory.mem[15]);
        // $display("$memory[16]: %d, $memory[17]: %d, $memory[18]: %d, $memory[19]: %d, ", uut.data_memory.mem[16], uut.data_memory.mem[17], uut.data_memory.mem[18], uut.data_memory.mem[19]);
        // $display("$memory[20]: %d, $memory[21]: %d, $memory[22]: %d, $memory[23]: %d, ", uut.data_memory.mem[20], uut.data_memory.mem[21], uut.data_memory.mem[22], uut.data_memory.mem[23]);
        // $display("$memory[24]: %d, $memory[25]: %d, $memory[26]: %d, $memory[27]: %d, ", uut.data_memory.mem[24], uut.data_memory.mem[25], uut.data_memory.mem[26], uut.data_memory.mem[27]);
        // $display("$memory[28]: %d, $memory[29]: %d, $memory[30]: %d, $memory[31]: %d, ", uut.data_memory.mem[28], uut.data_memory.mem[29], uut.data_memory.mem[30], uut.data_memory.mem[31]);
        // $display("\n");
    end
endmodule


