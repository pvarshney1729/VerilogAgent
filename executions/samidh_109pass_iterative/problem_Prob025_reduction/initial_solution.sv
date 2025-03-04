module TopModule (
    input  wire [7:0] in,   // 8-bit input vector
    output wire       parity // 1-bit even parity output
);
    assign parity = ^in; // XOR reduction operator for even parity
endmodule