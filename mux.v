module mux(a, b, sel, out);
    input [31:0] a,b;
    input [1:0] sel;
    output [31:0] out;

    assign out = sel ? b : a;

endmodule