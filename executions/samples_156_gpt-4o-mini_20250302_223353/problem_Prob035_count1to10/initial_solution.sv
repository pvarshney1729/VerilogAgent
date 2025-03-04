module TopModule (
    input logic clk,        // Clock input, positive edge-triggered
    input logic reset,      // Active-high synchronous reset
    output logic [3:0] q    // 4-bit output, unsigned, LSB is bit[0]
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset counter to 1
        end else begin
            if (q == 4'b1010) begin
                q <= 4'b0001; // Wrap around to 1
            end else if (q < 4'b1010) begin
                q <= q + 1'b1; // Increment counter
            end else begin
                q <= 4'b0001; // Reset to 1 for invalid states
            end
        end
    end

endmodule