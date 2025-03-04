```verilog
module TopModule (
    input wire a,
    input wire b,
    output wire out_assign,
    output wire out_alwaysblock
);
    // Using continuous assignment for out_assign
    assign out_assign = a & b;

    // Using combinational always block for out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end
endmodule
```