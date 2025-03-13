```verilog
[BEGIN]
module TopModule (
    input  logic [2:0] a,                 // 3-bit unsigned input vector a
    input  logic [2:0] b,                 // 3-bit unsigned input vector b
    output logic [2:0] out_or_bitwise,    // 3-bit unsigned output for bitwise OR
    output logic       out_or_logical,    // 1-bit output for logical OR
    output logic [5:0] out_not            // 6-bit unsigned output for NOT operation
);

    // Combinational logic
    always @(*) begin
        // Bitwise OR operation
        out_or_bitwise = a | b;

        // Logical OR operation
        out_or_logical = (|a) || (|b);

        // NOT operation
        out_not[5:3] = ~b;
        out_not[2:0] = ~a;
    end

endmodule
[DONE]
```