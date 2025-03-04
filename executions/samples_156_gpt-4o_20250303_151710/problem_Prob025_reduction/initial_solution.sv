module TopModule (
    input [7:0] in,
    output parity
);
    assign parity = ^in; // XOR all bits of the input vector to compute even parity
endmodule