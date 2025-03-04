module TopModule(
    input  [99:0] a,       // 100-bit wide input, MSB at index 99
    input  [99:0] b,       // 100-bit wide input, MSB at index 99
    input         sel,     // 1-bit multiplexer select signal, 0 or 1
    output [99:0] out      // 100-bit wide output, MSB at index 99
);

    // Combinational logic for 2-to-1 multiplexer
    assign out = sel ? b : a;

endmodule