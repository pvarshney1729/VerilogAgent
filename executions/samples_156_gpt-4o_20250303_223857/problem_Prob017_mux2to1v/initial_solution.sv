module TopModule (
    input  wire [99:0] a,     // 100-bit input, indexed from 0 to 99
    input  wire [99:0] b,     // 100-bit input, indexed from 0 to 99
    input  wire        sel,   // Single-bit selector
    output wire [99:0] out    // 100-bit output, indexed from 0 to 99
);

    // Combinational logic for 2-to-1 multiplexer
    assign out = (sel == 1'b0) ? a : b;

endmodule