module TopModule (
    input logic a,        // Unsigned 1-bit input
    input logic b,        // Unsigned 1-bit input
    input logic sel_b1,   // Unsigned 1-bit input
    input logic sel_b2,   // Unsigned 1-bit input
    output logic out_assign, // Unsigned 1-bit output
    output logic out_always   // Unsigned 1-bit output
);

    // Continuous assignment for out_assign
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Procedural assignment for out_always
    always @* begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule