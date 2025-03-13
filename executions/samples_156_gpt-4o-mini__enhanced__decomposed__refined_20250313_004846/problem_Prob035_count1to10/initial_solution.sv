```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset counter to 1
    end else if (q == 4'b1010) begin
        q <= 4'b0001; // Wrap the counter back to 1
    end else begin
        q <= q + 4'b0001; // Increment the counter
    end
end

endmodule
```