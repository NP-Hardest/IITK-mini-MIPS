module register_file(clk, rst, write_enable, read_address_1, read_address_2, write_address, read_data_1, read_data_2, write_data_1, write_data_2, mul, fp);
    input clk, rst , write_enable;
    input [2:0] fp;
    input [1:0] mul;
    input [31:0] read_address_1, read_address_2, write_address, write_data_1, write_data_2;
    output [31:0] read_data_1, read_data_2;

    reg [31:0] GPR[63:0];          //1st 32 registers are gpr next 32 are fpr      
    reg [31:0] FPR[63:0];          //1st 32 registers are gpr next 32 are fpr      


    

    always @ (posedge clk) begin
        if(rst) begin
            GPR[0] <= 0;
            // GPR[15] <= 8; 
            // GPR[14] <= 8; 
            GPR[29] <= 200;         //assume stack pointer starts at 500
            // GPR_FPR[31] <= 17;
            FPR[13] <= 32'hc1d9f1aa;
            FPR[14] <= 32'h427d5d2f;

        end
        
        else begin
            if(write_enable) begin
                if(mul == 1) begin
                    {GPR[26], GPR[27]} <=  {write_data_2, write_data_1};
                end    

                else if(mul == 2) begin
                    // {hi, lo} <= {hi, lo} + {write_data_2, write_data_1};
                    {GPR[26], GPR[27]} <= {GPR[26], GPR[27]} + {write_data_2, write_data_1};
                end   
                
                else begin 
                    if(fp[0]) FPR[write_address] <= write_data_1;
                    else GPR[write_address] <= write_data_1;
                end
            end     

        end
    end

    assign read_data_1 = fp[2] ? FPR[read_address_1] : GPR[read_address_1];
    assign read_data_2 = fp[1] ? FPR[read_address_2] : GPR[read_address_2];
    // assign read_data_2 = GPR_FPR[read_address_2];

endmodule

    // 0 -> zero       
    // 1 -> at          
    // 2 -> v0          17 -> s1
    // 3 -> v1          18 -> s2
    // 4 -> a0          19 -> s3
    // 5 -> a1          20 -> s4
    // 6 -> a2          21 -> s5
    // 7 -> a3          22 -> s6
    // 8 -> t0          23 -> s7    
    // 9 -> t1          24 -> t8
    // 10 -> t2         25 -> t9
    // 11 -> t3         26 -> hi    ///IMP
    // 12 -> t4         27 -> lo    /// IMP
    // 13 -> t5         28 -> gp
    // 14 -> t6         29 -> sp
    // 15 -> t7         30 -> fp
    // 16 -> s0         31 -> ra


    //FPR

   
         
    // 32 -> f0          47 -> f15
    // 33 -> f1          48 -> f16
    // 34 -> f2          49 -> f17
    // 35 -> f3          50 -> f18
    // 36 -> f4          51 -> f19
    // 37 -> f5          52 -> f20
    // 38 -> f6          53 -> f21    
    // 39 -> f7          54 -> f22
    // 40 -> f8          55 -> f23
    // 41 -> f9          56 -> f24  
    // 42 -> f10         57 -> f25   
    // 43 -> f11         58 -> f26
    // 44 -> f12         59 -> f27
    // 45 -> f13         60 -> f28
    // 46 -> f14         61 -> f29
                       //62 -> f30 
                      // 63 -> cc    


