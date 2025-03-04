module TopModule (
    input logic do_sub,          // Control signal for operation selection
    input logic [7:0] a,         // 8-bit input operand
    input logic [7:0] b,         // 8-bit input operand
    output logic [7:0] out,      // 8-bit result of operation
    output logic result_is_zero  // Zero flag indicating if result is zero
);

    // Combinational Logic for Operation:
    always_comb begin
        // Perform addition or subtraction based on do_sub control signal
        if (do_sub == 1'b0) begin
            out = a + b;  // Addition operation
        end else begin
            out = a - b;  // Subtraction operation
        end

        // Zero flag logic
        // Explicitly compare 'out' with zero to set the zero flag
        if (out == 8'b00000000) begin
            result_is_zero = 1'b1;  // Set zero flag if result is zero
        end else begin
            result_is_zero = 1'b0;  // Clear zero flag if result is non-zero
        end
    end

endmodule