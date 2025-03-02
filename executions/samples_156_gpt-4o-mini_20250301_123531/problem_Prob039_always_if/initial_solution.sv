module TopModule (
    input logic a,         // 1-bit input signal
    input logic b,         // 1-bit input signal
    input logic sel_b1,    // 1-bit select signal
    input logic sel_b2,    // 1-bit select signal
    output logic out_assign, // 1-bit output signal using assign
    output logic out_always   // 1-bit output signal using procedural if
);

// Assign statement implementation
assign out_assign = (sel_b1 && sel_b2) ? b : a;

// Procedural if statement implementation
always @(*)
begin
    if (sel_b1 && sel_b2)
        out_always = b;
    else
        out_always = a;
end

endmodule