```verilog
module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous active-high reset signal
    output logic [3:0] q   // 4-bit output counter
);

    // Sequential logic for the counter
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset the counter to 0
        end else begin
            q <= q + 1'b1; // Increment the counter
        end
    end

endmodule
```