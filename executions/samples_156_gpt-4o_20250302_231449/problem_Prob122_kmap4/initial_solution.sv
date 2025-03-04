module TopModule (
    input logic a,    // Input bit a
    input logic b,    // Input bit b
    input logic c,    // Input bit c
    input logic d,    // Input bit d
    output logic out  // Output bit out
);

    assign out = (~c & ~a & b) | (~c & d & ~b) | (c & ~d & a) | (c & d & ~a);

endmodule