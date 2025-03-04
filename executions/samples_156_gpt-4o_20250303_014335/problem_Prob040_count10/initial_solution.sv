module TopModule(
    input logic clk,       // Clock signal
    input logic reset,     // Active-high, synchronous reset
    output logic [3:0] q   // 4-bit counter output
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000;  // Wrap around from 9 to 0
        end else begin
            q <= q + 1;    // Increment counter
        end
    end

endmodule