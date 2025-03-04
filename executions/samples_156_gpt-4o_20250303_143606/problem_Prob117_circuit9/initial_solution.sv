```verilog
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic a,
    output logic [2:0] q
);

always @(posedge clk) begin
    if (!reset_n) begin
        q <= 3'b000; // Reset state
    end else if (a == 0) begin
        q <= q + 1; // Increment when a is 0
    end
    // No else needed as q holds its state when a == 1
end

endmodule
```