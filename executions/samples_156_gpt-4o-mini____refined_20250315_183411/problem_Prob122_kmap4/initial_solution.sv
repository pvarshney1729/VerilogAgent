[BEGIN]
```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (c == 1'b0 && d == 1'b0 && b == 1'b0) ? 1'b0 :
              (c == 1'b0 && d == 1'b0 && b == 1'b1) ? 1'b1 :
              (c == 1'b0 && d == 1'b1 && b == 1'b0) ? 1'b1 :
              (c == 1'b0 && d == 1'b1 && b == 1'b1) ? 1'b0 :
              (c == 1'b1 && d == 1'b0 && b == 0) ? 1'b1 :
              (c == 1'b1 && d == 1'b0 && b == 1'b1) ? 1'b0 :
              (c == 1'b1 && d == 1'b1 && b == 1'b0) ? 1'b1 :
              (c == 1'b1 && d == 1'b1 && b == 1'b1) ? 1'b0 :
              1'b0; // Default case
    end

endmodule
```
[DONE]