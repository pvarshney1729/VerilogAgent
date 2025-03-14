module TopModule (
    input  logic [99:0] a,       // 100-bit input vector 'a'
    input  logic [99:0] b,       // 100-bit input vector 'b'
    input  logic        sel,     // 1-bit selection input 'sel'
    output logic [99:0] out      // 100-bit output vector 'out'
);

    // Combinational logic for 2-to-1 multiplexer
    assign out = sel ? b : a;

endmodule