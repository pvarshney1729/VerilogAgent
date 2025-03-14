[BEGIN]
module TopModule (
    input logic in,      // 1-bit input signal
    output logic out     // 1-bit output signal
);

    // Implement NOT gate functionality
    always @(*) begin
        out = ~in;
    end

endmodule
[DONE]