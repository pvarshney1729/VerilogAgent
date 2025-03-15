module TopModule(
    input  [7:0] in,
    output parity
);

    // Compute the even parity by XORing all bits of the input
    assign parity = ^in;

endmodule