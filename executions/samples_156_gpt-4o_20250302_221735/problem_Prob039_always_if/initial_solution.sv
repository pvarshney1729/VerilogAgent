module TopModule(
    input logic a,       // Single bit input signal
    input logic b,       // Single bit input signal
    input logic sel_b1,  // Single bit input signal for selection
    input logic sel_b2,  // Single bit input signal for selection
    output logic out_assign, // Single bit output from combinational logic using assign
    output logic out_always  // Single bit output from combinational logic using procedural if
);

    // Combinational logic using assign statement
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Combinational logic using always block
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule