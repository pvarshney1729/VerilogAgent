module TopModule (
    input logic clk,        // Positive-edge-triggered clock signal
    input logic reset,      // Active-high, synchronous reset signal
    output logic [3:0] q    // 4-bit output, q[3] is MSB, q[0] is LSB
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;   // Reset counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000; // Wrap around to 0 after reaching 9
            end else begin
                q <= q + 1'b1; // Increment counter
            end
        end
    end

endmodule