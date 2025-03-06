[BEGIN]
```verilog
module TopModule (
    input logic clk,       // 1-bit clock signal
    input logic reset,     // 1-bit synchronous active-high reset signal
    output logic [9:0] q   // 10-bit counter output
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 10'b0; // Reset counter to 0
        end else if (q == 10'd999) begin
            q <= 10'b0; // Reset counter to 0 after reaching 999
        end else begin
            q <= q + 10'b1; // Increment counter
        end
    end

endmodule
```
[DONE]