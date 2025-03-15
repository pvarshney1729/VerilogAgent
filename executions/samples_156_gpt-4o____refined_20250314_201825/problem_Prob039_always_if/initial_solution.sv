module TopModule (
    input  logic a,
    input  logic b,
    input  logic sel_b1,
    input  logic sel_b2,
    output logic out_assign,
    output logic out_always
);

    // 2-to-1 MUX using assign statement
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // 2-to-1 MUX using always block
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule