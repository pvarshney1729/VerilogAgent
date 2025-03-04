module EnhancedAdderSubtractor (
    input logic do_sub,          // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,         // 8-bit unsigned input operand A
    input logic [7:0] b,         // 8-bit unsigned input operand B
    output logic [7:0] out,      // 8-bit unsigned result of operation
    output logic result_is_zero  // Flag indicating if the result is zero
);

// Combinational logic block to perform arithmetic operations
always @(*) begin
    // Perform addition or subtraction based on the control signal
    if (do_sub) begin
        out = a - b;  // Subtraction when do_sub is 1
    end else begin
        out = a + b;  // Addition when do_sub is 0
    end

    // Set the zero flag if the result is zero
    result_is_zero = (out == 8'b00000000);
end

endmodule