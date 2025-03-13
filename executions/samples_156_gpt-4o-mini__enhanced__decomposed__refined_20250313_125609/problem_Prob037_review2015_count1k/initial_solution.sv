[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 10'b0000000000;  // Reset output q to 0
    end else begin
        if (q < 10'd999) begin
            q <= q + 10'd1;    // Increment counter
        end else begin
            q <= 10'b0000000000; // Wrap around to 0 after reaching 999
        end
    end
end

endmodule
```
[DONE]