[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else begin
            q <= (q == 4'b1111) ? 4'b0000 : q + 1; // Increment and wrap around after 15
        end
    end

endmodule
```
[DONE]