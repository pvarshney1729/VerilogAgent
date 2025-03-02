module TopModule (
    input logic clk,             // Clock input, positive edge-triggered
    input logic reset,           // Active high synchronous reset
    input logic slowena,         // Control signal to enable counting
    output logic [3:0] q         // 4-bit output representing the current counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset the counter to 0
    end else if (slowena) begin
        if (q == 4'b1001) // If current value is 9
            q <= 4'b0000; // Wrap around to 0
        else
            q <= q + 1;   // Increment the counter
    end
    // If slowena is low, maintain current value of q
end

endmodule