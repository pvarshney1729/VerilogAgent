```verilog
module TopModule (
    input logic a,          // 1-bit unsigned input signal a
    input logic b,          // 1-bit unsigned input signal b
    input logic sel_b1,     // 1-bit unsigned input signal sel_b1
    input logic sel_b2,     // 1-bit unsigned input signal sel_b2
    output logic out_assign, // 1-bit unsigned output signal for assign-based mux
    output logic out_always  // 1-bit unsigned output signal for procedural if-based mux
);

// Continuous assignment (combinational)
assign out_assign = (sel_b1 && sel_b2) ? b : a;

// Procedural logic (combinational)
always @(*) begin
    if (sel_b1 && sel_b2) begin
        out_always = b;
    end else begin
        out_always = a;
    end
end

endmodule
```