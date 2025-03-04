```verilog
module TopModule (
    input wire a,               // 1-bit input, unsigned
    input wire b,               // 1-bit input, unsigned
    output wire out_assign,     // 1-bit output
    output wire out_alwaysblock // 1-bit output
);

    // AND gate using assign statement
    assign out_assign = a & b;

    // AND gate using combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
```