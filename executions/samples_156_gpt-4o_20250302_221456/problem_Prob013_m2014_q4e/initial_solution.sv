module TopModule (
    input logic in1,  // 1-bit input signal
    input logic in2,  // 1-bit input signal
    output logic out  // 1-bit output signal
);

    // Implementing the NOR gate logic
    assign out = ~(in1 | in2);

endmodule