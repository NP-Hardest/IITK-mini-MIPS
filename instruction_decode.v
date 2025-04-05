module instruction_decode(instruction, rs, rt, rd, shamt, funct, imm, addr, type, opcode);
    input [31:0] instruction;
    output reg [1:0] type;
    
    output wire [4:0] rs; 
    output wire [4:0] rt;  
    output wire [4:0] rd; 
    
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    
    
    output wire [4:0] shamt; 
    output wire [5:0] funct;
    
    assign shamt = instruction[10:6];
    assign funct = instruction[5:0];
    
    output wire [31:0] imm;
    wire [15:0] im = instruction[15:0];
    assign imm = {{16{im[15]}}, im};

    
    
    output wire [25:0] addr;
    assign addr = instruction[25:0];
    
    wire [5:0] op = instruction[31:26];
    output [5:0] opcode;
    assign opcode = op;
        
        
    always @ (*) begin
        if(op == 0) type <= 0;
        else begin
            case(op) 
                6'h8 : type <= 1;
                6'h9 : type <= 1;
                6'hC : type <= 1;
                6'hD : type <= 1;
                6'hE : type <= 1;
                6'hA : type <= 1;
                6'h23: type <= 1;
                6'h2B: type <= 1;
                6'hF : type <= 1;
                6'h4 : type <= 1;
                6'h5 : type <= 1;
                6'h12: type <= 1;
                6'h13: type <= 1;
                6'h14: type <= 1;
                6'h15: type <= 1;
                6'h16: type <= 1;
                6'h17: type <= 1;  
                6'h2 : type <= 2;
                6'h3 : type <= 2;                 
            endcase
        end
        
    end
    
    
endmodule

