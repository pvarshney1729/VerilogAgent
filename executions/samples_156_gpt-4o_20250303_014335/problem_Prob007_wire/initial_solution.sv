module TopModule (
    input wire in,   // 1-bit input
    output wire out  // 1-bit output
);
    // Wire behavior: direct connection
    assign out = in;
endmodule