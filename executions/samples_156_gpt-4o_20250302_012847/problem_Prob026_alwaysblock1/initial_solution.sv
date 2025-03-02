```verilog
module TopModule (
    input wire a,         // 1-bit input signal
    input wire b,         // 1-bit input signal
    output wire out_assign,    // 1-bit output signal using assign statement
    output wire out_alwaysblock // 1-bit output signal using always block
);

    // Combinational logic using assign statement
    assign out_assign = a & b;

    // Combinational logic using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
```