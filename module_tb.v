`timescale 1ns/1ps

module tb_hahaha;
    reg [31:0] instruction;
    reg clk, rst;
    
    hahaha uut (clk, rst);

    
    initial begin
        clk <= 0;
        forever #10 clk <= ~clk; 
    end


    initial begin
        rst <= 1;
        #20;
        rst <= 0;
        #18000;

        $display("time : %t",$time);
        $display("GPRs:");
        $display("$0:  %d, $1:  %d, $2:  %d, $3:  %d, ", uut.reg_file.GPR[0], uut.reg_file.GPR[1], uut.reg_file.GPR[2], uut.reg_file.GPR[3]);
        $display("$4:  %d, $5:  %d, $6:  %d, $7:  %d, ", uut.reg_file.GPR[4], uut.reg_file.GPR[5], uut.reg_file.GPR[6], uut.reg_file.GPR[7]);
        $display("$8:  %d, $9:  %d, $10: %d, $11: %d, ", uut.reg_file.GPR[8], uut.reg_file.GPR[9], uut.reg_file.GPR[10], uut.reg_file.GPR[11]);
        $display("$12: %d, $13: %d, $14: %d, $15: %d, ", uut.reg_file.GPR[12], uut.reg_file.GPR[13], uut.reg_file.GPR[14], uut.reg_file.GPR[15]);
        $display("$16: %d, $17: %d, $18: %d, $19: %d, ", uut.reg_file.GPR[16], uut.reg_file.GPR[17], uut.reg_file.GPR[18], uut.reg_file.GPR[19]);
        $display("$20: %d, $21: %d, $22: %d, $23: %d, ", uut.reg_file.GPR[20], uut.reg_file.GPR[21], uut.reg_file.GPR[22], uut.reg_file.GPR[23]);
        $display("$24: %d, $25: %d, $26: %d, $27: %d, ", uut.reg_file.GPR[24], uut.reg_file.GPR[25], uut.reg_file.GPR[26], uut.reg_file.GPR[27]);
        $display("$28: %d, $29: %d, $30: %d, $31: %d, ", uut.reg_file.GPR[28], uut.reg_file.GPR[29], uut.reg_file.GPR[30], uut.reg_file.GPR[31]);
        
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


