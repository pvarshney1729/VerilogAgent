```
[BEGIN]
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);
    logic Q_int;

    always_ff @(posedge clk) begin
        if (L) begin
            Q_int <= r_in;
        end else begin
            Q_int <= q_in ^ Q_int;
        end
    end

    assign Q = Q_int;

endmodule
[DONE]
```