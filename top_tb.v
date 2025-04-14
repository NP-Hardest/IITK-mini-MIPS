`timescale 1ns/1ps

module tb_top;
    reg [31:0] instruction;
    reg clk, rst;
    reg [31:0] inst_data_in, inst_addr;
    reg [31:0] mem_data_in, mem_addr;
    
    top_module uut (clk, rst, inst_data_in, inst_addr, mem_data_in, mem_addr);

    
    initial begin
        clk <= 0;
        forever #10 clk <= ~clk; 
    end


    initial begin
        rst <= 1;

        //main
        #20 inst_data_in <=  {6'h8, 5'd0, 5'd8, 16'd100};      inst_addr <= 0;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd9, 16'd0};     inst_addr <= 1;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd10, 16'd10};     inst_addr <= 2;

        //init_loop
        #20 inst_data_in <= {6'h2B, 5'd8, 5'd0, 16'h0};            inst_addr <= 3;
        #20 inst_data_in <= {6'h8, 5'd8, 5'd8, 16'd21};        inst_addr <= 4;
        #20 inst_data_in <= {6'h8, 5'd9, 5'd9, 16'd1};     inst_addr <= 5;
        #20 inst_data_in <= {6'h13, 5'd9, 5'd10, -16'd4};     inst_addr <= 6;

        #20 inst_data_in <= {6'h8, 5'd0, 5'd16, 16'd0};       inst_addr <= 7;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd17, 16'd10};       inst_addr <= 8;
        #20 inst_data_in <= {6'h8, 5'd0, 5'd18, 16'd0};    inst_addr <= 9;

        //dist_loop
        #20 inst_data_in = {6'h12, 5'd18, 5'd17, 16'd24};        inst_addr <= 10;
        #20 inst_data_in = {6'h23, 5'd16, 5'd4, 16'h0};       inst_addr <= 11;

        #20 inst_data_in = {6'h8, 5'd0, 5'd9, 16'd0};       inst_addr <= 12;
        #20 inst_data_in =  {6'h0, 5'd0, 5'd4, 5'd24, 5'd0, 6'h20};     inst_addr <= 13;
        #20 inst_data_in =  {6'h8, 5'd0, 5'd25, 16'd10};       inst_addr <= 14;

        //bucket_calc
        #20 inst_data_in =  {6'h13, 5'd24, 5'd25, 16'd3};       inst_addr <= 15;
        #20 inst_data_in = {6'h8, 5'd9, 5'd9, 16'd1};     inst_addr <= 16;
        #20 inst_data_in = {6'h8, 5'd24, 5'd24, -16'd10};        inst_addr <= 17;
        #20 inst_data_in = {6'h2, 26'd15};        inst_addr <= 18;

        //end_bucket_calc
        #20 inst_data_in = {6'h8, 5'd0, 5'd10, 16'd100};       inst_addr <= 19;
        #20 inst_data_in = {6'h8, 5'd0, 5'd23, 16'd21};        inst_addr <= 20;             //li $s7, 21
        #20 inst_data_in = {6'h0, 5'd9, 5'd23, 5'd0, 5'd0, 6'h28};                    inst_addr <= 21;
        #20 inst_data_in = {6'h8, 5'd27, 5'd11, 16'd0};     inst_addr <= 22;
        #20 inst_data_in = {6'h0, 5'd10, 5'd11, 5'd10, 5'd0, 6'h20};     inst_addr <= 23;
        #20 inst_data_in = {6'h23, 5'd10, 5'd12, 16'h0};     inst_addr <= 24;
        #20 inst_data_in = {6'h8, 5'd0, 5'd13, 16'd20};     inst_addr <= 25;
        #20 inst_data_in = {6'h12, 5'd12, 5'd13, 16'd5};     inst_addr <= 26;

        #20 inst_data_in = {6'h8, 5'd10, 5'd14, 16'd1};     inst_addr <= 27;
        #20 inst_data_in =  {6'h0, 5'd12, 5'd14, 5'd14, 5'd0, 6'h20};     inst_addr <= 28;
        #20 inst_data_in = {6'h2B, 5'd14, 5'd4, 16'h0};     inst_addr <= 29;
        #20 inst_data_in = {6'h8, 5'd12, 5'd12, 16'd1};     inst_addr <= 30;
        #20 inst_data_in = {6'h2B, 5'd10, 5'd12, 16'h0};     inst_addr <= 31;

        //skip_element
        #20 inst_data_in = {6'h8, 5'd16, 5'd16, 16'd1};     inst_addr <= 32;
        #20 inst_data_in =  {6'h8, 5'd18, 5'd18, 16'd1};     inst_addr <= 33;
        #20 inst_data_in = {6'h2, 26'd10};     inst_addr <= 34;

        //end_dist
        #20 inst_data_in = {6'h8, 5'd0, 5'd22, 16'd100};     inst_addr <= 35;
        #20 inst_data_in = {6'h8, 5'd0, 5'd24, 16'd0};     inst_addr <= 36;
        #20 inst_data_in =  {6'h8, 5'd0, 5'd25, 16'd10};     inst_addr <= 37;
        
        //sort_loop
        #20 inst_data_in = {6'h12, 5'd24, 5'd25, 16'd9};     inst_addr <= 38;
        #20 inst_data_in = {6'h23, 5'd22, 5'd11, 16'h0};     inst_addr <= 39;
        #20 inst_data_in = {6'h8, 5'd0, 5'd15, 16'd1};     inst_addr <= 40;             //li $t7, 1 to compare with 1
        #20 inst_data_in = {6'h14, 5'd11, 5'd15, 16'd3} ;     inst_addr <= 41;

        #20 inst_data_in = {6'h8, 5'd22, 5'd4, 16'd1};     inst_addr <= 42;
        #20 inst_data_in = {6'h8, 5'd11, 5'd5, 16'd0};     inst_addr <= 43;
        #20 inst_data_in = {6'h3, 26'd69};     inst_addr <= 44;

        //next_bucket
        #20 inst_data_in = {6'h8, 5'd22, 5'd22, 16'd21};     inst_addr <= 45;
        #20 inst_data_in = {6'h8, 5'd24, 5'd24, 16'd1};     inst_addr <= 46;
        #20 inst_data_in =  {6'h2, 26'd38};     inst_addr <= 47;

        //end_sort
        #20 inst_data_in = {6'h8, 5'd0, 5'd19, 16'd0};     inst_addr <= 48;
        #20 inst_data_in = {6'h8, 5'd0, 5'd20, 16'd0};     inst_addr <= 49;
        #20 inst_data_in = {6'h8, 5'd0, 5'd21, 16'd10};     inst_addr <= 50;
        
        //concat_loop
        #20 inst_data_in = {6'h12, 5'd20, 5'd21, 16'd36};     inst_addr <= 51;
        #20 inst_data_in = {6'h8, 5'd0, 5'd8, 16'd100};     inst_addr <= 52;
        #20 inst_data_in = {6'h0, 5'd20, 5'd23, 5'd0, 5'd0, 6'h28};     inst_addr <= 53;        //mul $s4, $s7=21
        #20 inst_data_in = {6'h8, 5'd27, 5'd9, 16'd0};     inst_addr <= 54;             //mov $t1, $lo
        #20 inst_data_in = {6'h0, 5'd8, 5'd9, 5'd8, 5'd0, 6'h20};     inst_addr <= 55;
        #20 inst_data_in =  {6'h23, 5'd8, 5'd10, 16'h0};     inst_addr <= 56;
        #20 inst_data_in =  {6'h4, 5'd0, 5'd10, 16'h9};     inst_addr <= 57;

        #20 inst_data_in =  {6'h8, 5'd8, 5'd8, 16'd1};     inst_addr <= 58;
        #20 inst_data_in =  {6'h8, 5'd0, 5'd11, 16'd0};     inst_addr <= 59;

        //copy_loop
        #20 inst_data_in =  {6'h12, 5'd11, 5'd10, 16'd6}  ;     inst_addr <= 60;
        #20 inst_data_in = {6'h0, 5'd8, 5'd11, 5'd12, 5'd0, 6'h20};     inst_addr <= 61;
        #20 inst_data_in = {6'h23, 5'd12, 5'd13, 16'h0};     inst_addr <= 62;
        #20 inst_data_in = {6'h2B, 5'd19, 5'd13, 16'h0};     inst_addr <= 63;
        #20 inst_data_in = {6'h8, 5'd19, 5'd19, 16'd1} ;     inst_addr <= 64;
        #20 inst_data_in =  {6'h8, 5'd11, 5'd11, 16'd1} ;     inst_addr <= 65;
        #20 inst_data_in =   {6'h2, 26'd60};     inst_addr <= 66;

        //next_concat
        #20 inst_data_in =  {6'h8, 5'd20, 5'd20, 16'd1} ;     inst_addr <= 67;
        #20 inst_data_in =   {6'h2, 26'd51};     inst_addr <= 68;

        //insertion_sort
        #20 inst_data_in =   {6'h8, 5'd0, 5'd8, 16'd1};     inst_addr <= 69;

        //insertion_loop
        #20 inst_data_in =  {6'h12, 5'd8, 5'd5, 16'd16}  ;     inst_addr <= 70;
        #20 inst_data_in =  {6'h0, 5'd8, 5'd4, 5'd9, 5'd0, 6'h20};     inst_addr <= 71;
        #20 inst_data_in =  {6'h23, 5'd9, 5'd10, 16'h0};     inst_addr <= 72;
        #20 inst_data_in =  {6'h8, 5'd8, 5'd11, -16'd1};     inst_addr <= 73;

        //inner_loop
        #20 inst_data_in = {6'h13, 5'd11, 5'd0, 16'd7} ;     inst_addr <= 74;
        #20 inst_data_in =  {6'h0, 5'd11, 5'd4, 5'd12, 5'd0, 6'h20} ;     inst_addr <= 75;
        #20 inst_data_in =  {6'h23, 5'd12, 5'd13, 16'h0};     inst_addr <= 76;
        #20 inst_data_in = {6'h14, 5'd13, 5'd10, 16'd4};     inst_addr <= 77;
        
        #20 inst_data_in = {6'h8, 5'd12, 5'd14, 16'h1};     inst_addr <= 78;
        #20 inst_data_in = {6'h2B, 5'd14, 5'd13, 16'h0};     inst_addr <= 79;
        #20 inst_data_in = {6'h8, 5'd11, 5'd11, -16'h1};     inst_addr <= 80;
        #20 inst_data_in = {6'h2, 26'd74};     inst_addr <= 81;

        //end_inner
        #20 inst_data_in =  {6'h8, 5'd11, 5'd11, 16'h1};     inst_addr <= 82;
        #20 inst_data_in = {6'h0, 5'd11, 5'd4, 5'd12, 5'd0, 6'h20};     inst_addr <= 83;
        #20 inst_data_in = {6'h2B, 5'd12, 5'd10, 16'h0};     inst_addr <= 84;
        #20 inst_data_in =  {6'h8, 5'd8, 5'd8, 16'h1};     inst_addr <= 85;
        #20 inst_data_in =   {6'h2, 26'd70};     inst_addr <= 86;

        //end_insertion
        #20 inst_data_in =    {6'h1, 5'd31, 21'd0};     inst_addr <= 87;
        #20 inst_data_in =    {6'h8, 5'd22, 5'd22, 16'h1};     inst_addr <= 88;


        #20 mem_addr <= 0 ; mem_data_in <= 19; 
        #20 mem_addr <= 1 ; mem_data_in <= 9; 
        #20 mem_addr <= 2 ; mem_data_in <= 61; 
        #20 mem_addr <= 3 ; mem_data_in <= 2; 
        #20 mem_addr <= 4 ; mem_data_in <= 3; 
        #20 mem_addr <= 5 ; mem_data_in <= 43; 
        #20 mem_addr <= 6 ; mem_data_in <= 19; 
        #20 mem_addr <= 7 ; mem_data_in <= 10; 
        #20 mem_addr <= 8 ; mem_data_in <= 5; 
        #20 mem_addr <= 9 ; mem_data_in <= 86; 

        #30;
        rst <= 0;
      #150000;

        $display("time : %t",$time);
        $display("GPRs:");
        $display("$0:  %d, $1:  %d, $2:  %d, $3:  %d, ", uut.reg_file.GPR[0], uut.reg_file.GPR[1], uut.reg_file.GPR[2], uut.reg_file.GPR[3]);
        $display("$4:  %d, $5:  %d, $6:  %d, $7:  %d, ", uut.reg_file.GPR[4], uut.reg_file.GPR[5], uut.reg_file.GPR[6], uut.reg_file.GPR[7]);
        $display("$8:  %d, $9:  %d, $10: %d, $11: %d, ", uut.reg_file.GPR[8], uut.reg_file.GPR[9], uut.reg_file.GPR[10], uut.reg_file.GPR[11]);
        $display("$12: %d, $13: %d, $14: %d, $15: %h, ", uut.reg_file.GPR[12], uut.reg_file.GPR[13], uut.reg_file.GPR[14], uut.reg_file.GPR[15]);
        $display("$16: %d, $17: %d, $18: %d, $19: %d, ", uut.reg_file.GPR[16], uut.reg_file.GPR[17], uut.reg_file.GPR[18], uut.reg_file.GPR[19]);
        $display("$20: %d, $21: %d, $22: %d, $23: %d, ", uut.reg_file.GPR[20], uut.reg_file.GPR[21], uut.reg_file.GPR[22], uut.reg_file.GPR[23]);
        $display("$24: %d, $25: %d, $26: %d, $27: %d, ", uut.reg_file.GPR[24], uut.reg_file.GPR[25], uut.reg_file.GPR[26], uut.reg_file.GPR[27]);
        $display("$28: %d, $29: %d, $30: %d, $31: %d, ", uut.reg_file.GPR[28], uut.reg_file.GPR[29], uut.reg_file.GPR[30], uut.reg_file.GPR[31]);
        
        $display("FPRs:");
        $display("$0:  %h, $1:  %h, $2:  %h, $3:  %h, ", uut.reg_file.FPR[0], uut.reg_file.FPR[1], uut.reg_file.FPR[2], uut.reg_file.FPR[3]);
        $display("$4:  %h, $5:  %h, $6:  %h, $7:  %h, ", uut.reg_file.FPR[4], uut.reg_file.FPR[5], uut.reg_file.FPR[6], uut.reg_file.FPR[7]);
        $display("$8:  %h, $9:  %h, $10: %h, $11: %h, ", uut.reg_file.FPR[8], uut.reg_file.FPR[9], uut.reg_file.FPR[10], uut.reg_file.FPR[11]);
        $display("$12: %h, $13: %h, $14: %h, $15: %h, ", uut.reg_file.FPR[12], uut.reg_file.FPR[13], uut.reg_file.FPR[14], uut.reg_file.FPR[15]);
        $display("$16: %h, $17: %h, $18: %h, $19: %h, ", uut.reg_file.FPR[16], uut.reg_file.FPR[17], uut.reg_file.FPR[18], uut.reg_file.FPR[19]);
        $display("$20: %h, $21: %h, $22: %h, $23: %h, ", uut.reg_file.FPR[20], uut.reg_file.FPR[21], uut.reg_file.FPR[22], uut.reg_file.FPR[23]);
        $display("$24: %h, $25: %h, $26: %h, $27: %h, ", uut.reg_file.FPR[24], uut.reg_file.FPR[25], uut.reg_file.FPR[26], uut.reg_file.FPR[27]);
        $display("$28: %h, $29: %h, $30: %h, $31: %h, ", uut.reg_file.FPR[28], uut.reg_file.FPR[29], uut.reg_file.FPR[30], uut.reg_file.FPR[31]);
        
        $display("Data Memory:");
        $display("$memory[0]:  %d, $memory[1]:  %d, $memory[2]:  %d, $memory[3]:  %d, ", uut.data_memory.mem[0], uut.data_memory.mem[1], uut.data_memory.mem[2], uut.data_memory.mem[3]);
        $display("$memory[4]:  %d, $memory[5]:  %d, $memory[6]:  %d, $memory[7]:  %d, ", uut.data_memory.mem[4], uut.data_memory.mem[5], uut.data_memory.mem[6], uut.data_memory.mem[7]);
        $display("$memory[8]:  %d, $memory[9]:  %d, $memory[10]: %d, $memory[11]: %d, ", uut.data_memory.mem[8], uut.data_memory.mem[9], uut.data_memory.mem[10], uut.data_memory.mem[11]);
        $display("$memory[12]: %d, $memory[13]: %d, $memory[14]: %d, $memory[15]: %d, ", uut.data_memory.mem[12], uut.data_memory.mem[13], uut.data_memory.mem[14], uut.data_memory.mem[15]);
        $display("$memory[16]: %d, $memory[17]: %d, $memory[18]: %d, $memory[19]: %d, ", uut.data_memory.mem[16], uut.data_memory.mem[17], uut.data_memory.mem[18], uut.data_memory.mem[19]);
        $display("$memory[20]: %d, $memory[21]: %d, $memory[22]: %d, $memory[23]: %d, ", uut.data_memory.mem[20], uut.data_memory.mem[21], uut.data_memory.mem[22], uut.data_memory.mem[23]);
        $display("$memory[24]: %d, $memory[25]: %d, $memory[26]: %d, $memory[27]: %d, ", uut.data_memory.mem[24], uut.data_memory.mem[25], uut.data_memory.mem[26], uut.data_memory.mem[27]);
        $display("$memory[28]: %d, $memory[29]: %d, $memory[30]: %d, $memory[31]: %d, ", uut.data_memory.mem[28], uut.data_memory.mem[29], uut.data_memory.mem[30], uut.data_memory.mem[31]);
        $display("buckets:");
        $display("$memory[0]:  %d, $memory[1]:  %d, $memory[2]:  %d, $memory[3]:  %d, ", uut.data_memory.mem[100], uut.data_memory.mem[101], uut.data_memory.mem[102], uut.data_memory.mem[103]);
        $display("$memory[4]:  %d, $memory[5]:  %d, $memory[6]:  %d, $memory[7]:  %d, ", uut.data_memory.mem[104], uut.data_memory.mem[105], uut.data_memory.mem[106], uut.data_memory.mem[107]);
        $display("$memory[8]:  %d, $memory[9]:  %d, $memory[10]: %d, $memory[11]: %d, ", uut.data_memory.mem[108], uut.data_memory.mem[109], uut.data_memory.mem[10], uut.data_memory.mem[11]);
        $display("$memory[12]: %d, $memory[13]: %d, $memory[14]: %d, $memory[15]: %d, ", uut.data_memory.mem[121], uut.data_memory.mem[122], uut.data_memory.mem[123], uut.data_memory.mem[124]);
        $display("$memory[16]: %d, $memory[17]: %d, $memory[18]: %d, $memory[19]: %d, ", uut.data_memory.mem[142], uut.data_memory.mem[17], uut.data_memory.mem[18], uut.data_memory.mem[19]);
        $display("$memory[20]: %d, $memory[21]: %d, $memory[22]: %d, $memory[23]: %d, ", uut.data_memory.mem[20], uut.data_memory.mem[21], uut.data_memory.mem[22], uut.data_memory.mem[23]);
        $display("$memory[24]: %d, $memory[25]: %d, $memory[26]: %d, $memory[27]: %d, ", uut.data_memory.mem[24], uut.data_memory.mem[25], uut.data_memory.mem[26], uut.data_memory.mem[27]);
        $display("$memory[28]: %d, $memory[29]: %d, $memory[30]: %d, $memory[31]: %d, ", uut.data_memory.mem[28], uut.data_memory.mem[29], uut.data_memory.mem[30], uut.data_memory.mem[31]);
        $display("\n");

        $finish;
    end
    always @ (posedge clk) begin

        // $display("time : %t",$time);
        // $display("GPRs:");
        // $display("$0:  %d, $1:  %d, $2:  %d, $3:  %d, ", uut.reg_file.GPR[0], uut.reg_file.GPR[1], uut.reg_file.GPR[2], uut.reg_file.GPR[3]);
        // $display("$4:  %d, $5:  %d, $6:  %d, $7:  %d, ", uut.reg_file.GPR[4], uut.reg_file.GPR[5], uut.reg_file.GPR[6], uut.reg_file.GPR[7]);
        // $display("$8:  %d, $9:  %d, $10: %d, $11: %d, ", uut.reg_file.GPR[8], uut.reg_file.GPR[9], uut.reg_file.GPR[10], uut.reg_file.GPR[11]);
        // $display("$12: %d, $13: %d, $14: %d, $15: %d, ", uut.reg_file.GPR[12], uut.reg_file.GPR[13], uut.reg_file.GPR[14], uut.reg_file.GPR[15]);
        // $display("$16: %d, $17: %d, $18: %d, $19: %d, ", uut.reg_file.GPR[16], uut.reg_file.GPR[17], uut.reg_file.GPR[18], uut.reg_file.GPR[19]);
        // $display("$20: %d, $21: %d, $22: %d, $23: %d, ", uut.reg_file.GPR[20], uut.reg_file.GPR[21], uut.reg_file.GPR[22], uut.reg_file.GPR[23]);
        // $display("$24: %d, $25: %d, $26: %d, $27: %d, ", uut.reg_file.GPR[24], uut.reg_file.GPR[25], uut.reg_file.GPR[26], uut.reg_file.GPR[27]);
        // $display("$28: %d, $29: %d, $30: %d, $31: %d, ", uut.reg_file.GPR[28], uut.reg_file.GPR[29], uut.reg_file.GPR[30], uut.reg_file.GPR[31]);
        
        // $display("Data Memory:");
        // $display("$memory[0]:  %d, $memory[1]:  %d, $memory[2]:  %d, $memory[3]:  %d, ", uut.data_memory.mem[0], uut.data_memory.mem[1], uut.data_memory.mem[2], uut.data_memory.mem[3]);
        // $display("$memory[4]:  %d, $memory[5]:  %d, $memory[6]:  %d, $memory[7]:  %d, ", uut.data_memory.mem[4], uut.data_memory.mem[5], uut.data_memory.mem[6], uut.data_memory.mem[7]);
        // $display("$memory[8]:  %d, $memory[9]:  %d, $memory[10]: %d, $memory[11]: %d, ", uut.data_memory.mem[8], uut.data_memory.mem[9], uut.data_memory.mem[10], uut.data_memory.mem[11]);
        // $display("$memory[12]: %d, $memory[13]: %d, $memory[14]: %d, $memory[15]: %d, ", uut.data_memory.mem[12], uut.data_memory.mem[13], uut.data_memory.mem[14], uut.data_memory.mem[15]);
        // $display("$memory[16]: %d, $memory[17]: %d, $memory[18]: %d, $memory[19]: %d, ", uut.data_memory.mem[16], uut.data_memory.mem[17], uut.data_memory.mem[18], uut.data_memory.mem[19]);
        // $display("$memory[20]: %d, $memory[21]: %d, $memory[22]: %d, $memory[23]: %d, ", uut.data_memory.mem[20], uut.data_memory.mem[21], uut.data_memory.mem[22], uut.data_memory.mem[23]);
        // $display("$memory[24]: %d, $memory[25]: %d, $memory[26]: %d, $memory[27]: %d, ", uut.data_memory.mem[24], uut.data_memory.mem[25], uut.data_memory.mem[26], uut.data_memory.mem[27]);
        // $display("$memory[28]: %d, $memory[29]: %d, $memory[30]: %d, $memory[31]: %d, ", uut.data_memory.mem[28], uut.data_memory.mem[29], uut.data_memory.mem[30], uut.data_memory.mem[31]);
        // $display("\n");
    end
endmodule


