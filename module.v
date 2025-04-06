`include "alu.v"
`include "mux.v"
`include "instruction_decode.v"
`include "register_file.v"
`include "control.v"
`include "memory.v"
`include "pcHandle.v"

module hahaha(clk, rst);

    input clk, rst;

    memory data_memory(clk, mem_write, ALU_out, ALU_out, read_data_2, data_memory_out);
    inst_memory inst_memory(clk, inst_write_enable, PC, inst_write_address, inst_data_in, inst_data_out);

    reg [31:0] PC;
    wire [31:0] instruction = inst_data_out;

    wire [4:0] rs, rt, rd, shamt;
    wire [5:0] opcode, funct;
    wire [31:0] imm;
    wire [25:0] addr;
    wire branch_yes, overflow, ALU_zero, write_enable, mem_read, mem_write, mem_to_reg, second_select, jump, we;
    wire [1:0] type, mul;




    wire [4:0] ALUCtrl;

    wire [31:0] read_address_1, read_address_2, write_address, write_data, immediate_value;

    wire [31:0] ALU_in_1, ALU_in_2, read_data_2, ALU_out, ALU_out_2;

    wire instruction_write_enable;

    wire [31:0] rs_in;

    wire [31:0] instruction_read_address, data_read_address, instruction_write_address, data_write_address, instruction_data_in, data_data_in, instruction_data_out, data_memory_out, reg_file_write_in_1, reg_file_write_in_2;


    
    instruction_decode uut4(instruction, rs, rt, rd, shamt, funct, imm, addr, type, opcode, jump);

    control uut3(opcode, funct, type, ALUCtrl, rs, rt, rd, read_address_1, read_address_2, shamt, imm, branch_yes, write_enable, mem_read, mem_write, mem_to_reg, immediate_value, mul, second_select);

    mux uut8 ({27'b0, rd}, {27'b0, rt}, type, write_address);

    register_file uu1(clk, we, read_address_1, read_address_2, write_address, ALU_in_1, read_data_2, rs_in, ALU_out_2, mul);

    mux uut69(reg_file_write_in_1, (PC + 1), {1'b0, jump}, rs_in);

    mux_2  uut70(write_enable, (opcode == 3), jump, we);

    mux uut5(read_data_2, immediate_value, {1'b0, second_select}, ALU_in_2);

    ALU uut2(ALUCtrl, ALU_in_1, ALU_in_2, ALU_out, ALU_out_2, ALU_zero, overflow);

    mux uut6(ALU_out, data_memory_out , {1'b0, mem_to_reg}, reg_file_write_in_1);


    wire [31:0] PC_plus = PC + 1;
    wire [31:0] PC_branch = PC + 1 + imm;




    wire inst_write_enable;
    wire [31:0] inst_read_address, inst_write_address, inst_data_in, inst_data_out;

    assign inst_write_enable = 0;

    wire [31:0] store;

    // pc_increment pci(PC, type, opcode, branch_yes, ALU_zero, imm, addr, ALU_in_1, store);



    always @(posedge clk) begin
        if(rst) begin
            PC <= 0;
        end else begin
            if (type == 2) begin 
                case(opcode)
                    2 : PC <= addr;       // j
                    3 : PC <= addr;       // jal
                    1 : PC <= ALU_in_1;   // jr
                    default: PC <= PC + 1;
                endcase
            end else begin
                if (branch_yes && !ALU_zero)
                    PC <= PC + 1 + imm;
                else
                    PC <= PC + 1;
            end
        end
        $display(instruction, PC);
    end


    
endmodule