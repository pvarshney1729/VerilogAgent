[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic slowena,
    output logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset state
    end else if (slowena) begin
        if (q == 4'b1001) begin
            q <= 4'b0000; // Wrap around from 9 to 0
        end else begin
            q <= q + 1; // Increment counter
        end
    end
end

endmodule
```
[DONE]