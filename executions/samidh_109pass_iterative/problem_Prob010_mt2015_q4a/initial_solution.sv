module TopModule (
    input wire x,  // 1-bit input signal
    input wire y,  // 1-bit input signal
    output wire z  // 1-bit output signal
);

    assign z = (x ^ y) & x;

endmodule