```verilog
module TopModule (
    input logic clk,        // 1-bit clock signal, positive edge-triggered
    input logic reset,      // 1-bit active-high synchronous reset signal
    output logic [3:0] q    // 4-bit output representing the counter value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset to binary 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001;  // Roll over to binary 1 after reaching 10
        end else begin
            q <= q + 1;    // Increment counter
        end
    end

endmodule
```