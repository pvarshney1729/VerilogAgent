module TopModule (
    input logic clk,      // Clock signal
    input logic reset,    // Active high synchronous reset signal
    output logic [9:0] q  // 10-bit counter output
);

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 10'd0; // Reset counter to 0
    end else if (q == 10'd999) begin
        q <= 10'd0; // Wrap around to 0
    end else begin
        q <= q + 10'd1; // Increment counter
    end
end

endmodule