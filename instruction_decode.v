module instruction_decode(instruction, rs, rt, rd, shamt, funct, imm, addr, type, opcode, jump);
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

    output reg jump;
        
        
    always @ (*) begin
        if(op == 0) begin 
            type <= 0;
            jump <= 0;
        end
        else begin
            case(op) 
                6'h8 : begin
                    type <= 1;
                    jump <= 0;
                end
                6'h9 : begin
                    type <= 1;
                    jump <= 0;
                end
                6'hC : begin
                    type <= 1;
                    jump <= 0;
                end
                6'hD : begin
                    type <= 1;
                    jump <= 0;
                end
                6'hE : begin
                    type <= 1;
                    jump <= 0;
                end
                6'hA : begin
                    type <= 1;
                    jump <= 0;
                end
                6'h23: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h2B: begin
                    type <= 1;
                    jump <= 0;
                end
                6'hF : begin
                    type <= 1;
                    jump <= 0;
                end
                6'h4 : begin
                    type <= 1;
                    jump <= 0;
                end
                6'h5 : begin
                    type <= 1;
                    jump <= 0;
                end
                6'h12: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h13: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h14: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h15: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h16: begin
                    type <= 1;
                    jump <= 0;
                end
                6'h17: begin
                    type <= 1;
                    jump <= 0;
                end  
                6'h1C: begin
                    type <= 1;
                    jump <= 0;
                end  
                6'h1D: begin
                    type <= 1;
                    jump <= 0;
                end  
                6'h1 : begin
                    type <= 2;
                    jump <= 1;
                end            
                6'h2 : begin
                    type <= 2;
                    jump <= 1;
                end
                6'h3 : begin
                    type <= 2;
                    jump <= 1;
                end     
            endcase
        end
        
    end
    
    
endmodule

