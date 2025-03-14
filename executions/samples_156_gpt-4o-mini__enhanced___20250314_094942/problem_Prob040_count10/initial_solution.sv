module TopModule (
    input logic clk,         // Clock signal (1 bit)
    input logic reset,       // Reset signal (1 bit), active high synchronous
    output logic [3:0] q     // 4-bit output representing the counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0
    end else begin
        if (q == 4'b1001) begin // When counter is 9 (4'b1001)
            q <= 4'b0000; // Wrap around to 0
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
end

endmodule