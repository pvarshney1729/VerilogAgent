module TopModule (
    input  logic [99:0] a,    // 100-bit input, unsigned, LSB is bit[0]
    input  logic [99:0] b,    // 100-bit input, unsigned, LSB is bit[0]
    input  logic        sel,  // 1-bit selection input for multiplexer
    output logic [99:0] out   // 100-bit output, unsigned, LSB is bit[0]
);

    assign out = (sel == 1'b0) ? a : b;

endmodule