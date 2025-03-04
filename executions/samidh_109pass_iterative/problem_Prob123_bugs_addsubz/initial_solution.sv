module TopModule (
    input wire [7:0] a,             // 8-bit unsigned input operand
    input wire [7:0] b,             // 8-bit unsigned input operand
    input wire do_sub,              // Control signal: 0 for addition, 1 for subtraction
    output reg [7:0] out,           // 8-bit unsigned output result
    output reg result_is_zero       // Output flag: 1 if result is zero, 0 otherwise
);

// Always block for combinational logic
// Computes the result based on the control signal 'do_sub'
always @(*) begin
    // Perform addition or subtraction based on 'do_sub' control signal
    if (do_sub == 1'b0) begin
        out = a + b;               // Addition operation
    end else begin
        out = a - b;               // Subtraction operation
    end

    // Set the zero flag based on the result
    if (out == 8'b00000000) begin  // Check if the result is zero
        result_is_zero = 1'b1;     // Set flag to 1 if zero
    end else begin
        result_is_zero = 1'b0;     // Set flag to 0 otherwise
    end
end

endmodule