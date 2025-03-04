module TopModule (
    input logic [5:0] y,  // Input state vector, one-hot encoded
    input logic w,        // 1-bit input for state transitions
    input logic clk,      // Clock signal for sequential logic
    input logic reset,    // Asynchronous reset signal
    output logic Y1,      // 1-bit output
    output logic Y3,      // 1-bit output
    output logic Y2,      // 1-bit output, derived from next-state logic for y[1]
    output logic Y4       // 1-bit output, derived from next-state logic for y[3]
);

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            Y1 <= 1'b0;
            Y3 <= 1'b0;
            Y2 <= 1'b0;
            Y4 <= 1'b0;
        end else begin
            // Next-state logic for Y2 (state B)
            Y2 <= (y[0] & ~w) | (y[3] & w);

            // Next-state logic for Y4 (state D)
            Y4 <= (y[1] & w) | (y[2] & w) | (y[3] & ~w) | (y[5] & w);

            // Output logic
            Y1 <= y[0];
            Y3 <= y[2];
        end
    end

endmodule