```verilog
[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);
    
    always @(*) begin
        out_sop = (a & ~b & ~c & d) | // 2
                  (~a & b & c & d) | // 7
                  (a & b & c & d);   // 15
    end

    always @(*) begin
        out_pos = (~(a & b & c & d)) & // 0
                  (~(a & b & c & ~d)) & // 1
                  (~(a & ~b & c & ~d)) & // 4
                  (~(a & ~b & ~c & d)) & // 5
                  (~(a & ~b & ~c & ~d)) & // 6
                  (~(~a & b & ~c & d)) & // 9
                  (~(~a & b & c & ~d)) & // 10
                  (~(~a & ~b & c & d)) & // 13
                  (~(~a & b & c & d));   // 14
    end

endmodule
[DONE]
```