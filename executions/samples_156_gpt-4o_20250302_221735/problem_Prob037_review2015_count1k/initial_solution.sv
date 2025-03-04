module TopModule (
    input logic clk,        // Clock signal, 1-bit, rising edge triggered
    input logic reset,      // Reset signal, 1-bit, active high, synchronous
    output logic [9:0] q    // 10-bit counter output, bit[9] is MSB, bit[0] is LSB
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 10'b0; // Reset counter to 0
        end else if (q == 10'd999) begin
            q <= 10'b0; // Wrap around to 0 when reaching 999
        end else begin
            q <= q + 10'b1; // Increment counter
        end
    end

endmodule