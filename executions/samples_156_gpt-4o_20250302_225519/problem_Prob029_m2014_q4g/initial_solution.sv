module TopModule(
    input logic in1,  // 1-bit input signal
    input logic in2,  // 1-bit input signal
    input logic in3,  // 1-bit input signal
    output logic out  // 1-bit output signal
);

    // Combinational logic for the specified behavior
    always_comb begin
        out = ~((in1 ^ in2) ^ in3);
    end

endmodule