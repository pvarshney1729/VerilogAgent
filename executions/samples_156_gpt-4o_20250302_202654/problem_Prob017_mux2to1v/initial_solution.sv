module TopModule (
    input  logic [99:0] a,    // 100-bit unsigned input
    input  logic [99:0] b,    // 100-bit unsigned input
    input  logic        sel,  // 1-bit select input, 0 = select 'a', 1 = select 'b'
    output logic [99:0] out   // 100-bit unsigned output
);

    assign out = sel ? b : a;

endmodule