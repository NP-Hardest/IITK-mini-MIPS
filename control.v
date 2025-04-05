module control(opcode, func, type, ALUCtrl, rs, rt, rd, ALU_in_1, ALU_in_2, shamt, imm, branch_yes, second_read, write_enable);
    input [5:0] opcode;
    input [5:0] func;
    input [1:0] type;
    input [4:0] rs; 
    input [4:0] rt;  
    input [4:0] rd; 
    input [4:0] shamt; 
    input [31:0] imm;
    
    output reg [4:0] ALUCtrl;
    output reg [31:0] ALU_in_1;
    output reg [31:0] ALU_in_2;
    output reg branch_yes, second_read, write_enable;
    
    always @ (*) begin
        case(type) 
            0 : begin
                case(func)
                        6'h20: begin                    //  add r0, r1, r2 r0=r1+r2      
                                ALUCtrl <= 5'd2;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                                                                        
                        6'h22: begin               //d   sub r0, r1, r2 r0=r1-r2  
                                ALUCtrl <= 5'd6;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                                                            
                        6'h21: begin// addu r0, r1, r2 r0=r1+r2 (unsigned addition, not 2's complement)    
                                ALUCtrl <= 5'd8;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end               
                        6'h23: begin //subu r0,r1,r2 r0=r1-r2 (unsigned addition, not 2's complement)   
                                ALUCtrl <= 5'd9;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                    
                        6'h18: begin // d             mul r0,r1 hi=z[63:32],lo=z[31:0], Z=r0*r1                     
                                ALUCtrl <= 5'd5;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end               
                        6'h24: begin //  and r0,r1,r2 r0= r1 & r2                                                               
                                ALUCtrl <= 5'd0;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                
                        6'h25: begin     //   or r0,r1,r2 r0= r1 | r2  
                                ALUCtrl <= 5'd1;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                                                                         
                        6'h26: begin    // xor r0,r1,r2 r0= r1 ^ r2   
                                ALUCtrl <= 5'd4;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= rt;
                                branch_yes <= 0;
                                second_read <= 1;
                                write_enable <= 1;
                        end                                                        
                        6'h27: begin //  not r0, r1                                                              
                                ALUCtrl <= 5'd3;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= 0;
                                branch_yes <= 0;
                                second_read <= 0;
                                write_enable <= 1;
                        end               
                        6'h0:  begin //sll r0, r1, 10 r0=r1<<10 (shift left logical)                       
                                ALUCtrl <= 5'd13;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= {27'b0, shamt};
                                branch_yes <= 0;
                                second_read <= 0;
                                write_enable <= 1;
                        end           
                        6'h2:  begin // srl r0, r1, 10 r0=r1>>10 (shift right logical)                        
                                ALUCtrl <= 5'd14;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= {27'b0, shamt};
                                branch_yes <= 0;
                                second_read <= 0;
                                write_enable <= 1;
                        end                 
                        6'h3:  begin   //  sra r0, r1, 10 r0=r1>>10 (shift right arithmetic)                     
                                ALUCtrl <= 5'd12;
                                ALU_in_1 <= rs;
                                ALU_in_2 <= {27'b0, shamt};
                                branch_yes <= 0;
                                second_read <= 0;
                                write_enable <= 1;
                        end               

                        6'h4:  begin
                                ALUCtrl <= 5'd15; //  sla r01,, r1, 10 r0=r1<<10 (shift left arithmetic)                       
                                ALU_in_1 <= rs;
                                ALU_in_2 <= {27'b0, shamt};
                                branch_yes <= 0;
                                second_read <= 0;
                                write_enable <= 1;
                        end                
    
                        6'h2A: begin   //slt r0,r1,r2 if(r1<r2) r0=1 else r0=0                                 
                                 ALUCtrl <= 5'd7;
                                 ALU_in_1 <= rs;
                                 ALU_in_2 <= rt;
                                 branch_yes <= 0;
                                 second_read <= 1;
                                 write_enable <= 1;
                        end             
                        6'h2B: begin    //seq r0, r1, r2      
                                 ALUCtrl <= 5'd11;
                                 ALU_in_1 <= rs;
                                 ALU_in_2 <= rt;
                                 branch_yes <= 0;
                                 second_read <= 1;
                                 write_enable <= 1;
                        end                             
                    
                endcase 
             end
             
             1 : begin
                    $display ("%h", opcode);
                case(opcode) 
                    6'h8: begin         //addi r0,r1,1000 r0=r1+1000    
                            ALUCtrl <= 5'd2;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;    
                            branch_yes <= 0;      
                            second_read <= 0;         
                            write_enable <= 1; 
                    end   
                    
                    6'h9: begin         //addiu r0,r1, 1000 r0=r1+1000 (unsigned additon, not 2's complement) 
                            ALUCtrl <= 5'd8;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;  
                            branch_yes <= 0;
                            second_read <= 0;
                            write_enable <= 1;
                    end   
                    
                    6'hC: begin    //andi r0,r1, 1000 r0= r1 & 1000    
                            ALUCtrl <= 5'd0;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;  
                            branch_yes <= 0;
                            second_read <= 0;
                            write_enable <= 1;
                    end 
                        
                    6'hD: begin         //ori r0,r1, 1000 r0= r1 | 1000    
                            ALUCtrl <= 5'd1;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;  
                            branch_yes <= 0;
                            second_read <= 0;
                            write_enable <= 1;
                    end
                    
                    6'hE: begin                 //xori, r0,r1,1000 r0=r1 xor 1000        
                            ALUCtrl <= 5'd4;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;  
                            branch_yes <= 0;
                            second_read <= 0;
                            write_enable <= 1;
                    end  
                    
                    6'hA: begin         //slti r0,r1,100 if(r1<100) r0=1 else r0=0  
                            ALUCtrl <= 5'd7;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= imm;  
                            branch_yes <= 0;
                            second_read <= 0;
                            write_enable <= 1;
                    end 
                    
                
                    6'h4: begin //beq r0,r1,10 if(r0==r1) go to PC+4+10 (branch on equal)     
                            ALUCtrl <= 5'd11;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end 
                        
                    6'h5: begin         //bne r0,r1,10 if(r0!=r1) go to PC+4+10 (branch on not equal)    
                            ALUCtrl <= 5'd16;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end
                    
                    6'h12: begin        //bgte r0,r1, 10 if(r0>=r1) go to PC+4+10 (branch if greter than or equal)  
                            ALUCtrl <= 5'd18;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end  
                    
                    6'h13: begin        //ble r0,r1, 10 if(r0<r1) go to PC+4+10 (branch if less than)
                            ALUCtrl <= 5'd7;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end 
                    
                    6'h14: begin        //bleq r0,r1, 10 if(r0<=r1) go to PC+4+10 (branch if less than or equal) 
                            ALUCtrl <= 5'd19;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end

                    6'h15: begin        //bleu r0,r1, 10 unsigned version of ble      
                            ALUCtrl <= 5'd10;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end 
                    
                    6'h16: begin    //bgtu r0,r1, 10 unsigned version of bgt   
                            ALUCtrl <= 5'd17;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end

                    6'h17: begin  //bgt r0,r1,10 if(r0>r1) go to PC+4+10 (branch if greater than)  
                            ALUCtrl <= 5'd20;
                            ALU_in_1 <= rs;
                            ALU_in_2 <= rt;  
                            branch_yes <= 1;
                            second_read <= 1;
                            write_enable <= 0;
                    end
                        
                endcase
             
             end   
            
        endcase
    end
    
 
    
    
endmodule


