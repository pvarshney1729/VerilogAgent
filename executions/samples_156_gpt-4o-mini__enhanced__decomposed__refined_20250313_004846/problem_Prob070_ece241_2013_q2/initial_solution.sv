```
[BEGIN]
module TopModule (
    logic a,
    logic b,
    logic c,
    logic d,
    logic out_sop,
    logic out_pos
);

    // Combinational logic for out_sop
    always @(*) begin
        out_sop = (1'b0 & ~c & b & ~a) | // 2: 0010
                  (1'b0 & c & b & a)  | // 7: 0111
                  (d & c & b & a);     // 15: 1111
    end

    // Combinational logic for out_pos
    always @(*) begin
        out_pos = (d | ~c | ~b | a) & // Covers 0, 1, 4, 5, 6
                  (~d | ~c | b | a) & // Covers 9, 10
                  (~d | c | ~b | ~a); // Covers 13, 14
    end

endmodule
[DONE]
```