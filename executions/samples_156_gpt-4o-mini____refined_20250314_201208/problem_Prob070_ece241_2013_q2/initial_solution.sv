[BEGIN]
```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    always @(*) begin
        // out_sop: Generates logic-1 for inputs corresponding to 2, 7, 15
        out_sop = (a == 1'b0 && b == 1'b0 && c == 1'b1 && d == 1'b0) || // 2
                   (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b1) || // 7
                   (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b1);   // 15

        // out_pos: Generates logic-0 for inputs corresponding to 0, 1, 4, 5, 6, 9, 10, 13, 14
        out_pos = !((a == 1'b0 && b == 1'b0 && c == 1'b0 && d == 1'b0) || // 0
                     (a == 1'b0 && b == 1'b0 && c == 1'b0 && d == 1'b1) || // 1
                     (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b0) || // 4
                     (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b1) || // 5
                     (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b0) || // 6
                     (a == 1'b1 && b == 1'b0 && c == 1'b0 && d == 1'b1) || // 9
                     (a == 1'b1 && b == 1'b0 && c == 1'b1 && d == 1'b0) || // 10
                     (a == 1'b1 && b == 1'b1 && c == 1'b0 && d == 1'b1) || // 13
                     (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b0));   // 14
    end

endmodule
```
[DONE]