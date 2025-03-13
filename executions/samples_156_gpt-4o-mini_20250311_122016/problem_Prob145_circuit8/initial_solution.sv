```
[BEGIN]
module TopModule (
    input logic clock,
    input logic a,
    input logic reset_n,
    output logic p,
    output logic q
);

always @(posedge clock) begin
    if (!reset_n) begin
        p <= 1'b0;
        q <= 1'b0;
    end else begin
        p <= a;

        if (p && a) begin
            q <= ~q;
        end
    end
end

endmodule
[DONE]
```