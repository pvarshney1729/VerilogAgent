```
[BEGIN]
module TopModule (
    input  logic clk,        // Clock input (1 bit)
    input  logic reset,      // Active high synchronous reset (1 bit)
    output logic [3:0] q     // 4-bit output representing the counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset counter to 1 when reset is high
    end else if (q < 4'b1010) begin
        q <= q + 1;   // Increment counter if it is less than 10 (4'b1010)
    end else begin
        q <= 4'b0001; // Roll over to 1 after reaching 10
    end
end

initial begin
    q = 4'b0001; // Set initial counter value to 1
end

endmodule
[DONE]
```