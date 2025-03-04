module TopModule (
    logic a,    // 1-bit input
    logic b,    // 1-bit input
    logic sel,  // 1-bit select line
    logic out   // 1-bit output
);
    // Combinational logic
    assign out = sel ? b : a;
endmodule