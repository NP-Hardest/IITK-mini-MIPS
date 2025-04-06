module register_file(clk, write_enable, read_address_1, read_address_2, write_address, read_data_1, read_data_2, write_data_1, write_data_2, mul);
    input clk, write_enable;
    input [1:0] mul;
    input [31:0] read_address_1, read_address_2, write_address, write_data_1, write_data_2;
    output [31:0] read_data_1, read_data_2;

    reg [31:0] data_1, data_2;

    reg [31:0] GPR [31:0];      

    reg [31:0] lo, hi;

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
    // 11 -> t3         26 -> k0
    // 12 -> t4         27 -> k1
    // 13 -> t5         28 -> gp
    // 14 -> t6         29 -> sp
    // 15 -> t7         30 -> fp
    // 16 -> s0         31 -> ra


    initial begin
        GPR[2] = 32'd3;
        GPR[1] = 32'd1;
    end

    always @ (posedge clk) begin
        if(write_enable) begin
            if(mul == 1) begin
                {hi, lo} <=  {write_data_2, write_data_1};
            end    

            else if(mul == 2) begin
                {hi, lo} <= {hi, lo} + {write_data_2, write_data_1};
            end   
            else begin 
                {hi, lo} <= {hi, lo};
                GPR[write_address] <= write_data_1;
            end

        end     

        data_1 <= GPR[read_address_1];
        data_2 <= GPR[read_address_2];

    end
    assign read_data_1 = data_1;
    assign read_data_2 = data_2;

endmodule