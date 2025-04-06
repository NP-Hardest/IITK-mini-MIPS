module memory(clk, write_enable, read_address, write_address, data_in, data_out);

    input clk, write_enable;
    input [31:0] read_address, write_address, data_in;
    output [31:0] data_out;

    reg [31:0] data_read;

    reg [31:0] mem [1023:0];

    // initial begin
    //     mem[13] = 9; 
    //     // mem[1] = 5; 

    // end

    always @(*) begin
        data_read <= mem[read_address];
    end

    always @(posedge clk) begin
        
        if(write_enable) begin
             mem[write_address] <= data_in;
        end     
    end

    assign data_out = data_read;

endmodule


module inst_memory(clk, write_enable, read_address, write_address, data_in, data_out);

    input clk, write_enable;
    input [31:0] read_address, write_address, data_in;
    output [31:0] data_out;

    reg [31:0] data_read;

    reg [31:0] mem [1023:0];

    initial begin
        // mem[0] = {6'h0, 5'd0, 5'd0, 16'h2D};            //DO Nothing instruction
        mem[0] = {6'h8, 5'd0, 5'd8, 16'h20};
        mem[1] = {6'h8, 5'd0, 5'd9, 16'h1};
        mem[2] = {6'h2B, 5'd9, 5'd8, 16'h10};
        mem[3] = {6'h23, 5'd9, 5'd10, 16'h10};

    end

    always @(*) begin
        data_read <= mem[read_address];
    end


    always @(posedge clk) begin
        
        if(write_enable) begin
             mem[write_address] <= data_in;
        end     
        data_read <= mem[read_address];
    end

    assign data_out = data_read;

endmodule

