```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 10'd0; // Reset to 0
    end else if (q == 10'd999) begin
        q <= 10'd0; // Wrap around to 0
    end else begin
        q <= q + 1'b1; // Increment counter
    end
end

endmodule
```