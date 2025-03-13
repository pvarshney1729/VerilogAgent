[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

always_ff @(posedge clk or posedge ar) begin
    if (ar)
        q <= 1'b0;  // Asynchronous reset sets q to 0
    else
        q <= d;     // Sample d on the positive edge of the clock
end

endmodule
```
[DONE]