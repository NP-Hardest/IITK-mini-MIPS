module register_file(clk, write_enable, second_read, read_address_1, read_address_2, write_address, read_data_1, read_data_2, write_data);
    input clk, write_enable, second_read;
    input [31:0] read_address_1, read_address_2, write_address, write_data;
    output [31:0] read_data_1, read_data_2;

    reg [31:0] data_1, data_2;

    reg [31:0] GPR [31:0];

    initial begin
        GPR[2] = 32'd3;
        GPR[1] = 32'd1;

    end

    always @ (posedge clk) begin

        if(write_enable) GPR[write_address] <= write_data;
        data_1 <= GPR[read_address_1];
        if(second_read) data_2 <= GPR[read_address_2];

    end
    assign read_data_1 = data_1;
    assign read_data_2 = data_2;

endmodule