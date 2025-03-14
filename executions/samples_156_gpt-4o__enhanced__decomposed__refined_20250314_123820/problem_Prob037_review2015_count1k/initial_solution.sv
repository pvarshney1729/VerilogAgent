[BEGIN]
module TopModule (
    input logic clk,            // Clock input, positive edge triggered
    input logic reset,          // Active high synchronous reset
    output logic [9:0] q        // 10-bit output representing counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 10'b0000000000;  // Reset state
        end else if (q == 10'd999) begin
            q <= 10'b0000000000;  // Wrap around
        end else begin
            q <= q + 1;           // Increment counter
        end
    end

endmodule
[DONE]