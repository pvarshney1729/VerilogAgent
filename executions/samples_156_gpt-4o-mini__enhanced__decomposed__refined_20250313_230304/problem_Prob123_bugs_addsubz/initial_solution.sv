[BEGIN]
module TopModule (
    input logic do_sub,                // Control signal: 1-bit, 0 for addition, 1 for subtraction
    input logic [7:0] a,               // Input operand A: 8 bits (MSB: a[7], LSB: a[0])
    input logic [7:0] b,               // Input operand B: 8 bits (MSB: b[7], LSB: b[0])
    output logic [7:0] out,            // Output result: 8 bits (MSB: out[7], LSB: out[0])
    output logic result_is_zero        // Output zero flag: 1-bit (0: not zero, 1: zero)
);

    always @(*) begin
        // Default the result_is_zero flag
        result_is_zero = 1'b0; // Initialize flag

        // Perform addition or subtraction based on do_sub control signal
        case (do_sub)
            1'b0: out = a + b; // Addition
            1'b1: out = a - b; // Subtraction
            default: out = 8'b0; // Fallback to avoid latches
        endcase

        // Set result_is_zero flag if out is zero
        if (out == 8'b0) begin
            result_is_zero = 1'b1; // Set flag if result is zero
        end
    end

endmodule
[DONE]