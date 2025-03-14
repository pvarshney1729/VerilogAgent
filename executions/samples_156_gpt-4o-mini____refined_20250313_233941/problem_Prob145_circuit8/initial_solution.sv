[BEGIN]
```verilog
module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);
    logic state;

    always @(posedge clock) begin
        if (state == 1'b0 && a == 1'b1) begin
            p <= 1'b1;
            q <= 1'b0;
            state <= 1'b1;
        end else if (state == 1'b1 && a == 1'b0) begin
            p <= 1'b0;
            q <= 1'b1;
            state <= 1'b0;
        end
    end

    initial begin
        p = 1'b0;
        q = 1'b0;
        state = 1'b0;
    end
endmodule
```
[DONE]