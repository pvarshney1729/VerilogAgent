```verilog
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

always @(posedge clk) begin
    if (a) 
        q <= 1'b1;
    else 
        q <= q;
end

endmodule
```