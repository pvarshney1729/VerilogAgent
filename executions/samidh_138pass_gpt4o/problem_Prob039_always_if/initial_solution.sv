```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic sel_b1,
    input logic sel_b2,
    output logic out_assign,
    output logic out_always
);

    // Continuous assignment implementation
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Procedural assignment implementation
    always @(*) begin
        if (sel_b1 && sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule
```