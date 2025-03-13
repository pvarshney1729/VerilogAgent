```verilog
[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic sel_b1,
    input logic sel_b2,
    output logic out_assign,
    output logic out_always
);

    // Continuous assignment for out_assign
    assign out_assign = (sel_b1 == 1'b1 && sel_b2 == 1'b1) ? b : a;

    // Procedural assignment for out_always
    always @(*) begin
        if (sel_b1 == 1'b1 && sel_b2 == 1'b1)
            out_always = b;
        else
            out_always = a;
    end

endmodule
[DONE]
```