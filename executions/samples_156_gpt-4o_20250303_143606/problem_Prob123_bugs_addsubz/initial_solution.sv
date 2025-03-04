```verilog
module TopModule (
    input logic do_sub,           // 1-bit signal to select operation: 0 for addition, 1 for subtraction
    input logic [7:0] a,          // 8-bit input operand a
    input logic [7:0] b,          // 8-bit input operand b
    output logic [7:0] out,       // 8-bit output result of the operation
    output logic result_is_zero   // 1-bit output flag indicating if the result is zero
);

// Combinational Logic
always @(*) begin
    // Perform operation based on `do_sub` control signal
    if (do_sub == 1'b0) begin
        out = a + b;  // Perform addition
    end else begin
        out = a - b;  // Perform subtraction
    end

    // Set the zero flag based on the result
    result_is_zero = (out == 8'b0);
end

endmodule
```