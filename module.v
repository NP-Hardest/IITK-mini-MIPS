`include "alu.v"
`include "mux.v"
`include "instruction_decode.v"
`include "register_file.v"
`include "control.v"
`include "memory.v"

module hahaha(instruction, clk);

    input [31:0] instruction;
    input clk;

    wire [4:0] rs, rt, rd, shamt;
    wire [5:0] opcode, funct;
    wire [31:0] imm;
    wire [25:0] addr;
    wire branch_yes, overflow, ALU_zero, write_enable, mem_read, mem_write, mem_to_reg, second_select;
    wire [1:0] type, mul;


    reg [31:0] PC;


    wire [4:0] ALUCtrl;

    wire [31:0] read_address_1, read_address_2, write_address, write_data, immediate_value;

    wire [31:0] ALU_in_1, ALU_in_2, read_data_2, ALU_out, ALU_out_2;

    wire instruction_write_enable;

    wire [31:0] instruction_read_address, data_read_address, instruction_write_address, data_write_address, instruction_data_in, data_data_in, instruction_data_out, data_memory_out, reg_file_write_in_1, reg_file_write_in_2;


    
    instruction_decode uut4(instruction, rs, rt, rd, shamt, funct, imm, addr, type, opcode);

    control uut3(opcode, funct, type, ALUCtrl, rs, rt, rd, read_address_1, read_address_2, shamt, imm, branch_yes, write_enable, mem_read, mem_write, mem_to_reg, immediate_value, mul, second_select);

    mux uut8 ({27'b0, rd}, {27'b0, rt}, type, write_address);

    register_file uu1(clk, write_enable, read_address_1, read_address_2, write_address, ALU_in_1, read_data_2, reg_file_write_in_1, ALU_out_2, mul);

    mux uut5(read_data_2, immediate_value, {1'b0, second_select}, ALU_in_2);

    ALU uut2(ALUCtrl, ALU_in_1, ALU_in_2, ALU_out, ALU_out_2, ALU_zero, overflow);

    mux uut6(ALU_out, data_memory_out , {1'b0, mem_to_reg}, reg_file_write_in_1);

    memory data_memory(clk, mem_write, ALU_out, ALU_out, read_data_2, data_memory_out);


    always @ (posedge clk) begin
        if(type == 2'd2) begin 
            // JUMP
        end
        if (branch_yes && !ALU_zero) PC <= PC + 1 + imm;
        else PC <= PC + 1;

    end

    
endmodule