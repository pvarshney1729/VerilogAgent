module TopModule (
    input logic do_sub,                      // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,                     // 8-bit input operand 'a'
    input logic [7:0] b,                     // 8-bit input operand 'b'
    output logic [7:0] out,                  // 8-bit result of the operation
    output logic result_is_zero              // Zero flag output, high if 'out' is zero
);

// Combinational Logic Description
// The module operates as a purely combinational circuit, with no clocked elements.
// It performs either addition or subtraction based on the 'do_sub' control signal.

always @(*) begin
    // Perform addition or subtraction based on control signal
    if (do_sub == 0) begin
        out = a + b;                        // Unsigned addition
    end else begin
        out = a - b;                        // Unsigned subtraction
    end

    // Determine if result is zero
    result_is_zero = (out == 8'b0000_0000); // Set high if 'out' is zero
end

endmodule