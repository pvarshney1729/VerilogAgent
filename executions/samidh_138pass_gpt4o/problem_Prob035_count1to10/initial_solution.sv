```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock input, triggers on the positive edge
    input logic reset,         // Active high synchronous reset
    output logic [3:0] q       // 4-bit unsigned output for the decade counter
);

    // Initial block to set the initial state of q to 1
    initial begin
        q = 4'b0001;
    end

    // Sequential logic for the decade counter
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset the counter to 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001; // Wrap around to 1 after reaching 10
        end else begin
            q <= q + 4'b0001; // Increment the counter
        end
    end

endmodule
[DONE]
```