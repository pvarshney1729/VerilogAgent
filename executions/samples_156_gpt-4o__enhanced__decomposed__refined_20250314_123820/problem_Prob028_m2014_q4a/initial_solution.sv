[BEGIN]
module TopModule(
    input logic d,    // 1-bit input data to the latch
    input logic ena,  // 1-bit enable signal for the latch
    output logic q    // 1-bit output of the latch
);

    always @(*) begin
        if (ena == 1'b1) begin
            q <= d; // Capture `d` when `ena` is high
        end
        // Else retain the previous state of `q`
    end

endmodule
[DONE]