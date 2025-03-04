```verilog
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic d,
    output logic q
);

logic q_rising;
logic q_falling;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q_rising <= 1'b0;
    else
        q_rising <= d;
end

always_ff @(negedge clk or negedge rst_n) begin
    if (!rst_n)
        q_falling <= 1'b0;
    else
        q_falling <= d;
end

always_comb begin
    q = (clk) ? q_rising : q_falling;
end

endmodule
```