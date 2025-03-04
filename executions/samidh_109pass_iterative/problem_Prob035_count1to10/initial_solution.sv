module TopModule (
    input  logic clk,        // Clock input
    input  logic reset,      // Active high synchronous reset
    output logic [3:0] q     // 4-bit output, unsigned
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;    // Reset to 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001;    // Wrap around to 1 after 10
        end else begin
            q <= q + 1'b1;   // Increment counter
        end
    end

endmodule