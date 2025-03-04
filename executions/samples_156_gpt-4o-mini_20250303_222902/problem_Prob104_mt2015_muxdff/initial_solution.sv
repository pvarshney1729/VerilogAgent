```verilog
module TopModule (
    logic clk,
    logic L,
    logic q_in,
    logic r_in,
    logic Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
```