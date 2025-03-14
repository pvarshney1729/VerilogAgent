module TopModule (
    input logic clk,           // Clock signal (1-bit input)
    input logic reset,         // Synchronous active-high reset signal (1-bit input)
    output logic [9:0] q       // 10-bit output representing the counter value
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b000000000; // Reset counter to 0
        end else begin
            if (q < 10'd999) begin
                q <= q + 10'b0000000001; // Increment counter
            end else begin
                q <= 10'b000000000; // Wrap around to 0
            end
        end
    end

endmodule