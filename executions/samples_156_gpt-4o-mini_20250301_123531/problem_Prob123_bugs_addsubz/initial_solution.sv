module TopModule (
    input logic do_sub,               // 1-bit control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,              // 8-bit unsigned input operand 'a'
    input logic [7:0] b,              // 8-bit unsigned input operand 'b'
    output logic [7:0] out,           // 8-bit unsigned output result
    output logic result_is_zero       // 1-bit flag, high when `out` is zero
);

always @(*) begin
    // Determine the operation: addition or subtraction
    if (do_sub == 1'b0) begin
        out = a + b;                 // Perform addition when `do_sub` is 0
    end else begin
        out = a - b;                 // Perform subtraction when `do_sub` is 1
    end

    // Set the zero flag based on the result
    result_is_zero = (out == 8'b0);
end

endmodule