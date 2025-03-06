```verilog
[BEGIN]
module TopModule (
    input logic clock,
    input logic reset,
    input logic a,
    output logic p,
    output logic q
);

    always @(posedge clock) begin
        if (reset) begin
            p <= 1'b0;
            q <= 1'b0;
        end else begin
            p <= a;
            q <= p;
        end
    end

endmodule
[DONE]
```