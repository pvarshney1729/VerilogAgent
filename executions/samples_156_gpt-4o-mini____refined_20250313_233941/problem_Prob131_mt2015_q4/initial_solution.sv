```
[BEGIN]
module A (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x ^ y) & x;
    end
endmodule

module B (
    input logic x,
    input logic y,
    output logic z
);
    always @(*) begin
        z = (x == 1'b0 && y == 1'b0) ? 1'b1 : 
            (x == 1'b1 && y == 1'b0) ? 1'b0 : 
            (x == 1'b0 && y == 1'b1) ? 1'b0 : 
            (x == 1'b1 && y == 1'b1) ? 1'b1 : 
            1'b0;
    end
endmodule

module top_module (
    input logic x,
    input logic y,
    output logic z
);
    logic a1_out, a2_out, b1_out, b2_out;
    logic or_out, and_out;

    A a1 (.x(x), .y(y), .z(a1_out));
    B b1 (.x(x), .y(y), .z(b1_out));
    A a2 (.x(x), .y(y), .z(a2_out));
    B b2 (.x(x), .y(y), .z(b2_out));

    always @(*) begin
        or_out = a1_out | b1_out;
        and_out = a2_out & b2_out;
        z = or_out ^ and_out;
    end
endmodule
[DONE]
```