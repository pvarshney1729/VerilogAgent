```verilog
[BEGIN]
module TopModule(
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [5:0] out_not
);

    // Bitwise OR operation
    always @(*) begin
        out_or_bitwise = a | b;
    end

    // Logical OR operation
    always @(*) begin
        out_or_logical = (|a) | (|b);
    end

    // Bitwise NOT operation
    always @(*) begin
        out_not[5:3] = ~b[2:0]; // Specify size for ~b
        out_not[2:0] = ~a[2:0]; // Specify size for ~a
    end

endmodule
[DONE]
```