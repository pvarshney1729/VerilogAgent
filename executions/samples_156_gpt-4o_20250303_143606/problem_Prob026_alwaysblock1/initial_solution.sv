```verilog
module TopModule (
    input wire a,         // 1-bit input signal
    input wire b,         // 1-bit input signal
    output wire out_assign,       // 1-bit output signal driven by assign statement
    output reg out_alwaysblock    // 1-bit output signal driven by always block
);

    // Assign statement for combinational logic
    assign out_assign = a & b; // Logical AND operation

    // Always block for combinational logic
    always @(*) begin
        out_alwaysblock = a & b; // Logical AND operation
    end

endmodule
```