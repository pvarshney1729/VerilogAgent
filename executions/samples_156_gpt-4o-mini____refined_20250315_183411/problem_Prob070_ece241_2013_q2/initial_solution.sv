[BEGIN]
```verilog
module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    // out_sop = a'b'cd' + ab'c'd + abc'd' + abcd
    always @(*) begin
        out_sop = 1'b0;
        out_sop |= (~a & ~b & c & ~d); // 2
        out_sop |= (a & ~b & ~c & d);  // 7
        out_sop |= (a & b & ~c & ~d);   // 15
    end

    // out_pos = (a + b + c + d)(a + b + c + ~d)(a + b + ~c + d)(a + ~b + c + d)(~a + b + c + d)
    always @(*) begin
        out_pos = 1'b1; // Initialize to logic-1
        out_pos &= (~a | ~b | ~c | ~d); // 0
        out_pos &= (~a | ~b | ~c | d);  // 1
        out_pos &= (~a | ~b | c | ~d);  // 4
        out_pos &= (~a | b | ~c | ~d);   // 5
        out_pos &= (a | ~b | ~c | ~d);   // 9
    end

endmodule
[DONE]