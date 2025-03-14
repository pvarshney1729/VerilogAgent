module TopModule (
    input logic a,            // 1-bit input signal a
    input logic b,            // 1-bit input signal b
    input logic sel_b1,       // 1-bit selection signal (first part)
    input logic sel_b2,       // 1-bit selection signal (second part)
    output logic out_assign,   // 1-bit output signal for assign statement implementation
    output logic out_always    // 1-bit output signal for procedural if statement implementation
);

assign out_assign = (sel_b1 && sel_b2) ? b : a;  // Combinational assignment

always @(*) begin
    if (sel_b1 && sel_b2) begin
        out_always = b;  // Choose b if both sel_b1 and sel_b2 are HIGH
    end else begin
        out_always = a;  // Otherwise, choose a
    end
end

endmodule