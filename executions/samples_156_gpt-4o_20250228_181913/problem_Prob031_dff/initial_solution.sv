```verilog
module TopModule (
    input logic clk,
    input logic d,
    input logic reset_n,
    output logic q
);

always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        q <= 1'b0;  // Asynchronous reset to 0
    else
        q <= d;     // Capture d on positive edge of clk
end

endmodule
```