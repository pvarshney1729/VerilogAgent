module TopModule(
    input wire a,
    input wire b,
    input wire sel_b1,
    input wire sel_b2,
    output wire out_assign,
    output wire out_always
);

    // Assign-based mux
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Procedural always block mux
    reg out_always_reg;
    assign out_always = out_always_reg;

    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always_reg = b;
        else
            out_always_reg = a;
    end

endmodule