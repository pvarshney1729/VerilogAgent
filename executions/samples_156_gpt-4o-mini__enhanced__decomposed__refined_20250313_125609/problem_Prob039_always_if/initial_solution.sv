[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic sel_b1,
    input logic sel_b2,
    output logic out_assign,
    output logic out_always
);

    // Combinational logic for out_assign using assign statement
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Combinational logic for out_always using procedural if statement
    always @(*) begin
        if (sel_b1 && sel_b2) 
            out_always = b;
        else 
            out_always = a;
    end

endmodule
[DONE]