module TopModule (
    input logic do_sub,                   // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,                  // 8-bit unsigned input operand 'a'
    input logic [7:0] b,                  // 8-bit unsigned input operand 'b'
    output logic [7:0] out,               // 8-bit unsigned result of the operation
    output logic result_is_zero           // Flag indicating if result is zero
);

    always @(*) begin
        // Combinational logic to perform addition or subtraction based on do_sub
        if (do_sub == 1'b0) begin
            out = a + b;                // Perform addition
        end else begin
            out = a - b;                // Perform subtraction
        end

        // Determine if the result is zero
        if (out == 8'b0) begin
            result_is_zero = 1'b1;      // Set zero flag if result is zero
        end else begin
            result_is_zero = 1'b0;      // Clear zero flag otherwise
        end
    end

endmodule