module TopModule (
    input logic a,         // 1-bit input signal 'a'
    input logic b,         // 1-bit input signal 'b'
    input logic sel_b1,    // 1-bit input signal 'sel_b1'
    input logic sel_b2,    // 1-bit input signal 'sel_b2'
    output logic out_assign, // 1-bit output signal using assign
    output logic out_always // 1-bit output signal using procedural if
);

    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule