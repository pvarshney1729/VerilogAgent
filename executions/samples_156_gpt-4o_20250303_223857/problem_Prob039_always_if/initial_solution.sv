```verilog
module TopModule (
    input logic a,           // 1-bit input
    input logic b,           // 1-bit input
    input logic sel_b1,      // 1-bit input
    input logic sel_b2,      // 1-bit input
    output logic out_assign, // 1-bit output for assign-based mux
    output logic out_always  // 1-bit output for procedural if-based mux
);

assign out_assign = (sel_b1 & sel_b2) ? b : a;

always @(*) begin
    if (sel_b1 & sel_b2) 
        out_always = b;
    else 
        out_always = a;
end

endmodule
```