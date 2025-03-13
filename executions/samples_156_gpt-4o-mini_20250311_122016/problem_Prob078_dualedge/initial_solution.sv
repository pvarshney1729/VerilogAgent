```
[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    input logic rst, // Synchronous reset
    output logic q
);

always @(posedge clk) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end

always @(negedge clk) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
[DONE]
```