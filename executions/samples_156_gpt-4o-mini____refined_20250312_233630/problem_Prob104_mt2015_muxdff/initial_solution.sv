```
[BEGIN]
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);
    logic Q_reg;

    always @(posedge clk) begin
        if (L) begin
            Q_reg <= r_in;
        end else begin
            Q_reg <= Q_reg ^ q_in;
        end
    end

    assign Q = Q_reg;

endmodule
[DONE]
```