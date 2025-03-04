`timescale 1ns/1ps

module TopModule (
    input logic do_sub,               // Control signal: 0 for addition, 1 for subtraction
    input logic [7:0] a,              // 8-bit unsigned input operand
    input logic [7:0] b,              // 8-bit unsigned input operand
    output logic [8:0] out,           // 9-bit output to accommodate overflow
    output logic result_is_zero       // Output flag indicating if result is zero
);

    // Combinational logic block
    always @(*) begin
        // Default assignment
        out = 9'b0; // Initialize to zero for completeness
        result_is_zero = 1'b0; // Assume non-zero result initially

        // Adder-subtractor logic
        case (do_sub)
            1'b0: out = {1'b0, a} + {1'b0, b};  // Addition with overflow bit
            1'b1: out = {1'b0, a} - {1'b0, b};  // Subtraction with overflow bit
            default: out = 9'bx; // Undefined for completeness, though 1-bit do_sub should not have other values
        endcase

        // Zero flag logic
        if (out[7:0] == 8'b0) begin
            result_is_zero = 1'b1; // Set zero flag if lower 8 bits of `out` are zero
        end
    end

endmodule