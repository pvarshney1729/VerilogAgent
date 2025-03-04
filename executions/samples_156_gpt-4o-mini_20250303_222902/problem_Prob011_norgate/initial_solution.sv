module TopModule (
    logic a,
    logic b,
    logic out
);
    assign out = ~(a | b);
endmodule