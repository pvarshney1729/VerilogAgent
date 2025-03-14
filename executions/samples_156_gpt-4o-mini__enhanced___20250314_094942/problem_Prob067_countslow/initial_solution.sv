module TopModule (
    input logic clk,           // Clock input (positive edge triggered)
    input logic reset,         // Active high synchronous reset
    input logic slowena,       // Slow enable signal (active high)
    output logic [3:0] q       // 4-bit output representing the counter value
);

initial begin
    q = 4'b0000;              // Initialize counter to 0
end

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;         // Reset counter to 0
    end else if (slowena) begin
        if (q < 4'b1001) begin // If counter is less than 9 (decimal)
            q <= q + 1;       // Increment the counter
        end
    end
end

endmodule