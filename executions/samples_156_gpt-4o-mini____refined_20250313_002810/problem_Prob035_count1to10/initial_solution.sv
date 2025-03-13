[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset to 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001; // Reset to 1 after counting to 10
        end else begin
            q <= q + 4'b0001; // Increment the counter
        end
    end

    initial begin
        q = 4'b0000; // Initialize to zero in simulation
    end

endmodule
```
[DONE]