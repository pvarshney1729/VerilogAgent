```verilog
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

always @(posedge clk) begin
    if (L)
        Q <= r_in;
    else
        Q <= q_in;
end

endmodule
```