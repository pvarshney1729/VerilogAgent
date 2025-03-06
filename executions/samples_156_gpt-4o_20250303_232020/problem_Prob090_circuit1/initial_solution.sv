module TopModule (
    input wire a,     // 1-bit input signal 'a'
    input wire b,     // 1-bit input signal 'b'
    output wire q     // 1-bit output signal 'q'
);

    // Combinational logic for output 'q'
    assign q = a & b;

endmodule