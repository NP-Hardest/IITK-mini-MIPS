`include "alu.v"
`include "mux.v"
`include "instruction_decode.v"
`include "register_file.v"
`include "control.v"

module hahaha(instruction, clk);

    input [31:0] instruction;
    input clk;

    wire [4:0] rs, rt, rd, shamt;
    wire [5:0] opcode, funct;
    wire [31:0] imm;
    wire [25:0] addr;
    wire branch_yes, overflow, ALU_zero, write_enable, second_read;
    wire [1:0] type;


    reg [31:0] PC;


    wire [4:0] ALUCtrl;

    wire [31:0] read_address_1, second_input, write_address, write_data;

    wire [31:0] ALU_in_1, ALU_in_2, read_data_2, ALU_out, ALU_out_2;


    
    instruction_decode uut4(instruction, rs, rt, rd, shamt, funct, imm, addr, type, opcode);

    control uut3(opcode, funct, type, ALUCtrl, rs, rt, rd, read_address_1, second_input, shamt, imm, branch_yes, second_read, write_enable);

    mux uut8 ({27'b0, rd}, {27'b0, rt}, type, write_address);

    register_file uu1(clk, write_enable, second_read, read_address_1, second_input, write_address, ALU_in_1, read_data_2, ALU_out);

    mux uut5(read_data_2, second_input, type, ALU_in_2);

    ALU uut2(ALUCtrl, ALU_in_1, ALU_in_2, ALU_out, ALU_out_2, ALU_zero, overflow);

    always @ (posedge clk) begin
        if(type == 2'd2) begin 
            // JUMP
        end
        if (branch_yes && !ALU_zero) PC <= PC + 1 + imm;
        else PC <= PC + 1;

    end

    
endmodule