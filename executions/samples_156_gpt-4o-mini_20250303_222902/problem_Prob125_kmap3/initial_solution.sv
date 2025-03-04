module TopModule (
    logic a,
    logic b,
    logic c,
    logic d,
    logic out
);
    assign out = (~b & c) | (b & a & c) | (b & ~a & ~c) | (b & ~a & d);
endmodule