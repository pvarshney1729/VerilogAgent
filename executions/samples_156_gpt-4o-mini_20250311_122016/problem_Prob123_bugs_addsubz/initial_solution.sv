module TopModule (
    input logic do_sub,             // 1-bit control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,            // 8-bit operand
    input logic [7:0] b,            // 8-bit operand
    output logic [7:0] out,          // 8-bit result of the operation
    output logic result_is_zero      // 1-bit zero flag: 1 if the result is zero, 0 otherwise
);

always @(*) begin
    // Perform addition or subtraction based on the `do_sub` signal
    case (do_sub)
        1'b0: out = a + b;      // Addition
        1'b1: out = a - b;      // Subtraction
        default: out = 8'b0;    // Default case for safety, though unnecessary
    endcase

    // Determine if the result is zero
    result_is_zero = (out == 8'b0);
end

endmodule