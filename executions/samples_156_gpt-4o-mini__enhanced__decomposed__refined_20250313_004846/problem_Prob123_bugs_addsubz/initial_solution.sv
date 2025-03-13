```
[BEGIN]
module TopModule (
    input logic do_sub,               // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,              // 8-bit input operand A, unsigned
    input logic [7:0] b,              // 8-bit input operand B, unsigned
    output logic [7:0] out,           // 8-bit result of operation
    output logic result_is_zero       // Flag indicating if the result is zero
);

always @(*) begin
    // Perform operation based on `do_sub`
    case (do_sub)
        1'b0: out = a + b;               // Addition
        1'b1: out = a - b;               // Subtraction
        default: out = 8'h00;            // Default case for safety, output zero
    endcase

    // Determine if the result is zero
    result_is_zero = (out == 8'b0);     // Set zero flag if `out` is zero
end

endmodule
[DONE]
```