[BEGIN]
```verilog
module TopModule (
    logic do_sub,               // 1-bit input, 0 for add, 1 for subtract
    logic [7:0] a,              // 8-bit unsigned input operand
    logic [7:0] b,              // 8-bit unsigned input operand
    logic [7:0] out,            // 8-bit unsigned output result
    logic result_is_zero        // 1-bit output, high if result is zero
);

    // Combinational Logic:
    always @(*) begin
        case (do_sub)
            1'b0: out = a + b;     // Perform addition
            1'b1: out = a - b;     // Perform subtraction
            default: out = 8'b0;   // Default case for safety, should be unreachable
        endcase

        // Set `result_is_zero` based on whether `out` is zero
        result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0;
    end

endmodule
```
[DONE]