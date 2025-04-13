module memory(clk, write_enable, read_address, write_address, data_in, data_out);

    input clk, write_enable;
    input [31:0] read_address, write_address, data_in;
    output [31:0] data_out;

    reg [31:0] data_read;

    reg [31:0] mem [1023:0];

    initial begin
        mem[1] = 1<<31; 
        mem[2] = 1<<31; 
        mem[3] = -7; 
        mem[4] = 6; 
        mem[5] = -5; 
        mem[6] = 4; 
        mem[7] = -3; 
        mem[8] = -2; 
        mem[9] = 1<<31; 
        mem[10] = 0; 

    end

    always @(posedge clk) begin
        
        if(write_enable) begin
             mem[write_address] <= data_in;
        end     
    end

    assign data_out = mem[read_address];

endmodule


module inst_memory(clk, write_enable, read_address, write_address, data_in, data_out);

    input clk, write_enable;
    input [31:0] read_address, write_address, data_in;
    output [31:0] data_out;

    reg [31:0] data_read;

    reg [31:0] mem [1023:0];

    initial begin
        
        mem[0] = {6'h0, 5'd0, 5'd14, 5'd21, 5'd0, 6'h10};          //0x0 fs ft fd 0 0x12

    end

    always @(posedge clk) begin
        
        if(write_enable) begin
             mem[write_address] <= data_in;
        end     
        data_read <= mem[read_address];
    end

    assign data_out = mem[read_address];

endmodule

